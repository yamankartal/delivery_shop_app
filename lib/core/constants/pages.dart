import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/features/auth_feature/presentation/bloc/auth_bloc.dart';

import '../../features/home_feature/presentation/bloc/home_bloc.dart';
import '../../features/home_feature/presentation/screens/home_screen.dart';
import '../../features/orders_feature/presentation/screens/archives_orders_screen.dart';
import '../../features/orders_feature/presentation/screens/pending_orders_screen.dart';
import '../../features/profile_feature/presentation/bloc/profile_bloc.dart';
import '../../features/profile_feature/presentation/screens/profile_screen.dart';
import '../../injection.dart';

List homePageScreens=[
  BlocProvider(create: (_)=>sl<HomeBloc>(),child: const HomeScreen()),
  const PendingOrdersScreen(),
  const ArchivedOrdersScreen(),
  MultiBlocProvider(providers: [
    BlocProvider(create: (_)=>sl<ProfileBloc>()),
    BlocProvider(create: (_)=>sl<AuthBloc>()),
  ], child: const ProfileScreen(),),
];



