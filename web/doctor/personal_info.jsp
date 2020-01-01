<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/18/2019
  Time: 12:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Personal Info</title>
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="../css/home.css">

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
    <style>
        .dropdown-toggle::after {
            content: "";
        }
    </style>

</head>
<body>
<%
    Cookie[] cookies = request.getCookies();
    boolean success = false;

    for (int i=0; i<cookies.length; i++) {
        if (cookies[i].getName().equals("role_id") && cookies[i].getValue().equals("2")) {
            success = true;
        }
    }
    if(success){
%>
<div class="wrapper">

    <!-- Sidebar -->
    <nav id="sidebar">
        <div class="whole">
            <div class="sidebar-header">
                <h3>Hospital Management System</h3>
            </div>

            <ul class="list-unstyled components">
                <p>Welcome</p>
                <li>
                    <a href="home.jsp">Home</a>

                </li>
                <li>
                    <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">View Appointments</a>
                    <ul class="collapse list-unstyled" id="homeSubmenu">
                        <li>
                            <a href="upcoming_appointments.jsp">Future Appointments</a>
                        </li>
                        <li>
                            <a href="previous_appointments.jsp">Past Appointments</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="reserve_room.jsp">Reserve Room</a>
                </li>
                <li>
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Off-Day</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">
                        <li>
                            <a href="setOffDays.jsp">Set Off-Day</a>
                        </li>
                        <li class="active">
                            <a href="showOffDays.jsp">Show Off-Days</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="">Personal Info</a>
                </li>
            </ul>
            <div class="push"></div>
        </div>
        <div class="logout">
            <ul class="list-unstyled components" style="padding: 0">
                <li>
                    <a href="../index.jsp" style="margin-top: -75px; padding-left: 10px">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Page Content -->
    <div id="content">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">

                <button type="button" id="sidebarCollapse" class="btn btn-info">
                    <i class="fas fa-align-left"></i>
                    <span>Hide</span>
                </button>

            </div>
        </nav>

    </div>

</div>

<%} else{
    response.sendRedirect("/user");
}%>
<!-- jQuery CDN - Slim version (=without AJAX) -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<!-- Popper.JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

<script type="text/javascript">
    $(document).ready(function () {

        $('#sidebarCollapse').on('click', function () {
            $('#sidebar').toggleClass('active');
            let bar = document.getElementById('sidebarCollapse');
            let content = bar.querySelector('span').innerText

            if(content == "Show Sidebar")
                bar.querySelector('span').innerText = "Hide";
            else
                bar.querySelector('span').innerText = "Show";
        });

    });
</script>

</body>
</html>

