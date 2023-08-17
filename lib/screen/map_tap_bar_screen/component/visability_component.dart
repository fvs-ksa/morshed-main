// import 'package:flutter/material.dart';
//
// class VisibilityComponent extends StatelessWidget {
//   bool visible=false;
//   const VisibilityComponent({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Visibility(
//       visible: visible,
//       child: Align(
//         alignment: AlignmentDirectional.bottomCenter,
//         child: Container(
//             height: 200,
//             padding: EdgeInsetsDirectional.all(18),
//             margin: EdgeInsetsDirectional.all(15),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 4,
//                 ),
//               ],
//             ),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.only(
//                       bottom: 18.0),
//                   child: ClipRRect(
//                     borderRadius:
//                     BorderRadius.circular(10.0),
//                     child: Image.asset(
//                       'assets/images/officesName.png',
//                     ),
//                   ),
//                 ),
//                 Row(
//                   crossAxisAlignment:
//                   CrossAxisAlignment.end,
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                   children: [
//                     Align(
//                       alignment: AlignmentDirectional
//                           .bottomStart,
//                       child: Container(
//                         padding:
//                         EdgeInsetsDirectional.only(
//                             start: 8),
//                         child: Column(
//                           children: [
//                             Text(
//                               showDataCubit
//                                   .getAllOffices
//                                   .offices![showDataCubit
//                                   .officeId ??
//                                   0]
//                                   .name!,
//                               maxLines: 1,
//                               //textAlign: TextAlign.center,
//                             ),
//                             Text(
//                               showDataCubit
//                                   .getAllOffices
//                                   .offices![showDataCubit
//                                   .officeId ??
//                                   0]
//                                   .address!,
//                               style: TextStyle(
//                                 color: greyColor,
//                                 fontSize: 8,
//                               ),
//                               maxLines: 1,
//                             )
//                           ],
//                         ),
//                         height: 60.h,
//                         width: MediaQuery.of(context)
//                             .size
//                             .width /
//                             2,
//                         decoration: BoxDecoration(
//                             color: whiteColor,
//                             borderRadius:
//                             BorderRadius.circular(
//                                 25)),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 30.w,
//                     ),
//                     CircleAvatar(
//                         backgroundColor: whiteColor,
//                         child: IconButton(
//                             onPressed: () async {
//                               await launchUrl(Uri.parse(
//                                   'google.navigation:q='
//                                       '${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].latitude!}, '
//                                       '${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].longitude!}'
//                                       '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
//                             },
//                             icon: SvgPicture.asset(
//                                 'assets/svg/Group 204376.svg')))
//                   ],
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
