<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/18/2019
  Time: 12:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/20/2019
  Time: 12:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Upcoming Appointments</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="../css/apps.css">
    <link rel="stylesheet" href="../css/inputspinner.css">
    <link rel="stylesheet" href="../css/handle-counter.css">

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
        if (cookies[i].getName().equals("role_id") && cookies[i].getValue().equals("1")) {
            success = true;
        }
    }
    if(request.getAttribute("done") != null){
%>
<script type="text/javascript">
    alert("Appointment Cancelled");
</script>


<%}
    if(success){
        String value = "1";
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
                <li class="active">
                    <a href="home.jsp">Home</a>

                </li>
                <li>
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Appointment</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">
                        <li>
                            <a href="makeAppointment.jsp">Make Appointment</a>
                        </li>
                        <li>
                            <a href="upcoming_appointments.jsp">Upcoming Appointments</a>
                        </li>
                        <li>
                            <a href="previous_appointments.jsp">Previous Appointments</a>
                        </li>
                        <li>
                            <a href="filter_appointment.jsp">Filter Appointments</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="personal_info.jsp">Personal Info</a>
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

        <div class="main-content">
            <div class="main-form">
                <div class="formDiv">
                    <span>Upcoming appointments in (days): </span>
                    <div class="handle-counter" id="handleCounter">
                        <button class="counter-minus btn btn-primary">-</button>
                        <input type="text" style="height: 38px; padding: 6px 12px;" value=<%=value%>>
                        <button class="counter-plus btn btn-primary">+</button>
                    </div>
                </div>
            </div>
            <form class="" action="upcomingApp2" method="post" style="width: 30%; margin: 20px auto;">
                <input type="text" name="days" value="1" style="display: none;">
                <button type="submit" class="btn btn-primary" aria-pressed="false" style="display: block; margin-top: 7px;">Show</button>
            </form>
        </div>

        <div class="result" style="display: flex; justify-content: space-evenly;">
            <%
                if(request.getAttribute("html") != null)
                    out.println(request.getAttribute("html"));
            %>
        </div>

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

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="../js/handleCounter.js"></script>
<script>
    $(function ($) {
        var options = {
            minimum: 1,
            maximize: null,
            onChange: valChanged,
            onMinimum: function(e) {
                console.log('reached minimum: '+e)
            },
            onMaximize: function(e) {
                console.log('reached maximize'+e)
            }
        }
        $('#handleCounter').handleCounter(options)
    })
    function valChanged(d) {
        set();
    }

    function cancel(node){
        console.log("cancelling");
        let i = 0;
        let li = node.parentElement;
        document.getElementById('time').value = li.innerText;

        console.log(li.innerText);
        while (li.previousSibling){
            i++;
            li = li.previousSibling;
            if(li.previousSibling.innerText == "Time")
                break;
        }
        console.log(i);

        let dateList = document.querySelectorAll('.result>ul')[0].firstElementChild;
        let x = -1;
        while(true){
            dateList = dateList.nextSibling;
            x++;
            if(x==i)
                break;
        }
        document.getElementById('trDate').value = dateList.innerText;

        let doctorList = document.querySelectorAll('.result>ul')[1].firstElementChild;
        x = -1;
        while(true){
            doctorList = doctorList.nextElementSibling;
            x++;
            if(x==i)
                break;
        }
        document.getElementById('doctor').value = doctorList.innerText;

        document.getElementsByClassName('showButton')[0].click();
    }

</script>
<script src="../js/changeNumber.js"></script>



</body>
</html>


