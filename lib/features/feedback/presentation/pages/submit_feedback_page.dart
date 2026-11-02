import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

@RoutePage()
class SubmitFeedbackPage extends StatefulWidget {
  const SubmitFeedbackPage({super.key});

  @override
  State<SubmitFeedbackPage> createState() => _SubmitFeedbackPageState();
}

class _SubmitFeedbackPageState extends State<SubmitFeedbackPage> {
  static const int _maxChars = 500;
  static const List<String> _categories = <String>[
    'Audio Quality',
    'Navigation',
    'Visuals',
    'Other',
  ];

  final TextEditingController _messageController = TextEditingController();

  int _rating = 3;
  String _selectedCategory = _categories.first;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transmission sent. Thank you, explorer.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background.withValues(alpha: 0.85),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => context.router.maybePop(),
        ),
        title: Text(
          'Transmission Feedback',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Subtle nebula tint in the background.
            Positioned(
              top: 90,
              left: -80,
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primary.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              right: -70,
              top: 300,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.tertiary.withValues(alpha: 0.04),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHero(context),
                  const SizedBox(height: 28),
                  _buildRatingSection(context),
                  const SizedBox(height: 24),
                  _buildCategorySection(context),
                  const SizedBox(height: 24),
                  _buildMessageSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 22),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.background.withValues(alpha: 0),
              AppTheme.background.withValues(alpha: 0.9),
              AppTheme.background,
            ],
          ),
        ),
        child: SizedBox(
          height: 56,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.32),
                  blurRadius: 24,
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _sendFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.rocket_launch, color: AppTheme.onPrimary),
              label: Text(
                'Send Transmission',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBZNQJ20-7YmsSYaS60AIq94mPHfTLe4gbL9bLAauPrZlT4AqoBKjhH8Q98OStjDBh17P8-yeZ5kKZ5Ya9X9GgqJleBYgM_-TYOfsohNsLJjaNaWQsKdcWIDj5d_jeX-bB1WaAOn29S-Q9wn-aBtwFkVGM4N9LfaVu51ILeouw9qIVkKAoximY50M5zMM3cyaQUBxv2-RgTA_ZY98iELJ0HDm0zGsqP1ouQniDAY3urVKHjO0EEML7GdyNqB3-VfYXBVV92-_pZkiu5',
          ),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
          opacity: 0.28,
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 220),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Refining the Beam',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      height: 0.95,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your feedback calibrates our interstellar frequency.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurface.withValues(alpha: 0.7),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Signal Quality',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            Text(
              'Frequency Check',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurface.withValues(alpha: 0.55),
                    letterSpacing: 1.4,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: List.generate(5, (index) {
              final selected = index < _rating;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => setState(() => _rating = index + 1),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Icon(
                      Icons.monitor_heart,
                      size: 26,
                      color: selected
                          ? AppTheme.primary
                          : AppTheme.outlineVariant,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transmission Source',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedCategory = category),
              selectedColor: AppTheme.tertiary,
              backgroundColor: AppTheme.surfaceContainerHighest,
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppTheme.onTertiary
                        : AppTheme.onSurface.withValues(alpha: 0.8),
                  ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMessageSection(BuildContext context) {
    final charCount = _messageController.text.characters.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Transmission Logs',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            Text(
              '$charCount / $_maxChars',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.outlineVariant,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _messageController,
          maxLength: _maxChars,
          maxLines: 6,
          onChanged: (_) => setState(() {}),
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            counterText: '',
            hintText: 'Describe your cosmic experience...',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.outlineVariant,
                ),
            filled: true,
            fillColor: AppTheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppTheme.primary.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

