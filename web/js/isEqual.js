function isEqual() {
    if(document.querySelectorAll('p > input')[0].value == document.querySelectorAll('p > input')[1].value){
        document.querySelectorAll('p > input')[0].value = document.querySelectorAll('p > input')[1].value = "";
        alert("Start and End time can not be same");
    }
    if(document.querySelectorAll('p > input')[0].value == "00:00am" && document.querySelectorAll('p > input')[1].value == "12:00am"){
      document.querySelectorAll('p > input')[0].value = document.querySelectorAll('p > input')[1].value = "";
      alert("Start and End time can not be same");
    }
}

function isEqual2() {
    if(document.querySelectorAll('p > input')[2].value == document.querySelectorAll('p > input')[3].value){
        document.querySelectorAll('p > input')[2].value = document.querySelectorAll('p > input')[3].value = "";
        alert("Start and End time can not be same");
    }
    if(document.querySelectorAll('p > input')[2].value == "00:00am" && document.querySelectorAll('p > input')[3].value == "12:00am"){
      document.querySelectorAll('p > input')[2].value = document.querySelectorAll('p > input')[3].value = "";
      alert("Start and End time can not be same");
    }
}

function isEqualLoop() {
    //console.log("hit");
    for(let i=0; i<document.querySelectorAll('p > input').length; i=i+2){
        //console.log(i);
        if((document.querySelectorAll('p > input')[i].value == document.querySelectorAll('p > input')[i+1].value)
            && document.querySelectorAll('p > input')[i].value != ""
            && document.querySelectorAll('p > input')[i+1].value != ""){
            document.querySelectorAll('p > input')[i].value = document.querySelectorAll('p > input')[i+1].value = "";
            alert("Start and End Time can not be same");
        }
    }
}

function setFullDay(node){
  let startTimeInp = node.previousElementSibling.firstElementChild;
  let endTimeInp = startTimeInp.nextElementSibling;

  startTimeInp.value = "00:00am";
  endTimeInp.value = "23:59pm";
}

function reset(){
  document.getElementsByClassName('start')[0].value = "";
  document.getElementsByClassName('end')[0].value = "";
}

function setFormInput(node){
  let time = (parseInt(node.value.split(':')[0])+1) + ":" + node.value.split(':')[1];
  if(time == "12:00am"){
    time = "12:00pm";
    console.log(time);
  }
  else if(time == "13:00pm"){
    time = "1:00pm";
  }
  console.log(time == "12:00am");
  document.getElementById('times').value = node.value + "-" + time;
}

function setFormInput2(node){
  document.getElementById('times').value = document.getElementById('times').value.split('-')[0] + "-" + node.value;
}

function check() {
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;

    var date = document.getElementById('inputMDEx').value;
    if (date.length==10) {

        var d1 = Date.parse(date);
        var d2 = Date.parse(today);
        if (d1 <= d2) {
            document.getElementById('inputMDEx').value = yyyy + "-" + mm + "-" + dd;
            alert("Today is: " + today + " Please select a date in the future");
        }
        console.log("today= " + today);
        console.log("date = " + date);
    }

}