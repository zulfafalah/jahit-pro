import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class HomeTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onSearchTap;

  const HomeTopAppBar({
    super.key,
    this.onMenuTap,
    this.onSearchTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF8F9FA),
      elevation: 0,
      scrolledUnderElevation: 1,
      leadingWidth: double.infinity,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            GestureDetector(
              onTap: onMenuTap,
              child: const Icon(
                Icons.menu,
                color: AppColors.primary,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "Jahit Pro",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: GestureDetector(
            onTap: onSearchTap,
            child: const Icon(
              Icons.search,
              color: AppColors.primary,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}
