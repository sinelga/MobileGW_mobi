import '../domains.dart';
import 'dart:html';
import 'closeevent.dart' as closeevent;

var start = false;
var close = DivElement;

show(event,List<Character> forMarkList) {

  if (!start) {
    
    close = new Element.html("<i class='fa fa-times-circle-o fa-2x'></i>");
    close.onClick.listen((event) => closeevent.close(event));
    var closeelem = querySelector('#close');
    closeelem.append(close);
    start=true;
    
  } else {

    querySelector('#close').style.display="block";
    
  }
  
  var seleteditemplace = querySelector("#seleteditem");
  
//  querySelector("#rssfeeder").hidden=true;
  querySelector("#center").style.display="none";
  
  var itemid = int.parse(event.currentTarget.id);
//  var itemid = int.parse(event.target.);
  var item = forMarkList[itemid];
  var phone = item.phone;
  var title =item.name+" "+item.age+"v"+" "+item.city;
//  var pubdate = item.PubDate;
  var imagelink = item.img.replaceFirst("thumb", "h240shadow");
  var cont = item.moto;
  
//  var ads = "<script async src='//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js'></script><ins class='adsbygoogle' style='display:inline-block;width:180px;height:150px' data-ad-client='ca-pub-4265026941264081' data-ad-slot='9659344258'></ins> <script> (adsbygoogle = window.adsbygoogle || []).push({}); </script>";
  
  var htmlstr="<p class='bigphone'>${phone}</p> <div> ${title}</div><div class='media'><img class='media-object img-rounded' src='${imagelink}' alt=''><div class='media-body'><p class='media-heading googlefontcont'>${cont}</p></div></div> ";
  
//  var divElement = new DivElement();
  var divElement=new AnchorElement();
  divElement.href="tel:"+item.phone;
  divElement.setInnerHtml(htmlstr, treeSanitizer: new NullTreeSanitizer() );
  
  if (seleteditemplace.hasChildNodes()) {

    seleteditemplace.children.clear();
    seleteditemplace.append(divElement);
  } else {

    seleteditemplace.append(divElement);
  }
  
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}