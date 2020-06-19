import 'dart:ui';

class OnboardingModel {
  final Color primeColor;
  final Color accentColor;
  final Color nextAccentColor;
  final int pageNumber;
  final String imagePath;
  final String caption;
  final String subhead;
  final String description;

  OnboardingModel(this.primeColor, this.accentColor, this.nextAccentColor, this.pageNumber, this.imagePath,
      this.caption, this.subhead, this.description);
}