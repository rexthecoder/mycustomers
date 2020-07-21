import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SendMessageViewModel extends BaseViewModel {

  final List<String> _messageEntries = <String>[
    " Don't leave me",
    "Happy New year",
     "Debt reminder"
  ];

  List<String> get messageEntries => _messageEntries;

}