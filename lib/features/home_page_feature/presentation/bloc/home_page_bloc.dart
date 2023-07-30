import 'package:bloc/bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent,HomePageState>{
  HomePageBloc() : super(HomePageState()){
    on<ChangeScreenIndex>((event, emit){
      emit(state.copyWith(homeScreenIndex:event.index));
    });
  }
}