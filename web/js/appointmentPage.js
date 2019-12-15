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

function setName() {
    let strDoctor = e.options[e.selectedIndex].value;
    document.getElementById("doctor").value = strDoctor;
}