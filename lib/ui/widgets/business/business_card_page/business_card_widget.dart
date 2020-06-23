
part of '../../../views/business/business_card_page/business_cardpage_view.dart';

class _BusinessCard extends HookViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCard({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
      BuildContext context,
      BusinessCardPageViewModel model,
      ) {
    return Stack(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Container(
            height: ScreenUtil.screenHeightDp / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/business_card.png"),
                  fit: BoxFit.contain),
            ),
          ),
        ),
        Positioned(
          top: 20.sp,
          left: 150.sp,
          child: Text(
            model.businessCard.storeName.toUpperCase(),
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          left: 150.sp,
          bottom: 90.sp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 15.sp,
                  ),
                  Text(
                    " ${model.businessCard.personalName}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    size: 15.sp,
                  ),
                  Text(
                    " ${model.businessCard.phoneNumber}",
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    size: 15.sp,
                  ),
                  Text(
                    " ${model.businessCard.emailAddress}",
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20.sp,
          left: 150.sp,
          child: Text(
            model.businessCard.address,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }
}
