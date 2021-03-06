library clickonitemevent; 

import '../domains.dart';
import 'dart:html';
import 'closeevent.dart' as closeevent;
import 'gotochatevent.dart' as gotochatevent;
import 'dart:async';
import "package:js/js.dart" as js;
import 'paymentfornumber.dart' as paymentfornumber;


var start = false;
var close = DivElement;
Stream<js.Proxy> chat_stream;
var payable =false;

show(Event e,String uuid,List<Character> forMarkList,bool payable,MobileClient mobileClient,String provider) {
  
  var itemid = int.parse((e.currentTarget as Element).id);
  var item = forMarkList[itemid];
    
  if (!start) {
    
    close = new Element.html("<i class='fa fa-times-circle-o fa-2x'></i>");
    close.onClick.listen((event) => closeevent.close(event));
    var closeelem = querySelector('#close');
    closeelem.append(close);
    start=true;
       
    
  } else {

    querySelector('#close').style.display="block";
    
  }
  
  if (payable) {
    
    
    var directnumberEl   =querySelector('#directnumber');
    directnumberEl.classes.clear();
    directnumberEl.style.marginLeft="10px";
    directnumberEl.style.marginTop="5px";
    directnumberEl.text = item.name+": suora puhelinnumero -> ";
    ButtonElement buttonElement = new ButtonElement();
    buttonElement.innerHtml="0.87 &euro;";
    buttonElement.classes.add("btn btn-danger");
    buttonElement.onClick.listen((event)=> paymentfornumber.pay(event,uuid,item,mobileClient, 87,provider));
    directnumberEl.append(buttonElement);
   
  }
  
  var bigphone = querySelector("#bigphone");
  var seleteditemplace = querySelector("#seleteditem");
 
  querySelector("#center").style.display="none";

  var phone ="<i class='fa fa-phone'></i> "+ item.phone;
  var title =item.name+" "+item.age+"v"+" "+item.city;
  var imagelink = item.img.replaceFirst("thumb", "w110shadow");
  
  var phoneElement=new AnchorElement();
  
  phoneElement.href="tel:"+item.phone;
  phoneElement.setInnerHtml("<div>${phone}</div>", treeSanitizer: new NullTreeSanitizer());
  phoneElement.style.color="red";

 
  var imgBlock =new AnchorElement();
  imgBlock.href="tel:"+item.phone;
  
  var imgBlocksInnerHtml = "<div class='media'><img class='media-object' src='${imagelink}' alt=''><div class='media-body'><p class='media-heading pull-left googlefontcont'>"+item.name+" "+item.age+"v "+item.city+"</p></div>"+item.moto+" </div>";
  
  var mediaElement=new AnchorElement();
  mediaElement.href="tel:"+item.phone;
  mediaElement.setInnerHtml(imgBlocksInnerHtml,treeSanitizer: new NullTreeSanitizer());
 
  var placeholdertxt = "Hei "+item.name+"!";
  
  bigphone.append(phoneElement);
  querySelector("#media").append(mediaElement);
  var inputgroup =querySelector("#inputgroup");
  inputgroup.appendHtml("<input id='firstinput' type='text' class='form-control' placeholder='"+placeholdertxt +"'>");
  
  var gotochatebutton = new ButtonElement();
  gotochatebutton.text="Go to Chatti!";
  gotochatebutton.classes.add("btn btn-danger btn-lg");
  gotochatebutton.style.marginTop="15px";
  InputElement submit = querySelector("#firstinput");
  gotochatebutton.onClick.listen((event)=> gotochatevent.go(event,uuid,item,submit));
  
  inputgroup.append(gotochatebutton);
  inputgroup.style.float="right";
   
  
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}