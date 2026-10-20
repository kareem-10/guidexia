import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/features/saved/view/widgets/saved_app_bar.dart';
import 'package:tourist_app/features/saved/view/widgets/tabs/saved_guides_tab.dart';
import 'package:tourist_app/features/saved/view/widgets/tabs/saved_places_tab.dart';
import 'package:tourist_app/features/saved/view/widgets/tabs/saved_stays_tab.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: SavedAppBar(),
        ),
        body: TabBarView(
          children: [
            const SavedPlacesTab(),
            const SavedGuidesTab(),
            const SavedStaysTab(),
          ],
        ),
      ),
    );
  }
}
