library gotochatevent;

import 'dart:html';
import '../domains.dart';
import 'dart:async';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'chatarriveevent.dart' as chatarriveevent;

go(Event e,String uuid,Character character,InputElement firstinput) {
  
 var firstinputstr; 
 
 if (firstinput.value ==""){
   firstinputstr = firstinput.placeholder;   
 } else {
   
   firstinputstr = firstinput.value;   
 }
 
  var urlstr = "http://79.125.25.179:8000/bot_answer/?uuid="+uuid+"&phone="+character.phone+"&say="+Uri.encodeComponent(firstinputstr)+"&callback=?";

 
 Future<js.Proxy> result = jsonp.fetch(
     uri: urlstr
 );
 
 result.then((js.Proxy proxy) {
//   print(proxy.data);
   chatarriveevent.elaborate(uuid,character,proxy);
   
 });
  
 querySelector("#media").children.clear();
 var inputgroup =querySelector("#inputgroup");
 inputgroup.children.clear();
 inputgroup.style.float="left";
 
 LabelElement labelElement = new LabelElement();
 labelElement.text = firstinputstr;
 
 inputgroup.append(labelElement);
 
 var divSpinElement = new DivElement();
 divSpinElement.id = "counter";
 divSpinElement.style.color="red";
 
 inputgroup.append(divSpinElement);
 
  
}