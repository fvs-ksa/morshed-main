import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshed/bloc/location_cubit/cubit.dart';
import 'package:morshed/bloc/location_cubit/state.dart';
import 'package:morshed/bloc/show_office_provider_info/cubit.dart';
import 'package:morshed/bloc/show_office_provider_info/state.dart';
import 'package:morshed/tranlations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/navigation_functions.dart';
import '../../constant/const_color.dart';
import '../../utiels/socket.dart';

class ProvidersLocationScreen extends StatefulWidget {
  const ProvidersLocationScreen({super.key});

  @override
  State<ProvidersLocationScreen> createState() => _ProvidersLocationScreenState();
}

class _ProvidersLocationScreenState extends State<ProvidersLocationScreen> {
  final ProviderLocationService _dataSource = ProviderLocationService();
  GoogleMapController? mapController;

  CameraPosition? cameraPositions;
  @override
  void initState() {
    super.initState();
    _dataSource.start(context: context);
  }

  @override
  void dispose() {
    _dataSource.stop();
    super.dispose();
  }
  // var icon;
  // @override
  // void initState() {
  //   ShowOfficesAndProviderInfoCubit.get(context).addMarker();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    var locationCubit = LocationCubit.get(context);
    var showDataCubit = ShowOfficesAndProviderInfoCubit.get(context);
    return BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state)async {

        },
        builder: (context, state)  {
          return BlocConsumer<ShowOfficesAndProviderInfoCubit,
              ShowOfficesAndProviderInfoState>(
              listener: (context, state) {},
              builder: (context, state) {
                return StreamBuilder(
                 stream: showDataCubit.dataStream,
                  builder: (context,snapShot) {
                    if(snapShot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator.adaptive(
                        backgroundColor: orangeColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          darkMainColor, //<-- SEE HERE
                        ),
                      ),);
                    }else{
                      return Scaffold(
                        body: locationCubit.position?.latitude == null
                            ? Center(child: CircularProgressIndicator.adaptive(
                          backgroundColor: orangeColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            darkMainColor, //<-- SEE HERE
                          ),
                        ))
                            :showDataCubit.getProvidersModel.providers!.isEmpty?
                        Center(child: Text(LocaleKeys.no_service_provider.tr(),textAlign: TextAlign.center,),): Stack(
                              children: [
                                GoogleMap(
                                  mapType: MapType.satellite,
                          gestureRecognizers: Set()
                                ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
                          onCameraMove: (CameraPosition cameraPosition) {
                                cameraPositions = cameraPosition;
                          },
                                  onTap: (l) {
                                    setState(() {
                                      showDataCubit.providerTab = 00;
                                    });
                                  },
                          initialCameraPosition: CameraPosition(
                                  zoom: 12,
                                  target: LatLng(locationCubit.position!.latitude,
                                      locationCubit.position!.longitude)),
                          onMapCreated: (GoogleMapController controller) {
                                mapController = controller;
                          },
                          myLocationEnabled: true,

                          // myLocationButtonEnabled: true,
                          // buildingsEnabled: true,
                          // compassEnabled: true,
                          markers: Set<Marker>.of(showDataCubit.providerMarkers),
                        ),
                                Visibility(
                                  visible: showDataCubit.providerTab != 00,
                                  child: Align(
                                    alignment: AlignmentDirectional.bottomCenter,
                                    child: Container(
                                        height: 200,
                                        padding: const EdgeInsetsDirectional.all(18),
                                        margin: const EdgeInsetsDirectional.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.only(
                                                  bottom: 18.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                child: Image.asset(
                                                  'assets/images/officesName.png',
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                Align(
                                                  alignment: AlignmentDirectional
                                                      .bottomStart,
                                                  child: Container(
                                                    padding:
                                                    EdgeInsetsDirectional.only(
                                                        start: 8),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          showDataCubit.getProvidersModel.providers
                                                              ![showDataCubit
                                                              .providerId ??
                                                              0]
                                                              .name!,
                                                          maxLines: 1,
                                                          //textAlign: TextAlign.center,
                                                        ),
                                                        Text(
                                                          showDataCubit.getProvidersModel.providers
                                                          ![showDataCubit
                                                              .providerId ??
                                                              0]
                                                              .serviceProviderType??'',
                                                          style: TextStyle(
                                                            color: greyColor,
                                                            fontSize: 8,
                                                          ),
                                                          maxLines: 1,
                                                        )
                                                      ],
                                                    ),
                                                    height: 60.h,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        2,
                                                    decoration: BoxDecoration(
                                                        color: whiteColor,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30.w,
                                                ),
                                                CircleAvatar(
                                                    backgroundColor: whiteColor,
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          await launchUrl(Uri.parse(
                                                              'google.navigation:q='
                                                                  '${showDataCubit.
                                                              getProvidersModel
                                                                  .providers![showDataCubit.providerId ?? 0].lat!}, '
                                                                  '${showDataCubit.getProvidersModel.providers![showDataCubit.providerId ?? 0].lng!}'
                                                                  '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                                        },
                                                        icon: SvgPicture.asset(
                                                            'assets/svg/Group 204376.svg'))),
                                                SizedBox(width: 10.w,),
                                                CircleAvatar(
                                                    backgroundColor: whiteColor,
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          launchCall(context: context, phoneNumber: showDataCubit.
                                                          getProvidersModel
                                                              .providers![showDataCubit.providerId ?? 0].phoneNumber!);
                                                        },
                                                        icon: SvgPicture.asset(
                                                            'assets/svg/end call.svg')))
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            ),
                      );
                    }

                  }
                );
              });
        });
  }
}
