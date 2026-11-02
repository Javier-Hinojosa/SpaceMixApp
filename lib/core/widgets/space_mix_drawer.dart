import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../app_theme.dart';
import '../routing/app_router.dart';

/// Navigation items available in the SpaceMix Drawer.
enum DrawerItem { home, finder, downloads, saves }

/// Cosmic Editorial side-navigation drawer.
///
/// Shows the user profile header, primary navigation links, and secondary
/// utility links. Pass [activeItem] to highlight the current page.
class SpaceMixDrawer extends StatelessWidget {
  const SpaceMixDrawer({
    super.key,
    this.activeItem = DrawerItem.home,
    this.username = 'DjDeadLine',
    this.memberLabel = 'Premium Member',
    this.avatarUrl,
  });

  final DrawerItem activeItem;
  final String username;
  final String memberLabel;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.router.push(const ProfileRoute()),
            child: _ProfileHeader(
              username: username,
              memberLabel: memberLabel,
              avatarUrl: avatarUrl,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  active: activeItem == DrawerItem.home,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.replaceAll([const HomeRoute()]);
                  },
                ),
                _NavItem(
                  icon: Icons.search_rounded,
                  label: 'Finder',
                  active: activeItem == DrawerItem.finder,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(const FinderRoute());
                  },
                ),
                _NavItem(
                  icon: Icons.cloud_download_outlined,
                  label: 'Downloads',
                  active: activeItem == DrawerItem.downloads,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(const DownloadsRoute());
                  },
                ),
                _NavItem(
                  icon: Icons.bookmark_rounded,
                  label: 'Saves',
                  active: activeItem == DrawerItem.saves,
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(const LibraryRoute());
                  },
                ),
              ],
            ),
          ),
          // Secondary links
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                _SecondaryNavItem(
                  icon: Icons.feedback_outlined,
                  label: 'Submit Feedback',
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(const SubmitFeedbackRoute());
                  },
                ),
                _SecondaryNavItem(
                  icon: Icons.info_outline,
                  label: 'About',
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(const AboutSpacemixRoute());
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ─── Profile Header ────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.username,
    required this.memberLabel,
    this.avatarUrl,
  });

  final String username;
  final String memberLabel;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 56, 28, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.surface, AppTheme.surfaceContainerLow],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar with ambient glow
          Stack(
            alignment: Alignment.center,
            children: [
              // Glow ring
              Container(
                width: 102,
                height: 102,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.tertiary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 48,
                backgroundColor: AppTheme.surfaceVariant,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : const NetworkImage(AppConstants.dummyImagePlaceholder),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            username,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.tertiary.withValues(alpha: 0.4),
                  decorationThickness: 2,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            memberLabel.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}

// ─── Primary Nav Item ──────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              gradient: active ? AppTheme.primaryGradient : null,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: active ? AppTheme.onPrimary : Colors.white.withValues(alpha: 0.6),
                    size: 22,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: active
                              ? AppTheme.onPrimary
                              : Colors.white.withValues(alpha: 0.6),
                          fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Secondary Nav Item ────────────────────────────────────────────────────────

class _SecondaryNavItem extends StatelessWidget {
  const _SecondaryNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: Icon(icon, size: 18, color: Colors.white.withValues(alpha: 0.4)),
        label: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

