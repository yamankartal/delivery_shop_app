import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_delivery/features/auth_feature/data/repository/repository.dart';
import 'package:shop_delivery/features/delivering_feature/data/sources/remote.dart';
import 'package:shop_delivery/features/delivering_feature/domain/use_case/get_current_location.dart';
import 'package:shop_delivery/features/delivering_feature/presentation/bloc/delivering_bloc.dart';
import 'package:shop_delivery/features/home_feature/domain/use_case/get_data.dart';
import 'package:shop_delivery/features/home_page_feature/presentation/bloc/home_page_bloc.dart';
import 'package:shop_delivery/features/orders_feature/domain/use_case/get_pending_orders_case.dart';
import 'core/constants/fire_base.dart';
import 'features/auth_feature/data/sources/local.dart';
import 'features/auth_feature/data/sources/remote.dart';
import 'features/auth_feature/domain/repository/repository.dart';
import 'features/auth_feature/domain/use_case/is_sign_in_case.dart';
import 'features/auth_feature/domain/use_case/sign_in_case.dart';
import 'features/auth_feature/domain/use_case/sign_out_case.dart';
import 'features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'features/delivering_feature/data/repository/repository.dart';
import 'features/delivering_feature/domain/repository/repository.dart';
import 'features/delivering_feature/domain/use_case/arriving_to_shop_stage_case.dart';
import 'features/delivering_feature/domain/use_case/done_order_stage_case.dart';
import 'features/delivering_feature/domain/use_case/get_polyline_case.dart';
import 'features/delivering_feature/domain/use_case/in_shop_case.dart';
import 'features/delivering_feature/domain/use_case/leaving_shop_stage_case.dart';
import 'features/delivering_feature/domain/use_case/to_customer_case.dart';
import 'features/delivering_feature/domain/use_case/to_shop_case.dart';
import 'features/delivering_feature/domain/use_case/update_location_case.dart';
import 'features/home_feature/data/repository/repository.dart';
import 'features/home_feature/data/sources/remote.dart';
import 'features/home_feature/domain/repository/repository.dart';
import 'features/home_feature/domain/use_case/close_status.dart';
import 'features/home_feature/domain/use_case/get_position_case.dart';
import 'features/home_feature/domain/use_case/open_status_case.dart';
import 'features/home_feature/presentation/bloc/home_bloc.dart';
import 'features/orders_feature/data/repository/repository.dart';
import 'features/orders_feature/data/sources/remote.dart';
import 'features/orders_feature/domain/repository/repository.dart';
import 'features/orders_feature/domain/use_case/accepte_order_case.dart';
import 'features/orders_feature/domain/use_case/get_archived_orders_case.dart';
import 'features/orders_feature/presentation/bloc/orders_bloc.dart';
import 'features/profile_feature/data/repository/repository.dart';
import 'features/profile_feature/data/sources/remote.dart';
import 'features/profile_feature/domain/repository/repository.dart';
import 'features/profile_feature/domain/use_case/get_profile_case.dart';
import 'features/profile_feature/presentation/bloc/profile_bloc.dart';


final  sl=GetIt.instance;
late final SharedPreferences sharedPreferences;
final InternetConnectionChecker internetConnectionChecker=InternetConnectionChecker();

Future<void>init()async{

  await Firebase.initializeApp();
  await initFireBaseMessaging();
  await  Geolocator.requestPermission();
  await FirebaseMessaging.instance.subscribeToTopic("deliveries");
  sharedPreferences=await SharedPreferences.getInstance();


  initHomeFeature();

  initHomePageFeature();

  initOrdersFeature();

  initProfileFeature();

  initDeliveringFeature();

  initAuthFeature();
}



 initHomeFeature(){
   sl.registerFactory(() => HomeBloc(sl.call(),sl.call(),sl.call(),sl.call(),));

   sl.registerLazySingleton(() => GetDateCase(sl.call()));
   sl.registerLazySingleton(() => CloseStatusCase(sl.call()));
   sl.registerLazySingleton(() => GetPositionCase(sl.call()));
   sl.registerLazySingleton(() => OpenStatusCase(sl.call()));

   sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImp(sl.call(),internetConnectionChecker,sl.call()));

   sl.registerLazySingleton(() => HomeRemote(sl.call()));
 }

 initHomePageFeature(){
  sl.registerFactory(() => HomePageBloc());
 }

 initOrdersFeature(){
  sl.registerFactory(() => OrdersBloc(sl.call(),sl.call(),sl.call()),);

  sl.registerLazySingleton(() => GetArchivedOrdersCase(sl.call()));
  sl.registerLazySingleton(() => GetPendingOrdersCase(sl.call()));
  sl.registerLazySingleton(() => AccepteOrderCase(sl.call()));

  sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImp(sl.call(),internetConnectionChecker,sl.call()));

  sl.registerLazySingleton(() => OrdersRemote());

 }

 initProfileFeature(){
  sl.registerFactory(() => ProfileBloc(sl.call()));

  sl.registerLazySingleton(() => GetProfileCase(sl.call()));

  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImp(internetConnectionChecker,sl.call(),sl.call()));

  sl.registerLazySingleton(() => ProfileRemote());
 }

 initDeliveringFeature(){
  sl.registerFactory(() => DeliveringBloc(sl.call(),sl.call(), sl.call(), sl.call(),sl.call(),sl.call(),sl.call(),sl.call(),sl.call()));

  sl.registerLazySingleton(() => ToShopCase(sl.call()));
  sl.registerLazySingleton(() => InShopCase(sl.call()));
  sl.registerLazySingleton(() => ToCustomerCase(sl.call()));
  sl.registerLazySingleton(() => ArrivingShopStageCase(sl.call()));
  sl.registerLazySingleton(() => LeavingShopStageCase(sl.call()));
  sl.registerLazySingleton(() => DoneOrderStageCase(sl.call()));
  sl.registerLazySingleton(() => GetCurrentLocationCase(sl.call()));
  sl.registerLazySingleton(() => UpdateLocationCase(sl.call()));
  sl.registerLazySingleton(() => GetPolyLineCase(sl.call()));

  sl.registerLazySingleton<DeliveringRepository>(() => DeliveringRepositoryImp(sl.call(),internetConnectionChecker,sl.call()));

  sl.registerLazySingleton(() => DeliveringRemote());

 }

 initAuthFeature(){

  sl.registerFactory(() => AuthBloc(sl.call(),sl.call(),sl.call()));

  sl.registerLazySingleton(() => SignInCase(sl.call()));
  sl.registerLazySingleton(() => IsSignInCase(sl.call()));
  sl.registerLazySingleton(() => SignOutCase(sl.call()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl.call(),internetConnectionChecker,sl.call()));

  sl.registerLazySingleton(() => AuthRemote());
  sl.registerLazySingleton(() => AuthLocal(sharedPreferences));
 }









