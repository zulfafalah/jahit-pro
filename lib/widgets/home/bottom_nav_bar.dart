import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/home_provider.dart';
import '../../theme/app_colors.dart';

class HomeBottomNavBar extends ConsumerWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant, width: 0.5),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home,
                label: 'Beranda',
                index: 0,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(bottomNavIndexProvider.notifier).state = i,
              ),
              _NavItem(
                icon: Icons.inventory_2_outlined,
                label: 'Pesanan',
                index: 1,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(bottomNavIndexProvider.notifier).state = i,
              ),
              _NavItem(
                icon: Icons.group_outlined,
                label: 'Pelanggan',
                index: 2,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(bottomNavIndexProvider.notifier).state = i,
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                label: 'Pengaturan',
                index: 3,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(bottomNavIndexProvider.notifier).state = i,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  bool get _isActive => currentIndex == index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isActive
              ? const Color(0xFFDCE6FF)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isActive ? _filledIcon : icon,
              color: _isActive ? AppColors.primary : AppColors.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color:
                    _isActive ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData get _filledIcon {
    switch (icon) {
      case Icons.home:
        return Icons.home;
      case Icons.inventory_2_outlined:
        return Icons.inventory_2;
      case Icons.group_outlined:
        return Icons.group;
      case Icons.settings_outlined:
        return Icons.settings;
      default:
        return icon;
    }
  }
}
