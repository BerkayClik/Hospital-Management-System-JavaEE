<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/17/2019
  Time: 7:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>Set Off-Days</title>
        <script src="http://yui.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>

        <link rel="stylesheet" href="../css/tpicker/jquery.timeselector.css">
        <script src="https://code.jquery.com/jquery-1.12.4.min.js"
                integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ"
                crossorigin="anonymous">
        </script>
        <script src="../js/tpicker/jquery.timeselector.js"></script>

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
                            <a href="doctorHome.jsp">Home</a>

                        </li>
                        <li>
                            <a href="">Rooms</a>
                        </li>
                        <li>
                            <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Off-Day</a>
                            <ul class="collapse list-unstyled" id="pageSubmenu">
                                <li class="active">
                                    <a href="">Set Off-Day</a>
                                </li>
                                <li>
                                    <a href="#">Show Off-Days</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="">View Appointment</a>
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
                            <div class="yui3-u selectedDate" style="padding-left: 2em; width: 300px;">
                                <div id="links" style="padding-left:20px; font-family: sans-serif;">
                                    <span style="text-decoration: underline">Selected Day(s):</span>
                                    <ul id="selectedDays" style="padding-left: 20px">

                                    </ul>

                                </div>
                            </div>
                            <div style="width: 300px;">
                                <span style="font-family: sans-serif; padding-left: 9px; text-decoration: underline">Select Time for: </span>
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


<%--        <!-- jQuery CDN - Slim version (=without AJAX) -->--%>
<%--        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>--%>
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
                    let add;
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
                        li2.innerHTML = "<input type=\"text\" name=\"time\" maxlength=\"5\" onfocusout=\"setNext(this)\">" +
                            "to" +
                            "<input type=\"text\" name=\"time\" maxlength=\"5\" onfocusout=\"checkBefore(this)\">" +
                            "<button type=\"button\" name=\"button\" onclick=\"fullDay(this)\">Full Day</button>" +
                            "<button type=\"button\" name=\"button\" onclick=\"reset(this)\">Reset</button>";
                        timesList.appendChild(li2);
                        $(function() {
                            $('[name="time"]').timeselector({
                                min: '09:00',
                                max: '23:59',
                                hours12: false
                            })
                        });
                    }
                });

            });

        </script>
        <script src="../js/offDays.js"></script>
    </body>
</html>


