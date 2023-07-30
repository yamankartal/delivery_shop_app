part of 'profile_bloc.dart';

class ProfileState{
  final ProfileModel profileModel;
  final States getProfileState;
  final String errorMsg;

  ProfileState({this.profileModel=const ProfileModel(), this.getProfileState=States.init, this.errorMsg=""});



  ProfileState copyWith({
    final ProfileModel? profileModel,
    final States ?getProfileState,
    final String ?errorMsg,

  }){


    return ProfileState(
      errorMsg: errorMsg??this.errorMsg,
      getProfileState: getProfileState??this.getProfileState,
      profileModel: profileModel??this.profileModel,
    );

  }

}