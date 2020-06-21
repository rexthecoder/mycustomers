///Created by Demilade Oladugba on 6/19/2020

extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
}