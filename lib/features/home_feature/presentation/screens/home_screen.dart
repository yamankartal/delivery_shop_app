import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/features/home_feature/presentation/bloc/home_bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/widgets.dart';
import '../widgets/acepting_canceling-percent_widget.dart';
import '../widgets/call_support_widget.dart';
import '../widgets/home_date_time_widget.dart';
import '../widgets/home_map_widget.dart';
import '../widgets/home_title_widget.dart';
import '../widgets/active_order_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetDateEvent());
    homeBloc.add(GetPositionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (p, c) => p.getDateState != c.getDateState,
      builder: (_, state) {
        if (state.getDateState == States.loading) {
          return circularProgressIndicatorWidget();
        } else if (state.getDateState == States.loaded) {
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: Res.font * 0.7, horizontal: Res.padding * 0.5),
            margin: EdgeInsets.only(top: Res.font * 1.5),
            width: Res.width,
            height: Res.fullHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeTitleWidget(homeBloc: homeBloc),
                  AcceptingCancelingPercentWidget(homeModel: state.homeModel),
                  const HomeDateTimeWidget(),
                  const HomeMapWidget(),
                  if(state.homeModel.deliveryStatus!>0)
                  ActiveOrdersWidget(homeBloc: homeBloc,homeModel: state.homeModel),
                  if(state.homeModel.deliveryStatus!<1)
                  SizedBox(height: Res.font,),
                  const CallSupportWidget(),
                ],
              ),
            ),
          );
        } else if (state.getDateState == States.error) {
          return errorWidget(state.errorMsg);
        }
        return Container();
      },
    );
  }
}
