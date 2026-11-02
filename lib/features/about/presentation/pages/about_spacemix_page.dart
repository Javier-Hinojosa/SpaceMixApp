import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_theme.dart';

@RoutePage()
class AboutSpacemixPage extends StatelessWidget {
  const AboutSpacemixPage({super.key});

  static const _logoUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAe491dqMR8sGkLcEFGZxjJsu0HJp1DvkN01thxhmkhHdS39hiTdhHPlB9jQpoy4cOocN-o62hIMYLbE1F5lU0XOYBe0npebnaIKSTeeKJS3LiLsRVDZz1pmJCj31Kj-G4Gq2D8aBg2jhiFqbVyBYHaBXX_TUH2AmYOAPDLABtriMJ2BhbKBbdLYNL0hVL0pGXkqYhqffxvQSfOIWOC7tKcbuH4sF3RGMhqGHCb5CORufxtOv0if3CfPGWlt-BtBys-Cx7y5a60a9jc';

  static const _architect1 =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDVRU_TH3s8CmeM_K0ZrYcKYr1Fw83RPkNgeanA5MegmeLly32EbG5nmpyagwXXWsgStau2TL3i-qnjZws-wTdTvnqLpEZTOYDMC7Bu8CrZzc2PNDnEwvn0kqyjHGT_kJ20_jzM8SywF9kzXKGCikh3w7M1dD-WaZlVcc0LLQEC0lS8XjZjDbeJ9DqT4iolujQROfykZWV4T7NM10E5cfbp7Tb8kszoD3lzLFEUl54Wxt7Tbfg7fcTEdpUHVW4Jh43EovwL_fMnER0s';

  static const _architect2 =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDKcYhZ8zFlGKTLxLmbbjxvWHh2CqhYt_qgMOzUVyBzFDg62bUyOUhzyyFyJy4OyjI2ctZepfvKqt7MPc_47aEgnWXvUUbh8ZnFFKCjkqNyCuA7Z-wQ78SScdzaLAA9FejiKksMXogOnvAtgUdkEzN_JKTE4bYIg3pTk47o_UjWpFkXIhBCtky3xx1jOmTI0Vm125aC4iiUCvQdWUWhP-zCAB5e3okhIKTlnU4eWAuo4kPRseIHY9vGF3n_zdq6V_2wP8NEdCp3vjXK';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background.withValues(alpha: 0.85),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => context.router.maybePop(),
        ),
        title: Text(
          'ABOUT',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                'SPACEMIX',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHero(context),
              const SizedBox(height: 36),
              _buildMission(context),
              const SizedBox(height: 36),
              _buildProtocols(context),
              const SizedBox(height: 36),
              _buildCredits(context),
              const SizedBox(height: 36),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppTheme.outlineVariant.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    'DESIGNED IN THE EVENT HORIZON',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurface.withValues(alpha: 0.85),
                          letterSpacing: 1.5,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.18),
                  blurRadius: 55,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Image.network(_logoUrl, fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),
          Text(
            'SpaceMix',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'V 4.2.0 "Nebula"',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.tertiary,
                  letterSpacing: 2.8,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMission(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Cosmic Rhythm',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'We believe sound is the vibration that binds the multiverse. '
            'SpaceMix was forged in the void to synchronize scattered frequencies '
            'of human existence, from distant stars to deep web hums.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.onSurface.withValues(alpha: 0.78),
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtocols(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Galactic Protocols',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Divider(
                color: AppTheme.outlineVariant.withValues(alpha: 0.2),
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 1,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3.9,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _ProtocolCard(icon: Icons.policy_outlined, title: 'Privacy Policy'),
            _ProtocolCard(icon: Icons.description_outlined, title: 'Terms of Service'),
            _ProtocolCard(icon: Icons.code_outlined, title: 'Open Source Licenses'),
          ],
        ),
      ],
    );
  }

  Widget _buildCredits(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Core Architects',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        _PersonTile(
          avatarUrl: _architect1,
          name: 'Lyra Vance',
          role: 'Chief Signal Officer',
        ),
        const SizedBox(height: 10),
        _PersonTile(
          avatarUrl: _architect2,
          name: 'Cyrus Kaelo',
          role: 'Lead Void Engineer',
        ),
        const SizedBox(height: 24),
        Text(
          'Stellar Contributors',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _ContributorChip('Elias Thorne'),
            _ContributorChip('Sola Aris'),
            _ContributorChip('Mako Vane'),
            _ContributorChip('Juno Rex'),
            _ContributorChip('Orion Bliss'),
            _ContributorChip('The Community'),
          ],
        ),
      ],
    );
  }
}

class _ProtocolCard extends StatelessWidget {
  const _ProtocolCard({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Icon(Icons.chevron_right, color: AppTheme.tertiary.withValues(alpha: 0.8)),
        ],
      ),
    );
  }
}

class _PersonTile extends StatelessWidget {
  const _PersonTile({
    required this.avatarUrl,
    required this.name,
    required this.role,
  });

  final String avatarUrl;
  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(avatarUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  role.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurface.withValues(alpha: 0.6),
                        letterSpacing: 1.1,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContributorChip extends StatelessWidget {
  const _ContributorChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

