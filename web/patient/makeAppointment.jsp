<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="jdk.swing.interop.SwingInterOpUtils" %>

<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/15/2019
  Time: 10:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Make Appointment</title>
    <script src="http://yui.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>
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

        if(request.getAttribute("doctorName") != null){
            selectedDoctor = (String) request.getAttribute("doctorName");
        }
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
            if(cookie.getName().equals("dateInForm")){
                selectedDate = cookie.getValue();
            }
        }

        //System.out.println(selectedDept + "l64");
        //System.out.println(selectedDate);
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
                <li>
                    <a href="home.jsp">Home</a>

                </li>
                <li>
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Appointment</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">
                        <li class="active">
                            <a href="">Make Appointment</a>
                        </li>
                        <li>
                            <a href="view_appointment.jsp">View Appointment</a>
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
                    <a href="#" style="margin-top: -75px; padding-left: 10px">Logout</a>
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
                    <span>Hide Sidebar</span>
                </button>

            </div>
        </nav>

        <div class="container">
            <div id="demo" class="yui3-skin-sam yui3-g">
                <div class="yui3-u calender">
                    <div id="mycalendar"></div>
                </div>

            </div>
            <div class="leftContainer">

                <div class="yui3-u selectedDate" style="display: block;">
                    <div id="links" style="padding-left:9px; font-family: sans-serif;">
                        Selected Date: &nbsp
                        <span id="selecteddate">
                            <%
                                //System.out.println("line144 in page: " + request.getAttribute("date"));
                                if(request.getAttribute("date") != null){
                                    out.println(request.getAttribute("date"));
                                } else{
                            %>
                            <%=selectedDate%>
                            <% }%>
                        </span>
                    </div>
                </div>

                <div class="selectedDepartment" style="overflow: auto">
                    <span style="font-family: sans-serif; padding-left: 9px;">Select Department: </span>
                    <form action="setDoctorNames" method="post" id="deptNames" style="float: right; margin-top: -2px;">
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
                            %>
                        </select>
                        <input type="text" name="dateInForm"  id="dateInForm" style="display: none" value=<%=selectedDate%>>
                        <button type="submit" style="display: none">S</button>
                    </form>
                </div>
                <div class="selectedDoctor">
                    <span style="font-family: sans-serif; padding-left: 9px; margin-right: 36px;">Select Doctor: </span>
                    <select onchange="setDoctor()" id="doctors">
                        <option value=""></option>
                        <%
                            for(Cookie cookie : cookies){
                                //System.out.println("cookie Name: " + cookie.getName());
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

                <form action="makeAppointment" method="post">
                    <input type="text" name="date" id="trDate" style="display:none">
                    <input type="text" name="department" id="department" style="display:none" value=<%=selectedDept%>>
                    <input type="text" name="doctor" id="doctor" style="display:none" value=<%=selectedDoctor%>>
                    <div style="">
                        <button type="submit" name="button" class="showButton" style="margin-top: 2em" onclick="check()">Show</button>
                    </div>
                </form>
            </div>
            <div class="rightContainer">
                <%
                    //System.out.println(request.getAttribute("html"));
                    if(request.getAttribute("html") != null)
                        out.println(request.getAttribute("html"));

                    //System.out.println(request.getAttribute("html"));
                %>
            </div>
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
                bar.querySelector('span').innerText = "Hide Sidebar";
            else
                bar.querySelector('span').innerText = "Show Sidebar";
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
            date: new Date(2020,00,1)}).render();


        var dtdate = Y.DataType.Date;

        calendar.on("selectionChange", function (ev) {
            var newDate = ev.newSelection[0];
            Y.one("#selecteddate").setHTML(dtdate.format(newDate));
            let date = document.getElementById("selecteddate").innerText;
            let tr_date = date.substring(8,10) + "-" + date.substring(5,7) + "-" + date.substring(0,4);
            Y.one("#selecteddate").setHTML(tr_date);
            if(document.getElementById('resTime') == null)
                document.getElementById("trDate").value = tr_date;
            else{
                document.getElementById("trDate").value = tr_date;
                document.getElementById('doctor').value = "";
                document.getElementsByClassName('rightContainer')[0].innerHTML = "";
                alert("Click SHOW button to see the available times for the day you have just selected");
            }
        });
    });
</script>

<script type="text/javascript">
    //document.getElementById("trDate").value = document.getElementById("dateInForm").value;

    let depSelect = document.getElementById("departments");
    let strDepartment = depSelect.options[depSelect.selectedIndex].value;
    document.getElementById("department").value = strDepartment;

    document.getElementById('trDate').value = document.getElementById('selecteddate').innerText;


    // if(document.getElementById("trDate").value == "" || document.getElementById("department").value == "" || document.getElementById("doctor").value == ""){
    //     document.getElementsByClassName('rightContainer')[0].style.display = "none";
    // }

</script>

<script src="../js/appointmentPage.js"></script>

</body>
</html>

