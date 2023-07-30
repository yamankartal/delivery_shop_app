import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shop_delivery/core/constants/widgets.dart';
import 'package:shop_delivery/features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'package:shop_delivery/features/auth_feature/presentation/screens/sign_in_screen.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/enums.dart';
import '../../../../injection.dart';
import '../../../home_feature/presentation/widgets/acepting_canceling-percent_widget.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/accepting_canceling_percent_widget.dart';
import '../widgets/profile_percent_indicator_widget.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc profileBloc;
  late AuthBloc authBloc;
  @override
  void initState() {
    authBloc=BlocProvider.of<AuthBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (p, c) => p.getProfileState != c.getProfileState,
      builder: (_, state) {
        if (state.getProfileState == States.loading) {
          return circularProgressIndicatorWidget();
        } else if (state.getProfileState == States.loaded) {
          return BlocConsumer<AuthBloc,AuthState>(
              buildWhen: (p,c)=>p.signOutState!=c.signOutState,
              listenWhen: (p,c)=>p.signOutState!=c.signOutState,
              builder: (_,authState){
                if(authState.signOutState==States.loading){
                  return circularProgressIndicatorWidget();
                }

                return Container(
                    padding: EdgeInsets.all(Res.padding),
                    margin: EdgeInsets.only(top: Res.font * 2),
                    height: Res.fullHeight,
                    width: Res.width,
                    child: SingleChildScrollView(
                      child:Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: Res.padding*0.5),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.profileModel.deliveryName.toString(),
                                  style: TextStyle(
                                      color: AppColor.primaryColors,
                                      fontSize: Res.font * 0.8,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(onTap:  (){
                                  showDialog(context: context, builder: (_)=>AlertDialog(
                                    title: Text("Are you sure you want to sing ou ?",
                                    style: TextStyle(fontSize: Res.font),
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("No",style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font),)),
                                      TextButton(onPressed: (){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>BlocProvider(create: (_)=>sl<AuthBloc>(),child:const SignInScreen())), (route) => false); authBloc.add(SignOutEvent());}, child: Text("Yes",style: TextStyle(color: AppColor.primaryColors,fontSize: Res.font))),
                                    ],
                                  ));
                                }, child: Icon(Icons.output_rounded,color: AppColor.primaryColors,size: Res.font*1.5,))
                              ],
                            ),
                          ),
                          ProfilePercentIndicatorWidget(profileModel: state.profileModel),
                          Padding(padding: EdgeInsets.symmetric(horizontal: Res.font*0.6),
                              child:Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Orders Done ",style: TextStyle(fontSize: Res.font,height: Res.tinyFont,color: Colors.black54),),
                                      Text("${state.profileModel.deliveryOrdersCount}",style: TextStyle(fontSize: Res.font,fontWeight: FontWeight.bold,height: Res.tinyFont*0.8,color: AppColor.primaryColors),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Balance ",style: TextStyle(fontSize: Res.font,height: Res.tinyFont*0.8,color: Colors.black54),),
                                      Text("${state.profileModel.deliveryBalance} \$",style: TextStyle(fontSize: Res.font,fontWeight: FontWeight.bold,height: Res.tinyFont*0.8,color: AppColor.primaryColors),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Kilometer earning ",style: TextStyle(fontSize: Res.font,height: Res.tinyFont*0.8,color: Colors.black54),),
                                      Text("${state.profileModel.deliveryKilometerEarning} \$",style: TextStyle(fontSize: Res.font,fontWeight: FontWeight.bold,height: Res.tinyFont*0.8,color: AppColor.primaryColors),),
                                    ],
                                  ),
                                ],
                              )
                          ),
                          AcceptingCancelingPercentProfileWidget(profileModel:state.profileModel),
                        ],
                      ),
                    )
                );
              },
              listener: (_,state){
                if(state.signOutState==States.error){
                  showSnackBar(context, state.errorMsg);
                }
              },);
        } else if (state.getProfileState == States.error) {
          return errorWidget(state.errorMsg);
        }
        return Container();
      },
    );
  }
}
