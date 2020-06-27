import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/widgets/shared/custom_raised_button.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'onboarding_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.nonReactive(
      builder: (context, model, child) => Material(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: _BackGroundImage(),
            ),
            Positioned.fill(
              top: 406.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.w),
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(30.w),
                child: _ForegroundContent(
                  // TODO: Move this into the VIEW_MODEL
                  texts: [
                    {
                      'heading': 'Lorem ipsum heading one',
                      'body': 'Lorem ipsum body which is longer '
                          'than heading for some unknown reasons. '
                          'There are different variations of loren.',
                    },
                    {
                      'heading': 'Lorem ipsum heading a two',
                      'body': 'Lorem ipsum body which is longer '
                          'than heading for some unknown reasons. '
                          'Also a bit different from the first. Dunno why..',
                    },
                    {
                      'heading': 'Lorem ipsum three. You know it.',
                      'body': 'So I\'ll keep it simple on this one. Or Imma.',
                    },
                  ],
                  ),
                ),
              ),
            Positioned(
              right: 0,
              top: 15.w,
              child: FlatButton(
                // TODO: Make text bold
                child: Text('Skip'),
                onPressed: model.navigateToNext,
                color: Colors.transparent,
                textColor: Colors.white,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}

// ignore: must_be_immutable
class _BackGroundImage extends HookViewModelWidget<OnboardingViewModel> {
  _BackGroundImage({Key key}) : super(key: key, reactive: true);

  bool isCompleted = false;
  Widget previous = Container();
  Widget previousPlaceholder;
  Widget current;
  bool shouldReassign = false;

  String imageWithIndex(int index) =>
      'assets/images/onboarding/onboarding${index + 1}.png';

  @override
  Widget buildViewModelWidget(BuildContext context, OnboardingViewModel model) {

    previousPlaceholder = previousPlaceholder ?? previous;
    var controller = useAnimationController(
      duration: Duration(milliseconds: 800),
    );
    var animation = useAnimation<double>(controller);

    // Store the old previous to use in the current build

    current = current ?? Image.asset(
      imageWithIndex(model.currentIndex % model.numPages),
      fit: BoxFit.cover,
    );

    if (shouldReassign) {
      current = Image.asset(
        imageWithIndex(model.currentIndex % model.numPages),
        fit: BoxFit.cover,
      );
      previousPlaceholder = previous;
      previous = current;

      shouldReassign = false;
    }
    if (isCompleted) {
      controller.reset();
      shouldReassign = true;
    }

    isCompleted = controller.isCompleted;
    controller.forward();
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              child: current,
              opacity: animation,
            ),
          ),
          Positioned.fill(
            child: Opacity(
              child: previousPlaceholder,
              opacity: 1 - animation,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _ForegroundContent extends HookViewModelWidget<OnboardingViewModel> {

  _ForegroundContent({Key key, this.texts}) : super(key: key, reactive: true);

  final List<Map<String, String>> texts;

  bool isCompleted = false;
  Widget previous = Container();
  Widget previousPlaceholder;
  Widget current;
  bool shouldReassign = false;

  Widget getChild(int index) => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        texts[index]['heading'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20.h),
      Text(
        texts[index]['body'],
        style: TextStyle(
          fontSize: 16.sp,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );

  @override
  Widget buildViewModelWidget(BuildContext context, OnboardingViewModel model) {
    previousPlaceholder = previousPlaceholder ?? previous;
    var controller = useAnimationController(
      duration: Duration(milliseconds: 800),
    );
    var animation = useAnimation<double>(controller);

    // Store the old previous to use in the current build

    current = current ?? getChild(model.currentIndex % model.numPages);

    if (shouldReassign) {
      current = getChild(model.currentIndex % model.numPages);
      previousPlaceholder = previous;
      // Assign the previous to current for use in next build
      // if only the animation has been completed
      previous = current;

      shouldReassign = false;
    }
    if (isCompleted) {
      controller.reset();
      shouldReassign = true;
    }

    // build the current
    isCompleted = controller.isCompleted;
    controller.forward();
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              child: current,
              opacity: animation,
            ),
            bottom: 60.h,
          ),
          Positioned.fill(
            child: Opacity(
              child: previousPlaceholder,
              opacity: 1 - animation,
            ),
            bottom: 60.h,
          ),
          Positioned(
            bottom: 10.h,
            left: 30.w,
            right: 30.w,
            child: CustomRaisedButton(
              label: 'Get started',
              onPressed: model.navigateToNext,
            ),
          ),
        ],
      ),
    );
  }
}
