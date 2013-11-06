library chatarriveevent;

import 'dart:html';
import "package:js/js.dart" as js;
import 'dart:async';
import '../domains.dart';
import 'chatevent.dart' as chatevent;

elaborate(String uuid,Character character,js.Proxy data){
  
//  print(character.phone);

  var answer = data["answer"];
//  var answer = data.answer;
  var counter = querySelector("#counter");
  
  var stream = new Stream.periodic(const Duration(seconds: 1), (count) {
 
    return count;
  });

  var subscription = stream.listen(null); 
  
  subscription.onData((result) {
     
    counter.text = "Odotta.. "+result.toString();
    
    if (result >3) {

      subscription.cancel();
      
      counter.text =character.name +": "+answer;
      
      var inputgroup =querySelector("#inputgroup");
      InputElement submitAsk = new InputElement();
      submitAsk.id = "submitAsk";
      submitAsk.classes.add("form-control");
      inputgroup.append(submitAsk);      
      var gotochatebutton = new ButtonElement();
      gotochatebutton.text="Jatkaa!";
      gotochatebutton.classes.add("btn btn-danger btn-lg");
      gotochatebutton.style.marginTop="15px";
      InputElement submit = querySelector("#firstinput");
      gotochatebutton.onClick.listen((event)=> chatevent.ask(event,uuid,character,submitAsk));
      
      inputgroup.append(gotochatebutton);
           
    }
    
  });
    
}

