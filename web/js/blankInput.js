
function check(){
    let pw = document.getElementById("pw").value;
    let pw2 = document.getElementById("pw2").value;
    let em = document.getElementById("em").value;
    let name = document.getElementById("name").value;

    if(name === '')
        alert("Enter your name");
    else{
        if(pw === '' || em === '')
            alert("Email or password can't be blank");
        else{
            if(pw2 == ''){
                alert("Confirm your password");
            }else{
                if(pw != pw2){
                    alert("Passwords does not match");
                }
            }
        }
    }
}