
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Set Off-Days</title>
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
    <link rel="stylesheet" href="../css/setOffDays.css">
    <link rel="stylesheet" href="../css/home.css">

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
    <style>
        .dropdown-toggle::after {
            content: "";
        }
    </style>
    <style>
        .yui3-skin-sam .redtext {
            color:#ff0000;
        }
    </style>

</head>
<body class="yui3-skin-sam">
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

    <%
        if(request.getAttribute("success") != null){
            if(request.getAttribute("success").equals("false")){
    %>
    <script type="text/javascript">
        alert("There is already an off-day/appointment in the date/times you have selected")
    </script>
    <%}}%>

    <%
        if(request.getAttribute("success") != null){
            if(request.getAttribute("success").equals("true")){
    %>
    <script type="text/javascript">
        alert("Offdays are set")
    </script>
    <%}}%>

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
                <li class="active">
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Off-Day</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">
                        <li>
                            <a href="setOffDays.jsp">Set Off-Day</a>
                        </li>
                        <li>
                            <a href="showOffDays.jsp">Show Off-Days</a>
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

        <div class="container" id="container" style="margin: 0 auto;">
            <div id="demo" class="yui3-skin-sam"> <!-- You need this skin class -->

                <div id="mycalendar"></div>
            </div>


            <div class="doneButtonDiv">
                Hold CTRL or SHIFT to select multiple days
                <!--
                <button type="button" name="button" class="doneButton" onclick="done()">Done</button>
                -->
            </div>

            <div class="whenDoneDiv" style="">
                <div class="selectedBoth">
                    <div class="yui3-u selectedDate" style="padding-left: 7em; width: 360px;">
                        <div id="links" style="padding-left:20px; font-family: sans-serif;">
                            <span style="text-decoration: underline; padding-left: 5px">Selected Day(s):</span>
                            <ul id="selectedDays" style="padding-left: 20px; height: 37.4px">

                            </ul>
                        </div>
                    </div>
                    <div style="width: 360px;">
                        <span style="font-family: sans-serif; padding-left: 15px; text-decoration: underline">Select Time for: </span>
                        <ul id="times" style="padding-left: 10px">

                        </ul>
                    </div>
                </div>
                <div class="leftContainer">
                    <form action="" method="post">

                        <br><br><br>
                        <div>
                            <button type="button" name="button" class="showButton" onclick="createForm()">Apply</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%} else{
    response.sendRedirect("/user");
}%>

<!-- Popper.JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<script src="http://jonthornton.github.io/Datepair.js/dist/datepair.js"></script>
<script src="http://jonthornton.github.io/Datepair.js/dist/jquery.datepair.js"></script>
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
    YUI().use('calendar', 'datatype-date', 'datatype-date-math', function(Y) {

        Y.CalendarBase.CONTENT_TEMPLATE = Y.CalendarBase.TWO_PANE_TEMPLATE;

        var calendar = new Y.Calendar({
            contentBox: "#mycalendar",
            width: "700px",
            showPrevMonth: true,
            showNextMonth: true,
            selectionMode: 'multiple',
            disabledDatesRule: "tuesdays_and_fridays",
            date: new Date(2020, 0, 1)
        }).render();

        calendar.set("headerRenderer", function (curDate) {
            var ydate = Y.DataType.Date,
                output = ydate.format(curDate, {
                    format: "%B %Y"
                }) + " &mdash; " + ydate.format(ydate.addMonths(curDate, 1), {
                    format: "%B %Y"
                });
            return output;
        });
        calendar.on("selectionChange", function (ev) {
            //console.log(ev.newSelection.length);
            let day;
            let month;
            let year;
            let dateArray = [];
            for(let i=0; i<ev.newSelection.length; i++){
                day = ev.newSelection[i].getDate();
                month = ev.newSelection[i].getMonth()+1;
                year = ev.newSelection[i].getFullYear();
                let date = "" + day + "-" + month + "-" + year;
                dateArray[i] = date;
            }
            let list = document.getElementById('selectedDays');

            let timesList = document.getElementById('times');

            while( list.firstChild ){
                list.removeChild(list.firstChild);
            }
            while(timesList.firstChild){
                timesList.removeChild(timesList.firstChild);
            }
            for(let i=0; i<dateArray.length; i++){
                let li = document.createElement("LI");
                var text = document.createTextNode(dateArray[i]);
                li.appendChild(text);
                list.appendChild(li);

                let li2 = document.createElement("LI");
                li2.innerHTML = "<p id=\"datepairExample\"><input type=\"text\" name=\"time\" class=\"time start\" style=\"margin: 0 5px\"/>" +
                    "to" +
                    "<input type=\"text\" name=\"time\" class=\"time end\" onchange='isEqualLoop()' style=\"margin: 0 5px\"/>" +
                    "<button type=\"button\" name=\"button\" onclick=\"fullDay(this)\" style=\"margin-right: 5px\">Full Day</button>" +
                    "<button type=\"button\" name=\"button\" onclick=\"reset(this)\" style=\"margin-right: 5px\">Reset</button></p>";
                timesList.appendChild(li2);
                $('#datepairExample .time').timepicker({
                    'step': 60,
                    'showDuration': true,
                    'timeFormat': 'g:ia',
                    'minTime': '9:00am',
                    'maxTime': '00:01am'
                });

                $('li > p').datepair();
            }
        });

    });

</script>
<script src="../js/offDays.js"></script>
<script src="../js/isEqual.js"></script>
</body>
</html>
