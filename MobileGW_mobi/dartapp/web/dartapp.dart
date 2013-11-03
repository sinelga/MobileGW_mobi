import 'dart:html';
//import 'dart:js';
import 'dart:async';
import 'domains.dart';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'events/clickonitemevent.dart' as clickonitemevent;


List<Character> characterarr;
var center;

void main() {
    
  Future<js.Proxy> result = jsonp.fetch(
      
//      uri: "http://79.125.21.225:3090/get_characters?number=50&orient=portrait&callback=?"
      uri: "http://79.125.21.225:3090/get_characters?number=50&orient=landscape&callback=?"
 
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
  var title ="<i class='fa fa-share'></i><div class='googlefonttitle'>"+item.name+" "+item.age+"v</div>";
  var imagelink = item.img;
  var cont = "<p class='media-heading googlefontcont'>"+item.city+"</p>";
  
  var htmlstr = "<div class='media'><img class='media-object pull-left img-thumbnail itemimage' src='${imagelink}' alt=''><div class='media-body'> <h4 class='media-heading'>${title}</h4>${cont}</div></div>";
  
  var divElement = new DivElement();
  divElement.onClick.listen((event) => clickonitemevent.show(event,characterarr));

  divElement.setInnerHtml(htmlstr, treeSanitizer: new NullTreeSanitizer() );
  divElement.id =id; 
  
  center.append(divElement);
 
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}
