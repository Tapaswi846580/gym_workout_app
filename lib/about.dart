import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class About extends StatelessWidget {
  ThemeData theme;
  double height,width;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
        return true;
      },
      child: Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            backgroundColor: theme.backgroundColor,
            elevation: 0,
            title: Text("Tapaswi Satyapanthi - 22", style: theme.textTheme.body1,),
            bottom: PreferredSize(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(color: theme.primaryColor, height: 4.0,),
            ), preferredSize: Size.fromHeight(4.0)),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Divider(color: Colors.transparent,),
                CustomCard(child: GestureDetector(
                    onTap: () => launchTapaswiLinkedInURL(),
                    child: Image.asset("assets/tapaswi.jpg",alignment: Alignment.topCenter, width: width, height: height/3, fit: BoxFit.fill))),
                Divider(color: Colors.transparent,),

                CustomCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Align(alignment: Alignment.centerLeft,child: Text("Personal Info", style: theme.textTheme.body1,)),
                        Divider(color: Colors.transparent,),
                        Divider(
                          height: 4.0,
                          color: theme.primaryColor,
                          thickness: 4.0,
                        ),
                        Divider(color: Colors.transparent,),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    style:  theme.textTheme.body1.copyWith(fontSize: 17),
                                    children: [
                                      TextSpan(text: "Flutter enthusiast having 1.5 years of exerience in flutter \n"
                                          "Guinness World Record holder in tabla\n"
                                          "Ahmedabad University - iMCA 15-20\n\n",),
                                      TextSpan(text: "From: Ahmedabad, Gujarat\n",),
                                    ]
                                ))),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.transparent,),

                CustomCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Align(alignment: Alignment.centerLeft,child: Text("App Info", style: theme.textTheme.body1,)),
                        Divider(color: Colors.transparent,),
                        Divider(
                          height: 4.0,
                          color: theme.primaryColor,
                          thickness: 4.0,
                        ),
                        Divider(color: Colors.transparent,),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    style:  theme.textTheme.body1.copyWith(fontSize: 17),
                                    children: [
                                      TextSpan(text: "There was an  ",),
                                      TextSpan(text: "Online Challenge",
                                          style: theme.textTheme.body1.copyWith(
                                              fontSize: 17, color: theme.primaryColor),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = (){
                                              launchYoutubeURL();
                                            }
                                      ),
                                      TextSpan(text: " which was initiated by\n"),
                                      TextSpan(text: "Hitesh Choudhary",
                                          style: theme.textTheme.body1.copyWith(
                                              fontSize: 17, color: theme.primaryColor),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = (){
                                              launchHiteshiLinkedInURL();
                                            }
                                      ),
                                      TextSpan(text: " under this application is developed within 2 weeks "
                                          "(also having a 10 to 6 job as a flutter dev)\n\n",),

                                      TextSpan(text: "If anyone asks me to develop this kind of application (including backend) with some other enhanced features like daily "
                                          "new songs, new exercise, etc then I would like to charge ₹39,999 \n",),
                                    ]
                                ))),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.transparent,),
                RichText(
                    text: TextSpan(
                  style: theme.textTheme.body1.copyWith(fontSize: 15),
                  children: [
                    TextSpan(text: "Made with 💙 in"),
                    WidgetSpan(child: FlutterLogo()),
                    TextSpan(text: "\t\t|\t\t L🔥ng live open source")
                  ]
                )),

              ],
            ),
          )
      ),
    );
  }

  launchYoutubeURL() async{
    const url = 'https://youtu.be/VFrKjhcTAzE';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchTapaswiLinkedInURL() async{
    const url = 'https://www.linkedin.com/in/tapaswi97';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  launchHiteshiLinkedInURL() async{
    const url = 'http://linkedin.com/in/hiteshchoudhary';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
