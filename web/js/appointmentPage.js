let e = document.getElementById("doctors");


function  check() {
    let date = document.getElementById("trDate").value;
    let strDoctor = e.options[e.selectedIndex].value;

    if(date == ""){
        alert("Select a Date");
    }
    else{
        if(strDoctor == "")
            alert("Select a Doctor");
    }
}

function setDepartment() {
    document.getElementById("dateInForm").value = document.querySelector('#links').innerText.substring(17,27);
    console.log("button clicked");
    document.querySelector('#deptNames > button').click();
}

function setDoctor() {
    let strDoctor = e.options[e.selectedIndex].value;
    document.getElementById("doctor").value = strDoctor;
}