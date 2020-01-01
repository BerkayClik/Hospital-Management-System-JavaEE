<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/14/2019
  Time: 11:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery-3.2.1.min.js"></script>
</head>
<body>
    <form action="register" method="post">
        <div>
            <label style="display: block; padding-left: 0.3em;">REGISTER</label>
        </div>

        <div class="emailInputDiv">
            <label class="email">Email </label>
            <%if((request.getAttribute("email") == null)){%>
            <input type="text" name="email" id="em">
            <%} else{%>
            <input type="text" name="email" id="em" value="<%= (String) request.getAttribute("email")%>">
            <%}%>
            <%if((request.getAttribute("isExists") != null)){%>
            <span class="pwError" style="">User Exists</span>
            <%}%>
            <%if((request.getAttribute("isInvalidEmail") != null)){%>
            <span class="pwError" style="">Invalid Email</span>
            <%}%>
        </div>

        <div class="nameInputDiv">
            <label class="name">Name</label>
            <%if((request.getAttribute("name") == null)){%>
            <input type="text" name="name" id="name">
            <%} else{%>
            <input type="text" name="name" id="name" value="<%= (String) request.getAttribute("name")%>">
            <%}%>
        </div>

        <div class="passwordInputDiv">
            <label class="password">Password</label>
            <%if((request.getAttribute("pw") != null)){%>
                <input type="password" name="password" oninput="check2()" id="pw" value="<%= (String) request.getAttribute("pw")%>">
            <%} else{%>
                <input type="password" name="password" oninput="check2()" id="pw">
            <%}%>
            <span class="pwError" style="display: none">Password Should be at least 6 characters</span>
        </div>

        <div class="passwordInputDiv2">
            <label class="password">Confirm Password</label>
            <%if((request.getAttribute("pw") != null)){%>
            <input type="password" name="password2" oninput="check2()" id="pw2" value="<%= (String) request.getAttribute("pw2")%>">
            <%} else{%>
            <input type="password" name="password2" oninput="check2()" id="pw2">
            <%}%>
            <span class="pw2Error" style="display: none">Passwords does not match</span>
        </div>

        <div style="margin-bottom: 0.5em">
            <button type="submit" class="signInButton" onclick="check()">
                <span>Sign Up</span>
            </button>
        </div>
        <div class="signIn">
            <span>Already have account? >> </span>
            <a href="index.jsp">Sign In</a>
        </div>
    </form>



    <script src="js/blankInput.js"></script>
    <script src="js/hover&focus.js"></script>
    <script src="js/register.js"></script>

</body>
</html>
