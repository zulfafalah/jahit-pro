import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/order_model.dart';
import '../../theme/app_colors.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
  });

  _OrderStatusStyle _getStatusStyle() {
    switch (order.status) {
      case OrderStatus.proses:
        return _OrderStatusStyle(
          label: 'Proses',
          badgeBackground: AppColors.surfaceContainerHighest,
          badgeTextColor: AppColors.onSurfaceVariant,
          borderColor: AppColors.primary,
          deadlineIcon: Icons.schedule,
          deadlineColor: AppColors.tertiary,
        );
      case OrderStatus.selesai:
        return _OrderStatusStyle(
          label: 'Selesai',
          badgeBackground: AppColors.secondaryContainer,
          badgeTextColor: AppColors.onSecondaryContainer,
          borderColor: AppColors.secondary,
          deadlineIcon: Icons.check_circle,
          deadlineColor: AppColors.secondary,
        );
      case OrderStatus.antrean:
        return _OrderStatusStyle(
          label: 'Antrean',
          badgeBackground: AppColors.surfaceContainerHighest,
          badgeTextColor: AppColors.onSurfaceVariant,
          borderColor: AppColors.primary,
          deadlineIcon: Icons.straighten,
          deadlineColor: AppColors.onSurfaceVariant,
        );
      case OrderStatus.terlambat:
        return _OrderStatusStyle(
          label: 'Terlambat',
          badgeBackground: AppColors.errorContainer,
          badgeTextColor: AppColors.onErrorContainer,
          borderColor: AppColors.error,
          deadlineIcon: Icons.warning_amber,
          deadlineColor: AppColors.error,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStatusStyle();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(color: style.borderColor, width: 8),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    order.customerName,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: style.badgeBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    style.label.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: style.badgeTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Item description
            Text(
              order.itemDescription,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            // Deadline row
            Row(
              children: [
                Icon(
                  style.deadlineIcon,
                  size: 16,
                  color: style.deadlineColor,
                ),
                const SizedBox(width: 6),
                Text(
                  order.deadlineLabel,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: style.deadlineColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderStatusStyle {
  final String label;
  final Color badgeBackground;
  final Color badgeTextColor;
  final Color borderColor;
  final IconData deadlineIcon;
  final Color deadlineColor;

  const _OrderStatusStyle({
    required this.label,
    required this.badgeBackground,
    required this.badgeTextColor,
    required this.borderColor,
    required this.deadlineIcon,
    required this.deadlineColor,
  });
}
