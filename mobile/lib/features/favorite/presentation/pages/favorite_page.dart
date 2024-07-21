import 'package:flutter/material.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widget/custom_appbar_widget.dart';
import 'package:transittrack/core/widget/custom_navbar_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBarWidget(),
        body: Center(
          child: Text('Favorite Page'),
        ),
        bottomNavigationBar: CustomNavbarWidget(),
      ),
    );;
  }
}