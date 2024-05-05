
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