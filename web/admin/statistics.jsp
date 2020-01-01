<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/22/2019
  Time: 11:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Statistics</title>
    <script src="http://yui.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/appointment.css">

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
</head>
<body  class="yui3-skin-sam">
<%
    Cookie[] cookies = request.getCookies();
    boolean success = false;

    for (int i=0; i<cookies.length; i++) {
        if (cookies[i].getName().equals("role_id") && cookies[i].getValue().equals("3")) {
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
                <li class="active">
                    <a href="">Statistics</a>
                </li>
                <li>
                    <a href="users.jsp">Users</a>
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

        <div class="container">
            <div class="" style="display: flex; justify-content: center">
                <div id="demo" class="yui3-skin-sam yui3-g" style="margin-right: 1em;">
                    <div class="yui3-u calender" style="position: relative">
                        <div id="mycalendar"></div>
                    </div>
                </div>

                <div id="demo" class="yui3-skin-sam yui3-g" style="margin-left: 1em">
                    <div class="yui3-u calender" style="position: relative">
                        <button style="position: absolute; right: -70px; padding: 5px 10px; border-radius: 11px;" class="btn btn-info" onclick="window.location.href = 'makeAppointment.jsp';">Click</button>
                        <div id="mycalendar2"></div>
                    </div>
                </div>
            </div>

            <div style="display: flex; justify-content: space-evenly; margin-top: -25px">
                <span style="display: block; margin-right: -35px;">Start Date</span>
                <span style="display: block">End Date</span>
            </div>

            <span style="font-style: italic;font-size: 0.8rem;text-align: center;display: block;margin-top: 15px;margin-bottom: 26px;">To check only one day, click to right-upper button</span>

            <div class="leftContainer">
                <div class="yui3-u selectedDate" style="display: block; text-align: center">
                    <div id="links" style="padding-left:9px; font-family: sans-serif; margin-bottom: 15px; margin-left: -145px;">
                        Selected Dates: &nbsp
                        <span id="selecteddate">
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <form action="statistics" method="post">
            <input type="text" name="date" id="trDate" style="">
            <div style="">
                <button type="submit" name="button" class="showButton" style="margin-top: 2em" onclick="check()">Show</button>
            </div>
        </form>

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
<script type="text/javascript">
    YUI().use('calendar', 'datatype-date', 'cssbutton',  function(Y) {
        var calendar = new Y.Calendar({
            contentBox: "#mycalendar",
            width:'340px',
            showPrevMonth: true,
            showNextMonth: true,
            disabledDatesRule: "sundays",
            date: new Date(2020,00,1)}).render();

        var calendar2 = new Y.Calendar({
            contentBox: "#mycalendar2",
            width:'340px',
            showPrevMonth: true,
            showNextMonth: true,
            disabledDatesRule: "sundays",
            date: new Date(2020,00,1)}).render();

        var rules = {
            "all": {
                "all": {
                    "all": {
                        "0,0": "sundays",
                    }
                }
            }
        };

        calendar.set("customRenderer", {
            rules: rules,
            filterFunction: function (date, node, rules) {
                if (Y.Array.indexOf(rules, 'sundays') >= 0) {
                    node.addClass("redtext");
                }
            }
        });

        calendar2.set("customRenderer", {
            rules: rules,
            filterFunction: function (date, node, rules) {
                if (Y.Array.indexOf(rules, 'sundays') >= 0) {
                    node.addClass("redtext");
                }
            }
        });

        var dtdate = Y.DataType.Date;

        calendar.on("selectionChange", function (ev) {
            var newDate = ev.newSelection[0];
            //Y.one("#selecteddate").setHTML(dtdate.format(newDate));
            let date =  dtdate.format(newDate);
            let tr_date = date.substring(8,10) + "-" + date.substring(5,7) + "-" + date.substring(0,4);
            console.log("tr_date: " + tr_date);
            if(checkWithCurrentDate(tr_date)){

            }
            else{
                document.getElementById('selecteddate').innerText = tr_date;
                document.getElementById("trDate").value = tr_date;
            }
        });

        calendar2.on("selectionChange", function (ev) {
            var newDate = ev.newSelection[0];

            let date = dtdate.format(newDate);
            let tr_date = date.substring(8,10) + "-" + date.substring(5,7) + "-" + date.substring(0,4);//Gün-ay-yıl

            if(isBigger(tr_date)){
                alert("You can not select end date before or equal to the start date");
                document.getElementById("trDate").value = document.getElementById("trDate").value.split("/")[0];
                document.getElementById('selecteddate').innerText = document.getElementById('selecteddate').innerText.substring(0,10);
            }
            else{
                if(document.getElementById('selecteddate').innerText.length == 10 || document.getElementById('selecteddate').innerText.length == 21){
                    document.getElementById('selecteddate').innerText = document.getElementById('selecteddate').innerText.substring(0,10) + "/" + tr_date;
                    document.getElementById("trDate").value = document.getElementById("trDate").value.split("/")[0] + "/" + tr_date;
                }
                else{
                    alert("Select start date");
                }

            }

        });

        function isBigger(date){
            let isBigger = false;

            if(parseInt(document.getElementById("trDate").value.substring(6)) > parseInt(date.substring(6))){
                isBigger = true;
            }
            else{
                if(parseInt(document.getElementById("trDate").value.split("-")[1]) > parseInt(date.split("-")[1])
                    && parseInt(document.getElementById("trDate").value.substring(6)) > parseInt(date.substring(6))){
                    isBigger = true;
                }
                else{
                    if(parseInt(document.getElementById("trDate").value.split("-")[0]) >= parseInt(date.split("-")[0])
                        && parseInt(document.getElementById("trDate").value.split("-")[1]) == parseInt(date.split("-")[1])){
                        isBigger = true;
                    }
                }
            }
            return isBigger;
        }

        function checkWithCurrentDate(date){
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
            var yyyy = today.getFullYear();

            today = dd + '-' + mm + '-' + yyyy;

            console.log("today= " + today);
            if(isBefore(date, today)){
                console.log("statement: " + isBefore(date, today));
                alert("Today is: " + today + ", you cannot select previous days");
                return true;
            }
            else{
                console.log("statement: " + isBefore(date, today));
                return false;
            }
        }

        function isBefore(selectedDate, today){
            let isBefore = false;
            if(parseInt(selectedDate.split("-")[2]) < parseInt(today.split("-")[2])){
                isBefore = true;
            }
            else{
                if(parseInt(selectedDate.split("-")[1]) < parseInt(today.split("-")[1])
                    && parseInt(selectedDate.split("-")[2]) == parseInt(today.split("-")[2])){
                    isBefore = true;
                }
                else{
                    if(parseInt(selectedDate.split("-")[0]) <= parseInt(today.split("-")[0])
                        && parseInt(selectedDate.split("-")[1]) == parseInt(today.split("-")[1])){
                        isBefore = true;
                    }
                }
            }
            return isBefore;
        }
    });
</script>



</body>
</html>
