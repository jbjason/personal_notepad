import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const AppBarDelegate({required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        // shadow Container
        ShadowContainer(containerColor: Colors.grey[600], radiusDouble: 168.0),
        ShadowContainer(containerColor: Colors.grey[700], radiusDouble: 185.0),
        ShadowContainer(containerColor: Colors.grey[800], radiusDouble: 205.0),
        ShadowContainer(containerColor: Colors.grey[850], radiusDouble: 230.0),
        // Main & Actual AppbarContainer
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(260))),
          child: Stack(
            children: [
              // shirken appbar
              _basicAppBar(shrinkOffset),
              // CustomAppbar, middle Container with "My notes" Title
              _getCustomAppBar(shrinkOffset),
            ],
          ),
        ),
      ],
    );
  }

  Widget _basicAppBar(double shrinkOffset) {
    return Opacity(
      opacity: appear(shrinkOffset),
      child: AppBar(
        leading: Icon(Icons.menu_open),
        title: const Text('All Notes', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.grey[900],
        elevation: 10,
        actions: [
          Icon(Icons.bookmark_add),
          const SizedBox(width: 12),
          Icon(Icons.search),
          const SizedBox(width: 12),
          Icon(Icons.more_horiz),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _getCustomAppBar(double shrinkOffset) {
    return Positioned(
      top: expandedHeight * .37,
      left: 0,
      right: 130,
      child: Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 45),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: Colors.grey.shade800,
                offset: const Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text('Your Notes',
              style: GoogleFonts.laBelleAurore(
                textStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 1,
                ),
              ),
              textAlign: TextAlign.left),
        ),
      ),
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    Key? key,
    required this.containerColor,
    required this.radiusDouble,
  }) : super(key: key);

  final Color? containerColor;
  final double radiusDouble;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          //  color: Colors.white,
          borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(radiusDouble)),
        ),
      ),
    );
  }
}
