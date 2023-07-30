import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/responsive.dart';

class HomeDateTimeWidget extends StatelessWidget {
  const HomeDateTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Res.padding),
      child: Row(
        children: [
          SizedBox(
            width: Res.padding * 0.5,
          ),
          Text(
            " ${DateFormat('EEEE').format(DateTime.now())}",
            style: TextStyle(color: Colors.grey[700]),
          ),
          Text(
            "  ${DateTime.now().month}-${DateFormat.MMMM().format(DateTime.now())}",
            style: TextStyle(
                height: Res.tinyFont,
                fontSize: Res.font * 0.7,
                color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
