import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class SummaryStatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color backgroundColor;
  final Color labelColor;
  final Color valueColor;
  final bool isLarge;

  const SummaryStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.labelColor,
    required this.valueColor,
    this.isLarge = false,
  });

  // Named constructors for common card variants
  const SummaryStatCard.todayOrders({
    super.key,
    required String value,
  })  : label = 'Pesanan Hari Ini',
        value = value,
        backgroundColor = AppColors.surfaceContainerLow,
        labelColor = AppColors.onSurfaceVariant,
        valueColor = AppColors.primary,
        isLarge = true;

  const SummaryStatCard.lateOrders({
    super.key,
    required String value,
  })  : label = 'Terlambat',
        value = value,
        backgroundColor = AppColors.errorContainer,
        labelColor = AppColors.onErrorContainer,
        valueColor = AppColors.error,
        isLarge = false;

  const SummaryStatCard.completedOrders({
    super.key,
    required String value,
  })  : label = 'Selesai',
        value = value,
        backgroundColor = AppColors.secondaryContainer,
        labelColor = AppColors.onSecondaryContainer,
        valueColor = AppColors.onSecondaryContainer,
        isLarge = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: isLarge ? 56 : 40,
                  fontWeight: FontWeight.w900,
                  color: valueColor,
                  height: 1.0,
                ),
              ),
              if (isLarge) ...[
                const SizedBox(width: 8),
                Text(
                  'UNIT',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: labelColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
