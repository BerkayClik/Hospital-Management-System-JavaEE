let str = new String();
const errorSpan = document.getElementsByClassName("pwError")[0];
const errorSpan2 = document.getElementsByClassName("pw2Error")[0];

function check2(){
    let pw = document.getElementById("pw").value;
    let pw2 = document.getElementById("pw2").value;

    if(pw.length < 6){
        errorSpan.style.display = "inline";
    }
    else{
        errorSpan.style.display = "none";
        if(pw != pw2){
            change("red");
            errorSpan2.style.display = "inline";
        }
        else{
            change("black");
            errorSpan2.style.display = "none";
        }
    }
}

function change(str) {
    $('.passwordInputDiv > input').css("color", str);
    $('.passwordInputDiv2 > input').css("color", str);
}