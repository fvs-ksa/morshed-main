
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/tranlations/locale_keys.g.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget child;
  NoInternetScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/NO_INTERNET.png', width: 150, height: 150),
            Text(LocaleKeys.error.tr(),style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: 20),
            Text(
              LocaleKeys.no_internet_connection.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 40),
            Container(
              height: 45,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: mainButton( text: LocaleKeys.retry.tr(),
                color: darkMainColor,
                context: context,
                fct: () async {
                if(await Connectivity().checkConnectivity() != ConnectivityResult.none) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => child));
                }
              },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
