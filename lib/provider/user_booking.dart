
// FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text("Confirmation"),
//               content: Text(message.notification?.body ?? ''),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text("Confirm"),
//                   onPressed: () {
//                     // Perform action on confirmation
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 TextButton(
//                   child: const Text("Deny"),
//                   onPressed: () {
//                     // Perform action on denial
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       });







// ignore_for_file: must_be_immutable

// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:parking_app/models/all_user_details.dart';
// import 'package:parking_app/provider/auth/user_login_provider.dart';
// import 'package:parking_app/provider/gat_all_slots_provider.dart';
// import 'package:parking_app/provider/get_user_data_provider.dart';
// import 'package:parking_app/widgets/parking_details_card.dart';

// import '../widgets/elevated_bottom.dart';

// class HomeWidget extends ConsumerStatefulWidget {
//   HomeWidget({super.key, required this.onSelectItem});

//   void Function(int selctedIndex) onSelectItem;

//   @override
//   ConsumerState<HomeWidget> createState() => _HomeWidgetState();
// }

// class _HomeWidgetState extends ConsumerState<HomeWidget> {
//   bool isHasSlot = false;
//   String? slotCode;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       isHaveSlot();
//     });
//   }

//   Future<void> isHaveSlot() async {
//     final userInfoData = ref.watch(userDataProvider);
//     final List<SlotData> allSlots = await ref.watch(allSlotsDataInfo);
//     bool found = false;
//     for (int i = 0; i < allSlots.length; i++) {
//       if (userInfoData.id == allSlots[i].userId) {
//         found = true;
//         slotCode = allSlots[i].code;
//         break;
//       }
//     }
//     if (found != isHasSlot) {
//       setState(() {
//         isHasSlot = found;
//       });
//     }
//   }

//   Future<void> _checkSlots() async {
//     await isHaveSlot();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userInfoData = ref.watch(userLoginInfo);
//     String userToken = userInfoData.token;
//     Widget content = Column(
//       children: [
//         Center(
//           child: SizedBox(
//             height: 400.h,
//             width: 400.w,
//             child: Image.asset(
//               'assets/images/Designer.png',
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         const Spacer(),
//         SizedBox(height: MediaQuery.of(context).size.height / 40),
//         ElevatedButtonApp(
//             onPressed: () {
//               widget.onSelectItem(1);
//             },
//             label: 'Book Parking'),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 30,
//         ),
//       ],
//     );
//     //ref.read(userDataProvider.notifier).getUserData(userToken)
//     return FutureBuilder(
//       future: _checkSlots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Scaffold(
//             body: Center(
//               child: Text('Error Accourd'),
//             ),
//           );
//         } else {
//           return isHasSlot
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ParkingDetailsCardScreen(
//                       slotIndex: int.parse(slotCode!),
//                     ),
//                     TextButton.icon(
//                       onPressed: isHasSlot
//                           ? () {
//                               ref
//                                   .read(allSlotsDataInfo.notifier)
//                                   .sendAlarm(slotCode!);
//                             }
//                           : null,
//                       icon: const Icon(
//                         FontAwesomeIcons.landMineOn,
//                         size: 30,
//                         color: Colors.red,
//                       ),
//                       label: Text(
//                         'Take Action',
//                         textAlign: TextAlign.center,
//                         style:
//                             GoogleFonts.lato(fontSize: 24, color: Colors.red),
//                       ),
//                     ),
//                   ],
//                 )
//               : content;
//         }
//       },
//     );
//   }
// }
