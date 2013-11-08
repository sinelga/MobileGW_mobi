library chatevent;

import 'dart:html';
import '../domains.dart';
//import "package:jsonp/jsonp.dart" as jsonp;
import 'dart:async';
import "package:js/js.dart" as js;
import "package:jsonp/jsonp.dart" as jsonp;
import 'chatarriveevent.dart' as chatarriveevent;
import 'package:css_animation/css_animation.dart';

ask(Event e,String uuid,Character character,InputElement ask){
    
  var askstr; 
  
  if (ask.value ==""){
    askstr = ask.placeholder;
    
    var element = querySelector("#submitAsk");
 
    var animation = new CssAnimation.properties(
        { 'opacity': 0, 'top': '0px' },
        { 'opacity': 1, 'top': '8px' }
       
    );

    animation.apply(element, iterations: 2, alternate: false,onComplete: () => element.placeholder="???");  

        
  } else {
    
    askstr = ask.value;
     
  var inputgroup =querySelector("#inputgroup");
  
  inputgroup.children.clear();
  
  LabelElement labelElement = new LabelElement();
  labelElement.text = askstr;
  
  inputgroup.append(labelElement);
  
  var counterElement = new DivElement();
  counterElement.id = "counter";
  counterElement.style.color="red";
  
  inputgroup.append(counterElement);
   
 var urlstr = "http://79.125.25.179:8000/bot_answer/?uuid="+uuid+"&phone="+character.phone+"&say="+Uri.encodeComponent(askstr)+"&callback=?";

 
 Future<js.Proxy> result = jsonp.fetch(
     uri: urlstr
 );
 
 result.then((js.Proxy proxy) {

   chatarriveevent.elaborate(uuid,character,proxy);
   
 });
 
  } 
}