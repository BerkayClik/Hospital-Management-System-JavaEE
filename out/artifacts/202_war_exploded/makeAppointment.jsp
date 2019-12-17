<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/15/2019
  Time: 10:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Make Appointment</title>
        <script src="http://yui.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/appointment.css">
        <style>
            .yui3-button {
                margin:10px 0px 10px 0px;
                color: #fff;
                background-color: #3476b7;
            }
        </style>
    </head>
    <body class="yui3-skin-sam">
        <div class="contanier">
            <div id="demo" class="yui3-skin-sam yui3-g">
                <div class="yui3-u calender">
                    <div id="mycalendar"></div>
                </div>

            </div>
            <div class="leftContiner">

                <div class="yui3-u selectedDate" style="margin-right: 2em;">
                    <div id="links" style="padding-left:20px; font-family: sans-serif;">
                        Selected Date: &nbsp
                        <span id="selecteddate"></span>
                    </div>
                </div>
                <span style="font-family: sans-serif; padding-left: 9px;">Select Doctor: </span>
                <select class="doctors" id="doctors" onchange="setName()">
                    <option value="" selected="selected"></option>
                    <optgroup label="Cardiology">
                        <option value="Emre">Emre</option>
                        <option value="Berkay">Berkay</option>
                    </optgroup>
                    <optgroup label="Dermatology">
                        <option value="Doğukan">Doğukan</option>
                        <option value="Alp">Alp</option>
                    </optgroup>
                </select>
                <br>
                <form action="setAppointment" method="post">
                    <input type="text" name="date" id="trDate" style="display: none">
                    <input type="text" name="doctor" id="doctor" style="display: none">
                    <div style="margin-top: 2em">
                        <button type="submit" name="button" class="showButton" onclick="check()">Show</button>
                    </div>
                </form>
            </div>
            <div class="rightContainer">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            </div>
        </div>


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
                    document.getElementById("trDate").value = tr_date;
                });
            });
        </script>

        <script src="js/appointmentPage.js"></script>
    </body>
</html>
