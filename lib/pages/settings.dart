import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'favoutite_articles.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notification = false;

  @override
  void initState() {
    super.initState();
    checkNotificationSetting();
  }

  checkNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'notification';
    final value = prefs.getInt(key) ?? 0;
    if (value == 0) {
      setState(() {
        _notification = false;
      });
    } else {
      setState(() {
        _notification = true;
      });
    }
  }

  saveNotificationSetting(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'notification';
    final value = val ? 1 : 0;
    prefs.setInt(key, value);
    if (value == 1) {
      setState(() {
        _notification = true;
      });
    } else {
      setState(() {
        _notification = false;
      });
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Daha Fazla',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Poppins'),
        ),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Image(
                image: AssetImage('assets/icon.png'),
                height: 40,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Text(
                "Version 1.0.0 ",
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.0, color: Colors.black87),
              ),
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouriteArticles(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/favourite.png",
                      width: 30,
                    ),
                    title: Text('Favoriler'),
                    subtitle: Text("Favorilerinizi görün"),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/more/contact.png",
                    width: 30,
                  ),
                  title: Text('İletişim'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            const url = 'https://www.oxit.com.tr';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Yüklenemedi $url';
                            }
                          },
                          child: Text(
                            "https://www.oxit.com.tr",
                            style: TextStyle(color: Colors.black45),
                          )),
                      FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            const url = 'mailto:info@oxit.com.tr';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Yüklenemedi $url';
                            }
                          },
                          child: Text(
                            "info@oxit.com.tr",
                            style: TextStyle(color: Colors.black45),
                          )),

 FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            const url = 'tel:0850 346 34 62';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Yüklenemedi $url';
                            }
                          },
                          child: Text(
                            "0850 346 34 62",
                            style: TextStyle(color: Colors.black45),
                          )),

                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                        'Sizlerde son yazılarıma bakmak isterseniz : https://www.oxit.com.tr');
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/more/share.png",
                      width: 30,
                    ),
                    title: Text('Paylaş'),
                    subtitle: Text("Uygulamamıza göz atmak ister misiniz ?"),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    "assets/more/notification.png",
                    width: 30,
                  ),
                  isThreeLine: true,
                  title: Text('Bildirim'),
                  subtitle: Text("Bildirim durumunu değiştir"),
                  trailing: Switch(
                      onChanged: (val) async {
                        await saveNotificationSetting(val);
                      },
                      value: _notification),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
