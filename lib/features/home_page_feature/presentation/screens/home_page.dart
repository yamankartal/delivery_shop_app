import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/core/constants/fire_base.dart';
import 'package:shop_delivery/core/constants/responsive.dart';
import 'package:shop_delivery/features/home_page_feature/presentation/bloc/home_page_bloc.dart';
import 'package:shop_delivery/features/orders_feature/presentation/bloc/orders_bloc.dart';
import '../../../../core/constants/pages.dart';
import '../widgets/bottom_navigation_bar_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageBloc homePageBloc;

  @override
  void initState() {
    listenToNotification(BlocProvider.of<OrdersBloc>(context));
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    responsive(context);
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (p, c) => p.homeScreenIndex != c.homeScreenIndex,
      builder: (_, state) {
        return Scaffold(
          body: homePageScreens[state.homeScreenIndex],
          bottomNavigationBar: BottomAppBar(
            child: Container(
              padding: EdgeInsets.only(top: Res.tinyFont),
              height: Res.font * 2.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavigationBarItemWidget(
                      homePageBloc: homePageBloc,
                      iconData: Icons.home,
                      index: 0,
                      label: "Home"),
                  BottomNavigationBarItemWidget(
                      homePageBloc: homePageBloc,
                      iconData: Icons.pending,
                      index: 1,
                      label: "Pending"),
                  BottomNavigationBarItemWidget(
                      homePageBloc: homePageBloc,
                      iconData: Icons.archive_outlined,
                      index: 2,
                      label: "Archive"),
                  BottomNavigationBarItemWidget(
                      homePageBloc: homePageBloc,
                      iconData: Icons.person_outline_rounded,
                      index: 3,
                      label: "Profile"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
