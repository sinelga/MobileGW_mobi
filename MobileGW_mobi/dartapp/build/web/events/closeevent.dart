library closeevent;

import 'dart:html';


close(event){

  querySelector("#center").style.display="block";
  querySelector('#close').style.display="none";
  var seleteditemplace = querySelector("#seleteditem");
  if (seleteditemplace.hasChildNodes()) {    
    seleteditemplace.children.clear();
  }
  if (querySelector("#bigphone").hasChildNodes()) {
    querySelector("#bigphone").children.clear();   
  }
  if (querySelector("#media").hasChildNodes()) {
    querySelector("#media").children.clear();   
  }
  if (querySelector("#inputgroup").hasChildNodes()) {
    querySelector("#inputgroup").children.clear();   
  }
  
}