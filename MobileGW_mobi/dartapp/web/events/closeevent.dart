import 'dart:html';


close(event){
 
//  querySelector("#rssfeeder").hidden=false;
  querySelector("#center").style.display="block";
//  querySelector('#close').hidden=true;
  querySelector('#close').style.display="none";
  var seleteditemplace = querySelector("#seleteditem");
  if (seleteditemplace.hasChildNodes()) {
    
    seleteditemplace.children.clear();
  }
  
}