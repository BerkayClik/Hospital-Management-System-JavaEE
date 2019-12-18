let e = document.getElementById("doctors");
let depSelect = document.getElementById("departments");

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
    let strDepartment = depSelect.options[depSelect.selectedIndex].value;
    document.getElementById("department").value = strDepartment;
}

function setDoctor() {
    let strDoctor = e.options[e.selectedIndex].value;
    document.getElementById("doctor").value = strDoctor;
}