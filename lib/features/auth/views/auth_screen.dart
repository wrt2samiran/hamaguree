import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_exit_card.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/sign_in_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/sign_up_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    Provider.of<AuthController>(context, listen: false).updateSelectedIndex(0, notify: false);
    super.initState();
  }
  bool scrolled = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false,
      onPopInvoked: (val) async {
        if (Provider.of<AuthController>(context, listen: false).selectedIndex != 0) {
          Provider.of<AuthController>(context, listen: false).updateSelectedIndex(0);
        } else {
          if(Navigator.canPop(context)){
            Navigator.of(context).pop();
          }else{
            showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=> const CustomExitCard());
          }
        }
      },
      child: Scaffold(
        body: Consumer<AuthController>(
          builder: (context, authProvider,_) {
            return SingleChildScrollView(
              child: Column(children: [
                  Stack(children: [
                    Container(height: 200, decoration: BoxDecoration(color: Theme.of(context).highlightColor)),
                    Image.asset(Images.loginBg,fit: BoxFit.cover,height: 200, opacity : const AlwaysStoppedAnimation(.25)),
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Image.asset(Images.splashLogo, width: 230, height: 200)]))]),

                  AnimatedContainer(
                    transform: Matrix4.translationValues(0, -20, 0),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge))),
                    duration: const Duration(seconds: 2),
                    child: SingleChildScrollView(
                      child: Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Padding(padding: const EdgeInsets.all(Dimensions.marginSizeLarge),
                            child: Row(children: [

                              InkWell(onTap: () => authProvider.updateSelectedIndex(0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(getTranslated('sign_in', context)!, style: authProvider.selectedIndex == 0 ?
                                    titleRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge) : titleRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                    Container(height: 3, width: 25, margin: const EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                          color: authProvider.selectedIndex == 0 ? Theme.of(context).primaryColor : Colors.transparent))])),
                              const SizedBox(width: Dimensions.paddingSizeExtraLarge),


                              InkWell(onTap: () => authProvider.updateSelectedIndex(1),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                    Text(getTranslated('sign_up', context)!, style: authProvider.selectedIndex == 1 ?
                                    titleRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge) :
                                    titleRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                    Container(height: 3, width: 25, margin: const EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                          color: authProvider.selectedIndex == 1 ? Theme.of(context).primaryColor : Colors.transparent))]))])),
                          authProvider.selectedIndex == 0? const SignInWidget() : const SignUpWidget(),
                        ],),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

