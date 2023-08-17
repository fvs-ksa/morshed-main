import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshed/bloc/location_cubit/cubit.dart';
import 'package:morshed/bloc/register_cubit/state.dart';
import 'package:morshed/component/navigation_functions.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/screen/auth_screen/hajji/register_Screen.dart';
import 'package:morshed/tranlations/locale_keys.g.dart';

import '../../../bloc/register_cubit/cubit.dart';
import '../../../component/component.dart';
import '../../../component/cutom_text_filed.dart';

class MapScreenForSetLocation extends StatefulWidget {
  int i;
  TextEditingController locationName = TextEditingController();
  MapScreenForSetLocation({required this.i,required this.locationName});

  @override
  State<MapScreenForSetLocation> createState() =>
      _MapScreenForSetLocationState();
}

class _MapScreenForSetLocationState extends State<MapScreenForSetLocation> {


  GoogleMapController? mapController;

  CameraPosition? cameraPositions;

  // MapScreenForSetLocation({required this.locationName});
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
             // automaticallyImplyLeading: false,
              title: Text(widget.i == 0
                  ? LocaleKeys.menna_loc.tr()
                  : widget.i == 1
                      ?LocaleKeys.arafa_loc.tr()
                      : widget.i == 2
                          ?LocaleKeys.mozdalifa_loc.tr()
                          : widget.i == 3
                              ?LocaleKeys.report_loc.tr()
                              : widget.i == 4
                                  ?LocaleKeys.macca_hotel_loc.tr()
                                  :LocaleKeys.madina_hotel_loc.tr()  ,style: TextStyle(color: whiteColor),),
              centerTitle: true,
              iconTheme: IconThemeData(color: whiteColor),
              actions: [
                IconButton(
                    onPressed: () {
                      // if(widget.i==3){
                      //   LocationCubit.get(context).getStringAddress(widget.i);
                      //   Navigator.of(context).pop();
                      //   print('location report ${reportLocation}');
                      // }else{
                      cubit.getStringAddress(i:widget.i,controller: widget.locationName);
                      // Navigator.pop(context);
                      Navigator.of(context).pop();
                      // navigateForwardReplace(RegisterScreen());
                      print(lat);
                      print('location report ${reportLocation}');
                      print('meenaLoc${meenaLoc}');
                      print('arafaLoc${arafaLoc}');
                      print('MinaLat ${latMinna}');
                      print('MinaLng${lngMinna}');
                      print('ArafaLat${latArafa}');
                      print('ArafaLang${lngArafa}');
                      print('MozdalifaLat${latMozdalifa}');
                      print('MozdalifaLng${lngMozdalifa}');
                      print(widget.i);
                      //}
                    },
                    icon:  Icon(Icons.check,color: whiteColor,))
              ],
            ),
            body: state is GetUserCurrentLocation ||
                    cubit.position?.latitude == null
                ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: orangeColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    darkMainColor, //<-- SEE HERE
                  ),
                ))
                : Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.satellite,
                        // onMapCreated: (googleController) {
                        // // cubit.changeMapMode(googleController);
                        // },
                        onCameraMove: (CameraPosition cameraPosition) {
                          cameraPositions = cameraPosition;
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(cubit.position!.latitude,
                                cubit.position!.longitude),
                            zoom: 16),
                        onCameraIdle: () async {
                          cubit.getLocationFromMap(cameraPositions);
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        buildingsEnabled: false,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/marker.png',
                          width: size.width * 0.09,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp)),
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsetsDirectional.only(top: 10),
                            height: size.height * 0.09,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15.sp),
                                    topLeft: Radius.circular(15.sp))),
                            child: Center(
                             // alignment: Alignment.center,
                              child: CustomTextField(
                               // controller: widget.locationName,
                                labelText: cubit.addressFromMap.isEmpty
                                    ? ''
                                    : cubit.addressFromMap,
                                // hitText: 'الموقع',
                                // enabled: false
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}
