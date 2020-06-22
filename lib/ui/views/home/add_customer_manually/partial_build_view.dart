// import 'package:flutter/material.dart';
// import 'package:mycustomers/ui/views/add_customer_manually/partial_build_viewmodel.dart';
// import 'package:stacked/stacked.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:stacked_hooks/stacked_hooks.dart';

// class PartialBuildsView extends StatelessWidget {
//   const PartialBuildsView({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<PartialBuildsViewModel>.reactive(
//       builder: (context, model, child) => _StringForm(),
//       viewModelBuilder: () => PartialBuildsViewModel(),
//     );
//   }
// }

// class _StringForm extends HookViewModelWidget<PartialBuildsViewModel> {
//   _StringForm({Key key}) : super(key: key, reactive: true);

//   @override
//   Widget buildViewModelWidget(
//       BuildContext context, PartialBuildsViewModel model) {
//     var name = useTextEditingController();
//     var phoneNumber = useTextEditingController();
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Color(0xff77869e),
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(4.0),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(Icons.person),
//                 ),
//                 Container(
//                   height: 24.0,
//                   decoration: BoxDecoration(
//                     border: Border(
//                       left: BorderSide(
//                         color: Color(0xff77869e),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: TextField(
//                       textAlign: TextAlign.left,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Name',
//                         border:
//                             OutlineInputBorder(borderSide: BorderSide.none),
//                       ),
//                       controller: name,
//                       onChanged: model.updateName,
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//         SizedBox(height: 16.0),
//         Container(
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Color(0xff77869e),
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(4.0)),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DropdownButton(
//                     underline: Container(),
//                     value: model.dropDownValue,
//                     items: model.countryCode
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String newValue) {
//                       model.updateCountryCode(newValue);
//                     },
//                     icon: Icon(
//                       Icons.arrow_drop_down,
//                       color: Color(0xff000000),
//                     ),
//                   ),
//                 ),
//                 Container(
//                     height: 24.0,
//                     decoration: BoxDecoration(
//                         border: Border(
//                             left: BorderSide(color: Color(0xff77869e))))),
//                 Expanded(
//                   child: TextField(
//                     textAlign: TextAlign.left,
//                     decoration: InputDecoration(
//                       hintText: 'Mobile Number',
//                       border: OutlineInputBorder(borderSide: BorderSide.none),
//                     ),
//                     controller: phoneNumber,
//                     onChanged: model.updateContact,
//                   ),
//                 )
//               ],
//             )),
//       ],
//     );
//   }
// }
