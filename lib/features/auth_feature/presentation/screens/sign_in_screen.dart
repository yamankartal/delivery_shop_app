import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_delivery/core/constants/colors.dart';
import 'package:shop_delivery/core/constants/widgets.dart';
import 'package:shop_delivery/features/auth_feature/presentation/bloc/auth_bloc.dart';
import 'package:shop_delivery/features/home_page_feature/presentation/bloc/home_page_bloc.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../injection.dart';
import '../../../home_page_feature/presentation/screens/home_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }


  final TextEditingController textEditingController = TextEditingController();
 final GlobalKey<FormState>key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          builder:(_,state){
            if(state.signInState==States.loading){
              return circularProgressIndicatorWidget();
            }
            return  Container(
              height: Res.fullHeight,
              width: Res.width,

              child:Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(Res.font),
                      child:Form(
                        key:key ,
                        child: TextFormField(
                          validator: (val){
                            if(val!.isEmpty){
                              return "empty";
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left:Res.font),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: Padding(
                              padding: EdgeInsets.only(left: Res.padding),
                              child: Text("Approve code",style: TextStyle(fontSize: Res.font*1.2,color: Colors.black),),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColor.primaryColors),
                              borderRadius: BorderRadius.circular(Res.font),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColor.primaryColors),
                              borderRadius: BorderRadius.circular(Res.font),
                            ),
                          ),
                          controller: textEditingController,
                        ),
                      ),
                    ),
                    MaterialButton(
                      minWidth: Res.width*0.7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Res.font)
                      ),
                      color: AppColor.primaryColors,
                      onPressed: (){
                        if(key.currentState!.validate()){
                          authBloc.add(SignInEvent(textEditingController.text));
                        }
                      },
                      child: Text("send",style: TextStyle(color: Colors.white,fontSize: Res.font),),
                    ),
                  ],
                ),
              )
            );
          },
          buildWhen:(p,c)=>p.signInState!=c.signInState,
          listener: (_, state) {
            if (state.signInState == States.loaded) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) =>
                    BlocProvider(create: (_) =>
                        sl<HomePageBloc>(), child: const HomePage(),),),);
            }
            else if (state.signInState == States.error) {
              showSnackBar(context, state.errorMsg);
            }
          },
          listenWhen: (p, c) => p.signInState != c.signInState,


        )
    );
  }
}
