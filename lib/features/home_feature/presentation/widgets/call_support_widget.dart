import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/responsive.dart';
import '../../../../core/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CallSupportWidget extends StatelessWidget {
  const CallSupportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Res.width*0.5,
        padding: EdgeInsets.symmetric(vertical: Res.padding*0.8),
      margin: EdgeInsets.only(top: Res.padding*0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Res.padding),
        color: AppColor.primaryColors,
      ),
      child:InkWell(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Call support",style: TextStyle(color: Colors.white,),),
            SizedBox(width: Res.font*0.7,),
            const Icon(Icons.phone,color: Colors.white,),
          ],
        ),
        onTap: (){
          launchUrl(Uri.parse('tel:+963968045022'));
        },
      )
    );
  }
}
