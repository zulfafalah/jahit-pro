import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/home_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/home/top_app_bar.dart';
import '../../widgets/home/summary_stat_card.dart';
import '../../widgets/home/order_card.dart';
import '../../widgets/home/bottom_nav_bar.dart';
import '../../widgets/home/section_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(dashboardStatsProvider);
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: HomeTopAppBar(
        onMenuTap: () {},
        onSearchTap: () {},
      ),
      bottomNavigationBar: const HomeBottomNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Welcome Header ────────────────────────────────────────
              const SizedBox(height: 32),
              Text(
                'DASHBOARD HARIAN',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ringkasan\nWorkshop',
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  height: 1.1,
                  letterSpacing: -1,
                ),
              ),

              // ── Summary Bento Cards ───────────────────────────────────
              const SizedBox(height: 32),
              _buildSummaryCards(stats),

              // ── Primary Action Button ─────────────────────────────────
              const SizedBox(height: 32),
              _AddOrderButton(
                onPressed: () {
                  // TODO: Navigate to add order screen
                },
              ),

              // ── Recent Orders ─────────────────────────────────────────
              const SizedBox(height: 32),
              SectionHeader(
                title: 'Pesanan Terbaru',
                actionLabel: 'LIHAT SEMUA',
                onActionTap: () {
                  // TODO: Navigate to all orders
                },
              ),
              const SizedBox(height: 16),
              ...orders.map(
                (order) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OrderCard(
                    order: order,
                    onTap: () {
                      // TODO: Navigate to order detail
                    },
                  ),
                ),
              ),

              // ── Visual Anchor ─────────────────────────────────────────
              const SizedBox(height: 16),
              const _QuoteCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(DashboardStats stats) {
    return Column(
      children: [
        // Full-width today card
        SummaryStatCard.todayOrders(value: stats.todayOrders.toString().padLeft(2, '0')),
        const SizedBox(height: 12),
        // Two-column row
        Row(
          children: [
            Expanded(
              child: SummaryStatCard.lateOrders(
                value: stats.lateOrders.toString().padLeft(2, '0'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryStatCard.completedOrders(
                value: stats.completedOrders.toString().padLeft(2, '0'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Add Order Button ──────────────────────────────────────────────────────────
class _AddOrderButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _AddOrderButton({required this.onPressed});

  @override
  State<_AddOrderButton> createState() => _AddOrderButtonState();
}

class _AddOrderButtonState extends State<_AddOrderButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.98,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) {
        _controller.forward();
        widget.onPressed();
      },
      onTapCancel: () => _controller.forward(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: AppColors.onPrimary, size: 22),
              const SizedBox(width: 10),
              Text(
                '+ Tambah Pesanan',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Quote Card ────────────────────────────────────────────────────────────────
class _QuoteCard extends StatelessWidget {
  const _QuoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.18),
          ],
        ),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Background pattern overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CustomPaint(
                painter: _FabricPatternPainter(),
              ),
            ),
          ),
          // Content
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Text(
              'Kualitas adalah pola yang kita jahit setiap hari.',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: AppColors.onSurface,
                height: 1.35,
              ),
            ),
          ),
          // Decorative icon
          Positioned(
            top: 20,
            right: 20,
            child: Icon(
              Icons.auto_awesome,
              color: AppColors.primary.withValues(alpha: 0.3),
              size: 48,
            ),
          ),
        ],
      ),
    );
  }
}

class _FabricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.04)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw subtle grid lines like fabric
    const spacing = 18.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
