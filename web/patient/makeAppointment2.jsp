<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="jdk.swing.interop.SwingInterOpUtils" %>

<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/28/2019
  Time: 5:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Make Appointment</title>
    <script src="http://yui.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.timepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/jquery.timepicker.css" />
    <script type="text/javascript" src="../js/bootstrap-datepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-datepicker.css" />
    <script type="text/javascript" src="../js/site.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/site.css"/>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/appointment.css">

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
    <style>
        .dropdown-toggle::after {
            content: "";
        }
        .yui3-button {
            margin:10px 0px 10px 0px;
            color: #fff;
            background-color: #3476b7;
        }
    </style>

</head>
<body  class="yui3-skin-sam">
<div class="wrapper">
    <%
        String selectedDept = "";
        String selectedDate = "";
        String selectedDoctor = "";
        String selectedTimesStart = "";
        String selectedTimesEnd = "";

        if(request.getAttribute("doctorName") != null){
            selectedDoctor = (String) request.getAttribute("doctorName");
        }
//        if(request.getAttribute("timeInForm") != null){
//            selectedTimes = (String) request.getAttribute("");
//        }
    %>

    <%
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("selectedDept")){
                if(cookie.getValue().contains("+")) {
                    String selecteddept = cookie.getValue().replace("+", " ");
                    selectedDept = selecteddept;
                }
                else{
                    selectedDept = cookie.getValue();
                }
            }
            if(cookie.getName().equals("dateInForm2") && !cookie.getValue().equals("")){
                selectedDate = cookie.getValue().split("%2F")[0] + "/" + cookie.getValue().split("%2F")[1];
            }
            if(cookie.getName().equals("timeInForm2") && !cookie.getValue().equals("")){
                selectedTimesStart = cookie.getValue().split("%3A")[0] + ":" + cookie.getValue().split("%3A")[1].split("-")[0];
                selectedTimesEnd = cookie.getValue().split("%3A")[1].split("-")[1] + ":" + cookie.getValue().split("%3A")[2];

                //System.out.println("selectedTimesStart: " + selectedTimesStart);
                //System.out.println("selectedTimesEnd: " + selectedTimesEnd);
            }
        }


    %>

    <%
        boolean success = false;

        for (int i=0; i<cookies.length; i++) {
            if (cookies[i].getName().equals("role_id") && cookies[i].getValue().equals("1")) {
                success = true;
            }
        }
        if(success){
    %>
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
                <div class="yui3-u selectedDate" style="display: block;">
                    <div id="links" style="padding-left:9px; font-family: sans-serif; margin-bottom: 15px;">
                        Selected Dates: &nbsp
                        <span id="selecteddate">
                            <%
                                if(request.getAttribute("date") != null){
                                    out.println(request.getAttribute("date"));
                                } else{
                            %>
                            <%=selectedDate%>
                            <% }%>
                        </span>
                    </div>
                </div>
                <div class="selectedDate" style="padding-left: 9px; height: 40px">
                    <span>Times: </span>
                    <p id="datepairExample" style="display: inline;">
                        <input type="text" name="start" class="time start" style="margin-left: 15px; height: 30px;" onchange="setFormInput(this)" value=<%=selectedTimesStart%>>
                        between
                        <input type="text" name="end" class="time end" style="height: 30px;" onchange="isEqual(), setFormInput2(this)" value=<%=selectedTimesEnd%>>
                    </p>
                </div>

                <div class="selectedDepartment" style="overflow: auto">
                    <span style="font-family: sans-serif; padding-left: 9px;">Select Department: </span>
                    <form action="setDoctorNames2" method="post" id="deptNames" style="float: right; margin-top: -2px;">
                        <select onchange="setDepartment()" id="departments" name="departments" style="margin: 4px 20px 0 0;">
                            <option value=""></option>
                            <%
                                boolean isFirstLoad = true;

                                for(Cookie cookie : cookies){
                                    if(cookie.getName().equals("deptNames")){
                                        isFirstLoad = false;
                                        break;
                                    }
                                }

                                if(isFirstLoad){
                                    response.sendRedirect("/setDeptNames");
                                }

                                boolean isDeptName = false;

                                for(Cookie cookie : cookies){
                                    if(cookie.getName().equals("deptNames")){
                                        isDeptName = true;
                                        break;
                                    }
                                }
                                if(isDeptName){
                                    for(Cookie cookie : cookies){
                                        if(cookie.getName().equals("deptNames")){
                                            String[] deptNames = cookie.getValue().split("%2F");
                                            for(int i=0; i<deptNames.length; i++){
                                                if(deptNames[i].contains("+")){
                                                    String deptName = deptNames[i].replace("+", " ");
                                                    if(selectedDept.equals("")){
                                                        out.println("<option value=\"" + deptName + "\">" + deptName + "</option>");
                                                    }
                                                    else{
                                                        if(selectedDept.equals(deptName)){
                                                            out.println("<option value=\"" + deptName + "\" selected>" + deptName + "</option>");
                                                        }
                                                        else{
                                                            out.println("<option value=\"" + deptName + "\">" + deptName + "</option>");
                                                        }
                                                    }
                                                }
                                                else{
                                                    if(selectedDept.equals("")){
                                                        out.println("<option value=\"" + deptNames[i] + "\">" + deptNames[i] + "</option>");
                                                    }
                                                    else{
                                                        if(selectedDept.equals(deptNames[i])){
                                                            out.println("<option value=\"" + deptNames[i] + "\" selected>" + deptNames[i] + "</option>");
                                                        }
                                                        else{
                                                            out.println("<option value=\"" + deptNames[i] + "\">" + deptNames[i] + "</option>");
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                request.setAttribute("page", "makeApp2");
                            %>
                        </select>
                        <input type="text" name="dateInForm" id="dateInForm" style="display:none" value=<%=selectedDate%>>
                        <input type="text" name="timeInForm" id="timeInForm" style="display:none" value=<%=selectedTimesStart + "-" + selectedTimesEnd%>>
                        <button type="submit" style="display: none">S</button>
                    </form>
                </div>
                <div class="selectedDoctor">
                    <span style="font-family: sans-serif; padding-left: 9px; margin-right: 36px;">Select Doctor: </span>
                    <select onchange="setDoctor()" id="doctors">
                        <option value=""></option>
                        <%
                            for(Cookie cookie : cookies){
                                if(cookie.getName().equals("doctorNames")){
                                    String[] doctorNames = cookie.getValue().split("%2F");
                                    for(int i=0; i<doctorNames.length; i++){
                                        if(doctorNames[i].contains("+")){
                                            String doctorName = doctorNames[i].replace("+", " ");
                                            out.println("<option value=\"" + doctorName + "\">" + doctorName + "</option>");
                                        }
                                        else{
                                            out.println("<option value=\"" + doctorNames[i] + "\">" + doctorNames[i] + "</option>");
                                        }
                                    }

                                }
                            }

                        %>
                    </select>
                </div>

                <form action="makeAppointment2" method="post">
                    <input type="text" name="date" id="trDate" style="display:none">
                    <input type="text" name="times" id="times" style="display:none" value=<%=selectedTimesStart + "-" + selectedTimesEnd%>>
                    <input type="text" name="department" id="department" style="display:none" value=<%=selectedDept%>>
                    <input type="text" name="doctor" id="doctor" style="display:none" value=<%=selectedDoctor%>>
                    <div style="">
                        <button type="submit" name="button" class="showButton" style="margin-top: 2em" onclick="check()">Show</button>
                    </div>
                </form>
            </div>
            <div class="rightContainer">
                <%
                    if(request.getAttribute("html") != null)
                        out.println(request.getAttribute("html"));
                %>
            </div>
        </div>
    </div>
</div>


<!-- jQuery CDN - Slim version (=without AJAX) -->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<!-- Popper.JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>


<script src="../js/isEqual.js"></script>

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
                if(document.getElementById('selecteddate').innerText.length == 10 || document.getElementById('selecteddate').innerText.length == 21) {
                    document.getElementById('selecteddate').innerText = document.getElementById('selecteddate').innerText.substring(0, 10) + "/" + tr_date;
                    document.getElementById("trDate").value = document.getElementById("trDate").value.split("/")[0] + "/" + tr_date;
                    document.getElementById('dateInForm').value = document.getElementById("trDate").value;
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
                    if(parseInt(selectedDate.split("-")[0]) < parseInt(today.split("-")[0])
                        && parseInt(selectedDate.split("-")[1]) == parseInt(today.split("-")[1])){
                        isBefore = true;
                    }
                }
            }
            return isBefore;
        }
    });
</script>



<script type="text/javascript">
    function setFormInput(node){
        if(document.getElementsByClassName("end")[0].value == ""){
            let time = (parseInt(node.value.split(':')[0])+1) + ":" + node.value.split(':')[1];
            if(time == "12:00am"){
                time = "12:00pm";
                console.log(time);
            }
            else if(time == "13:00pm"){
                time = "1:00pm";
            }
            console.log(time == "12:00am");
            document.getElementById('times').value = node.value + "-" + time;
            document.getElementById("timeInForm").value = node.value + "-" + time;

        }
        else{
            console.log("Delay");
            let delay = 300;
            setTimeout(function() {
                document.getElementById('times').value = node.value + "-" + document.getElementsByClassName("end")[0].value;
                document.getElementById("timeInForm").value = node.value + "-" +  document.getElementsByClassName("end")[0].value;
            }, delay);
        }

    }

    function setFormInput2(node){
        document.getElementById('times').value = document.getElementById('times').value.split('-')[0] + "-" + node.value;
        document.getElementById("timeInForm").value = document.getElementById('times').value.split('-')[0] + "-" + node.value;
    }

    let depSelect = document.getElementById("departments");
    let strDepartment = depSelect.options[depSelect.selectedIndex].value;
    document.getElementById("department").value = strDepartment;

    document.getElementById('trDate').value = document.getElementById('selecteddate').innerText;

</script>

<script src="http://jonthornton.github.io/Datepair.js/dist/datepair.js"></script>
<script src="http://jonthornton.github.io/Datepair.js/dist/jquery.datepair.js"></script>
<script>
    $('#datepairExample .time').timepicker({
        'step': 60,
        'showDuration': true,
        'timeFormat': 'g:ia',
        'minTime': '9:00am',
        'maxTime': '19:00pm'
    });

    $('#datepairExample').datepair();

</script>

<script src="../js/appointmentPage.js"></script>

<%} else{
    response.sendRedirect("/user");
}%>
</body>
</html>

