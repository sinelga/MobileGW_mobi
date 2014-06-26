import 'dart:html';
import '../domains.dart';
import 'dart:async';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'package:css_animation/css_animation.dart';

pay(Event e, String uuid, Character character, MobileClient mobileClient, int cost, String provider) {
  
  if (provider == "MobileElisa") {


    if (mobileClient != null) {

      makepayment(character, mobileClient, cost, provider);

    } else {


      Future<js.Proxy> result = jsonp.fetch(uri: "http://gw.sinelgamysql.appspot.com/setpayment?uuid=" + uuid + "&resource=mobilephone&callback=?");

      result.then((js.Proxy proxy) {

        mobileClient = new MobileClient();
        mobileClient.msisdn = proxy["results"]["msisdn"];
        mobileClient.ip = proxy["results"]["ip"];
        mobileClient.uuid = uuid;
        makepayment(character, mobileClient, cost, provider);

      });

    }

  } else if (provider == "MobileSonera") {
    
    makepayment(character, mobileClient, cost, provider);
    
    
  }

}

void makepayment(Character character, MobileClient mobileClient, int cost, String provider) {
  var directnumberEl = querySelector('#directnumber');
  var directnumber = getDirectNumber(mobileClient);

  if (provider == "MobileElisa") {

    String uuid = mobileClient.uuid;
    String msisdn = mobileClient.msisdn;
    String ip = mobileClient.ip;

    var coststr = cost.toString();
    String urlstr = "http://gw.sinelgamysql.appspot.com/makepayment?uuid=" + uuid + "&msisdn=" + msisdn + "&ip=" + ip + "&price=" + coststr + "&callback=?";

    Future<js.Proxy> result = jsonp.fetch(uri: urlstr);

    result.then((js.Proxy proxy) {


      if (proxy["resultCode"] == 1) {

        directnumberEl.text = "Soita " + directnumber + " " + character.name + "!";


      } else {

        directnumberEl.text = "Sorry can't make payment!!";

      }

      var animation = new CssAnimation.properties({
        'opacity': 0,
        'top': '0px'
      }, {
        'opacity': 1,
        'top': '8px'
      });

      animation.apply(directnumberEl, iterations: 2, alternate: false);



    });

  } else if (provider == "MobileSonera") {


    directnumberEl.text = "Soita " + directnumber + " " + character.name + "!";

    var animation = new CssAnimation.properties({
      'opacity': 0,
      'top': '0px'
    }, {
      'opacity': 1,
      'top': '8px'
    });

    animation.apply(directnumberEl, iterations: 2, alternate: false);


  }

}

String getDirectNumber(MobileClient mobileClient) {


  return "0452305048";

}

