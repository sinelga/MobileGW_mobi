import 'dart:html';
import 'dart:async';
import 'domains.dart';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'events/clickonitemevent.dart' as clickonitemevent;
import 'package:uuid/uuid.dart';


List<Character> characterarr;
var center;
var uuid;
Character selectedCharacter;
var payable =false;
MobileClient mobileClient;

void main() {
  
  Uuid uuidobj = new Uuid();
  uuid = uuidobj.v1();
    
  Future<js.Proxy> resultF = jsonp.fetch(
      
      uri: "http://gw.sinelgamysql.appspot.com/scanips?&callback=?"
        
  );
  
  resultF.then((js.Proxy proxy) {
      
    if (!(proxy["provider"] == "NotMobile")) {
      
      payable = true;
      
      document.body.style
        ..paddingTop="50px";
      
      Element staticTop = new Element.nav();
      staticTop.classes.add("navbar navbar-fixed-top");
      staticTop.style.background="white";
      staticTop.innerHtml="<div id='directnumber' class='ads'>Suora puhelinnumero!</div>";
      querySelector('#ads').append(staticTop);
      
      String site = document.domain;
      
      document.body.nodes.add(new ScriptElement()..src =
          "http://sinelga.mbgw.elisa.fi/serviceurl?id="+uuid+"&site="+site+"&resource=mobilephone");


    new Timer.periodic(new Duration(seconds:5), (timer) {

      
      Future<js.Proxy> result = jsonp.fetch(
          
          uri: "http://gw.sinelgamysql.appspot.com/setpayment?uuid="+uuid+"&resource=mobilephone&callback=?"
          
      );
      
      result.then((js.Proxy proxy) {
                
        mobileClient = new MobileClient();        
        mobileClient.msisdn = proxy["results"]["msisdn"];
        mobileClient.ip =  proxy["results"]["ip"];
        mobileClient.uuid = uuid;
                
        
      });
      
      
      timer.cancel(); // cancel the timer
      
    });
    
  } else {
    
    print(proxy["provider"]);
    
  }
    
  });
      
  
  Future<js.Proxy> result = jsonp.fetch(
      
      uri: "http://79.125.21.225:3090/get_characters?number=50&orient=portrait&callback=?"
 
  );
    
  result.then((js.Proxy proxy) {
       
    querySelector('#bigspinner').style.display="none";
    display(proxy);
    
   
  });
 
  center=querySelector("#center");
  
}
void display(var data) {
 
  characterarr = new List<Character>();
  
  for (var i=0;i < data.length;i++){
    
    var character = new Character();
    character.name = data[i].name;
    character.age = data[i].age;
    character.city = data[i].city;
    character.desc = data[i].desc;
    character.img = data[i].img;
    character.moto = data[i].moto;
    character.phone = data[i].phone;
    
    createMediaObject(i,character);
    characterarr.add(character);
    
  }
  
}

createMediaObject(i,Character item){
  
  var id = i.toString();
  var title ="<i class='fa fa-share fa-lg'></i><div class='googlefonttitle'>"+item.name+" "+item.age+"v</div>";
  var imagelink = item.img.replaceFirst("thumb", "w110shadow6");
  var cont = "<p class='media-heading googlefontcont'>"+item.city+"</p>";
  
  var htmlstr = "<div class='media'><img class='media-object pull-left itemimagea' src='${imagelink}' alt=''><div class='media-body'> <div class='media-heading'>${title}</div>${cont}</div></div>";
  
  var divElement = new DivElement();
  divElement.onClick.listen((event) => clickonitemevent.show(event,uuid,characterarr,payable,mobileClient));

  divElement.setInnerHtml(htmlstr, treeSanitizer: new NullTreeSanitizer() );
  divElement.id =id; 
  
  center.append(divElement);
 
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
