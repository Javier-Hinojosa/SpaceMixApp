// Devuelve una URL prefirmada (SigV4) para reproducir un archivo del bucket privado de Backblaze B2.
// Secrets requeridos: B2_KEY_ID, B2_APP_KEY, B2_BUCKET, B2_REGION (ej. us-east-005)

const encoder = new TextEncoder();

const CORS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, apikey, content-type",
};

const toHex = (buf: ArrayBuffer) =>
  [...new Uint8Array(buf)].map((b) => b.toString(16).padStart(2, "0")).join("");

async function sha256Hex(data: string) {
  return toHex(await crypto.subtle.digest("SHA-256", encoder.encode(data)));
}

async function hmac(key: ArrayBuffer | string, data: string) {
  const raw = typeof key === "string" ? encoder.encode(key) : key;
  const cryptoKey = await crypto.subtle.importKey(
    "raw",
    raw,
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign"],
  );
  return crypto.subtle.sign("HMAC", cryptoKey, encoder.encode(data));
}

const rfc3986 = (s: string) =>
  encodeURIComponent(s).replace(/[!'()*]/g, (c) => `%${c.charCodeAt(0).toString(16).toUpperCase()}`);

async function presign(opts: {
  keyId: string;
  secret: string;
  bucket: string;
  region: string;
  objectKey: string;
  expires: number;
}) {
  const host = `${opts.bucket}.s3.${opts.region}.backblazeb2.com`;
  const now = new Date();
  const amzDate = now.toISOString().replace(/[:-]|\.\d{3}/g, "");
  const date = amzDate.slice(0, 8);
  const scope = `${date}/${opts.region}/s3/aws4_request`;

  const canonicalUri = "/" + opts.objectKey.split("/").map(rfc3986).join("/");

  const params: Record<string, string> = {
    "X-Amz-Algorithm": "AWS4-HMAC-SHA256",
    "X-Amz-Credential": `${opts.keyId}/${scope}`,
    "X-Amz-Date": amzDate,
    "X-Amz-Expires": String(opts.expires),
    "X-Amz-SignedHeaders": "host",
  };
  const canonicalQuery = Object.keys(params)
    .sort()
    .map((k) => `${rfc3986(k)}=${rfc3986(params[k])}`)
    .join("&");

  const canonicalRequest = [
    "GET",
    canonicalUri,
    canonicalQuery,
    `host:${host}\n`,
    "host",
    "UNSIGNED-PAYLOAD",
  ].join("\n");

  const stringToSign = [
    "AWS4-HMAC-SHA256",
    amzDate,
    scope,
    await sha256Hex(canonicalRequest),
  ].join("\n");

  const kDate = await hmac(`AWS4${opts.secret}`, date);
  const kRegion = await hmac(kDate, opts.region);
  const kService = await hmac(kRegion, "s3");
  const kSigning = await hmac(kService, "aws4_request");
  const signature = toHex(await hmac(kSigning, stringToSign));

  return `https://${host}${canonicalUri}?${canonicalQuery}&X-Amz-Signature=${signature}`;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });

  const json = (body: unknown, status = 200) =>
    new Response(JSON.stringify(body), {
      status,
      headers: { ...CORS, "Content-Type": "application/json" },
    });

  let file: string | undefined;
  let expires = 900;
  try {
    const url = new URL(req.url);
    if (req.method === "POST") {
      const body = await req.json();
      file = body.file;
      expires = Number(body.expires ?? expires);
    } else {
      file = url.searchParams.get("file") ?? undefined;
      expires = Number(url.searchParams.get("expires") ?? expires);
    }
  } catch {
    return json({ error: "Solicitud inválida" }, 400);
  }

  if (!file || file.includes("..") || file.startsWith("/") || file.length > 300) {
    return json({ error: "Parámetro 'file' inválido" }, 400);
  }
  expires = Math.min(Math.max(expires, 60), 3600);

  const keyId = Deno.env.get("B2_KEY_ID");
  const secret = Deno.env.get("B2_APP_KEY");
  const bucket = Deno.env.get("B2_BUCKET");
  const region = Deno.env.get("B2_REGION");
  const missing = Object.entries({
    B2_KEY_ID: keyId,
    B2_APP_KEY: secret,
    B2_BUCKET: bucket,
    B2_REGION: region,
  }).filter(([, v]) => !v).map(([k]) => k);
  if (missing.length > 0 || !keyId || !secret || !bucket || !region) {
    return json({ error: "Configuración de B2 incompleta", missing }, 500);
  }

  const signedUrl = await presign({ keyId, secret, bucket, region, objectKey: file, expires });
  return json({ url: signedUrl, expiresIn: expires });
});
