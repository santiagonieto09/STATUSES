import 'package:flutter/material.dart';
import 'package:statuses/ui/theme/app_theme.dart';

class ShimmerLoading extends StatefulWidget {
  final bool isGrid;

  const ShimmerLoading({super.key, this.isGrid = true});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGrid) {
      return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: 12,
        itemBuilder: (_, __) => _buildShimmerCard(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 10,
      itemBuilder: (_, __) => _buildShimmerListItem(),
    );
  }

  Widget _buildShimmerCard() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
            ),
            borderRadius: BorderRadius.circular(AppShapes.smallRadius),
          ),
        );
      },
    );
  }

  Widget _buildShimmerListItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          return Row(
            children: [
              _shimmerBox(48, 48, AppShapes.smallRadius),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(14, double.infinity, 4),
                    const SizedBox(height: 6),
                    _shimmerBox(12, 100, 4),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _shimmerBox(double height, double width, double radius) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
            Colors.grey[300]!,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment(_animation.value, 0),
          end: Alignment(_animation.value + 1, 0),
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
