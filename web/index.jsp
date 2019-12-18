<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/15/2019
  Time: 3:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Login to System</title>
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery-3.2.1.min.js"></script>

  </head>
  <body>
  <form action="login" method="post">
    <div>
      <label style="display: block; padding-left: 0.3em;">LOGIN</label>
    </div>
    <div class="emailInputDiv">
      <label class="email">Email </label>
      <%if((request.getAttribute("email") == null)){%>
      <input type="text" name="email" id="em">
      <%} else{%>
      <input type="text" name="email" id="em" value="<%= (String) request.getAttribute("email")%>">
      <%}%>
    </div>
    <div class="passwordInputDiv">
      <label class="password">Password</label>
      <input type="password" name="password" id="pw">
    </div>
    <div style="padding-bottom: 1.2em; margin-bottom: 1.5em">
      <%
        String status = (String) request.getAttribute("status");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
      %>
      <% if (status != null && status.equals("fail") && !email.equals("") && !password.equals("")) { %>
      <div style="padding:0;" class="error">
        Password or Email is wrong!
      </div>
      <%}%>
    </div>
    <div style="margin-bottom: 0.5em">
      <button type="submit" class="signInButton" onclick="check()">
        <span>Sign In</span>
      </button>
    </div>
    <div class="signUp">
      <span>Don't have account? >> </span>
      <a href="register.jsp">Sign Up</a>
    </div>
    <div class="signUp">
          <span>Jump to Patient Home >> </span>
          <a href="patient/home.jsp">Click</a>
    </div>
    <div class="signUp">
      <span>Jump to Doctor Home >> </span>
      <a href="doctor/home.jsp">Click</a>
    </div>
  </form>

  <%
    String regStatus = (String) request.getAttribute("regStatus");
  %>
  <% if (regStatus != null && regStatus.equals("success")){ %>
  <script type="text/javascript">
    alert("You have registered.");
  </script>
  <%}%>
  <script src="js/hover&focus.js"></script>
  <script src="js/blankInput.js"></script>
  </body>
</html>
