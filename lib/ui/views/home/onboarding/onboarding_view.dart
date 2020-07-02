import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'onboarding_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<OnboardingViewModel>.nonReactive(
      builder: (context, model, child) => Material(
        child: Stack(
          children: <Widget>[
            Container(
                height: SizeConfig.yMargin(context, 65),
                child: _BackGroundImage()),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.yMargin(context, 60)),
                height: SizeConfig.yMargin(context, 43),
                width: SizeConfig.xMargin(context, 100),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height * 0.05),
                    topRight: Radius.circular(height * 0.05),
                  ),
                ),
                padding: EdgeInsets.all(SizeConfig.yMargin(context, 3)),
                child: _ForegroundContent(
                  // TODO: Move this into the VIEW_MODEL
                  texts: [
                    {
                      'heading': 'Invoice reminders',
                      'body':
                          'Send overdue invoice reminders to your \n customers',
                    },
                    {
                      'heading': 'Debt Collection',
                      'body':
                          'Easier to keep track and manage \n debt collection',
                    },
                    {
                      'heading': 'Sales Messaging',
                      'body':
                          'Push unique sales messaging \n directly to your customers',
                    },
                  ],
                ),
              ),
            ),
            Positioned(
              right: SizeConfig.xMargin(context, 1),
              top: SizeConfig.yMargin(context, 3),
              child: FlatButton(
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: SizeConfig.yMargin(context, 2),
                    fontWeight: FontWeight.w900,
                  ),
                ),
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
      'assets/images/onboarding/ob${index + 1}.png';

  @override
  Widget buildViewModelWidget(BuildContext context, OnboardingViewModel model) {
    previousPlaceholder = previousPlaceholder ?? previous;
    var controller = useAnimationController(
      duration: Duration(milliseconds: 800),
    );
    var animation = useAnimation<double>(controller);

    // Store the old previous to use in the current build

    current = current ??
        Image.asset(
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

  Widget getChild(int index, context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            texts[index]['heading'],
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: SizeConfig.yMargin(context, 4),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Text(
            texts[index]['body'],
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.yMargin(context, 2),
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

    current = current ?? getChild(model.currentIndex % model.numPages, context);

    if (shouldReassign) {
      current = getChild(model.currentIndex % model.numPages, context);
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
            child: InkWell(
                onTap: () {
                  model.navigateToNext();
                },
                child: btnHome('Get Started', context)),
          ),
        ],
      ),
    );
  }
}
