let doneButtonDiv = document.getElementsByClassName('doneButtonDiv')[0];
let whenDoneDiv = document.getElementsByClassName('whenDoneDiv')[0];


var bool;
var hh, mm;
var t;

function done() {
    doneButtonDiv.style.display = "none";
    whenDoneDiv.style.display = "block";
}

function set(node) {
  console.log("worked");
  console.log(node.value);
  if(node.value == "")
    node.value = "09:00";
}

function setNext(node) {
    if(node.value != ""){
      if(node.nextSibling.nextSibling.value == ""){
        if(node.value[node.value.length-1] == 9){//--:-9
          if(node.value[node.value.length-2] == 5){//--:59
            if(node.value == "23:59"){//23:59 or 13:59
              t = "00:00";
            }
            else if(node.value[node.value.length-4] == 9){//19:59 or 09:59
              t = "" + (parseInt(node.value[0])+1) + "0:00";
            }
            else{//14:59
              t = node.value[0] + "" + (parseInt(node.value[1])+1) + ":00"
            }
            node.nextSibling.nextSibling.value = t;
          }
          else{
            t = node.value.substring(0,3) + "" + (parseInt(node.value[3])+1) + "0";
            node.nextSibling.nextSibling.value = t;
          }
        }
        else{
          t = node.value.substring(0,4) + "" + (parseInt(node.value[4])+1);
          console.log(t);
          node.nextSibling.nextSibling.value = t;
        }
      }
      else{
        //End time is greater than start time HERE
        hh = node.value.substring(0,2);
        mm = node.value.substring(3,5);
        if(parseInt(node.nextSibling.nextSibling.value.substring(0,2)) < parseInt(hh)){
          if(node.value[node.value.length-1] == 9){//--:-9
            if(node.value[node.value.length-2] == 5){//--:59
              if(node.value == "23:59"){//23:59 or 13:59
                t = "00:00";
              }
              else if(node.value[node.value.length-4] == 9){//19:59 or 09:59
                t = "" + (parseInt(node.value[0])+1) + "0:00";
              }
              else{//14:59
                t = node.value[0] + "" + (parseInt(node.value[1])+1) + ":00"
              }
              node.nextSibling.nextSibling.value = t;
            }
            else{
              t = node.value.substring(0,3) + "" + (parseInt(node.value[3])+1) + "0";
              node.nextSibling.nextSibling.value = t;
            }
          }
          else{
            t = node.value.substring(0,4) + "" + (parseInt(node.value[4])+1);
            node.nextSibling.nextSibling.value = t;
          }
        }
        else{
          if(((parseInt(node.nextSibling.nextSibling.value.substring(3,5)) < parseInt(mm)) && (parseInt(node.nextSibling.nextSibling.value.substring(0,2)) < parseInt(hh))) || (parseInt(node.nextSibling.nextSibling.value.substring(0,2)) == parseInt(hh))){
            if(node.value[node.value.length-1] == 9){//--:-9
              if(node.value[node.value.length-2] == 5){//--:59
                if(node.value == "23:59"){//23:59 or 13:59
                  t = "00:00";
                }
                else if(node.value[node.value.length-4] == 9){//19:59 or 09:59
                  t = "" + (parseInt(node.value[0])+1) + "0:00";
                }
                else{//14:59
                  t = node.value[0] + "" + (parseInt(node.value[1])+1) + ":00"
                }
                node.nextSibling.nextSibling.value = t;
              }
              else{
                t = node.value.substring(0,3) + "" + (parseInt(node.value[3])+1) + "0";
                node.nextSibling.nextSibling.value = t;
              }
            }
            else{
              t = node.value.substring(0,4) + "" + (parseInt(node.value[4])+1);
              node.nextSibling.nextSibling.value = t;
            }
          }
        }
      }
    }
}

function checkBefore(node) {
  hh = node.value.substring(0,2);
  mm = node.value.substring(3,5);

    if(node.previousSibling.previousSibling.value == ""){
      node.previousSibling.previousSibling.value = node.value;
    }
    else{
      if(parseInt(node.previousSibling.previousSibling.value.substring(0,2)) > parseInt(hh)){
        if(parseInt(node.previousSibling.previousSibling.value.substring(3,5) == 59)){
          t = (parseInt(node.previousSibling.previousSibling.value.substring(0,2))+1) + ":00"
        }
        else{
          t = node.previousSibling.previousSibling.value.substring(0,3) + "" + (parseInt(node.previousSibling.previousSibling.value.substring(3,5))+1);
        }
        node.value = t;
        alert("Start time can not be greater than or equal to End time");
      }
      else{
        if(((parseInt(node.previousSibling.previousSibling.value.substring(3,5)) > parseInt(mm)) && (parseInt(node.previousSibling.previousSibling.value.substring(3,5)) == parseInt(mm)))){
          if((parseInt(node.previousSibling.previousSibling.value.substring(0,2)) == parseInt(hh))){

          console.log("LINE125");
          console.log(parseInt(node.previousSibling.previousSibling.value.substring(3,5)) > parseInt(mm));
          console.log(parseInt(node.previousSibling.previousSibling.value.substring(3,5)) == parseInt(mm));
          console.log("all if:");
          console.log(((parseInt(node.previousSibling.previousSibling.value.substring(3,5)) > parseInt(mm)) && (parseInt(node.previousSibling.previousSibling.value.substring(3,5)) == parseInt(mm))) || (parseInt(node.previousSibling.previousSibling.value.substring(0,2)) == parseInt(hh)));
          if(parseInt(node.previousSibling.previousSibling.value.substring(3,5)) == 59){
            t = (parseInt(node.previousSibling.previousSibling.value.substring(0,2))+1) + ":00";
          }
          else{
              t = node.previousSibling.previousSibling.value.substring(0,3) + "" + (parseInt(node.previousSibling.previousSibling.value.substring(3,5))+1);
          }
          node.value = t;
          alert("Start time can not be greater than or equal to End time");
          }
        }
      }
    }
}

function checkNext(){

}

function fullDay(node){
    node.previousSibling.previousSibling.previousSibling.value = "09:00";
    node.previousSibling.value = "24:00";
}

function reset(node) {
    node.previousSibling.previousSibling.value = "";
    node.previousSibling.previousSibling.previousSibling.previousSibling.value = "";
}

function createForm(){
  let cont = document.getElementById('container');

  let form = document.createElement('form');
  form.setAttribute("action", "setOD");
  form.setAttribute("method", "post");
  form.setAttribute("style", "display: flex; justify-content: center;");

  form.innerHTML = "<input type=\"text\" name=\"days\" value=\"\" id=\"formDays\">" +
  "<input type=\"text\" name=\"times\" value=\"\" id=\"formTimes\">" +
  "<button type=\"submit\" name=\"button\">Set</button>";

  cont.appendChild(form);
  setFormInp();

  document.querySelector('form > button').click();
}

function setFormInp(){
    let formDays = document.getElementById('formDays');
    let formTimes = document.getElementById('formTimes');

    let daysList = document.getElementById('selectedDays');
    let liDay = daysList.firstChild;

    let timesList = document.getElementById('times');
    let liTime = timesList.firstChild;

    while(liDay.nextSibling){
      formDays.value = formDays.value + liDay.innerText + "/";
      liDay = liDay.nextSibling;
    }
    formDays.value = formDays.value + liDay.innerText + "/";

    while(liTime.nextSibling){
      let inp1 = liTime.firstChild;
      let inp2 = inp1.nextSibling.nextSibling;

      formTimes.value = formTimes.value + inp1.value + "-" + inp2.value + "/";

      liTime = liTime.nextSibling;
    }
    formTimes.value = formTimes.value + liTime.firstChild.value + "-" + liTime.firstChild.nextSibling.nextSibling.value + "/";
}
