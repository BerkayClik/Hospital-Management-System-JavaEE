let doneButtonDiv = document.getElementsByClassName('doneButtonDiv')[0];
let whenDoneDiv = document.getElementsByClassName('whenDoneDiv')[0];


var bool;
var hh, mm;
var t;

function done() {
    doneButtonDiv.style.display = "none";
    whenDoneDiv.style.display = "block";
}

function fullDay(node){
    node.previousSibling.previousSibling.previousSibling.value = "09:00am";
    node.previousSibling.value = "12:00am";
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

  form.innerHTML = "<input type=\"text\" name=\"days\" value=\"\" id=\"formDays\" style='display: none'>" +
  "<input type=\"text\" name=\"times\" value=\"\" id=\"formTimes\" style='display: none'>" +
  "<button type=\"submit\" name=\"button\" style='display: none'>Set</button>";

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
      let inp1 = liTime.firstChild.firstChild;
      let inp2 = inp1.nextSibling.nextSibling;

      formTimes.value = formTimes.value + inp1.value + "-" + inp2.value + "/";

      liTime = liTime.nextSibling;
    }
    formTimes.value = formTimes.value + liTime.firstChild.firstChild.value + "-" + liTime.firstChild.firstChild.nextSibling.nextSibling.value + "/";
}
