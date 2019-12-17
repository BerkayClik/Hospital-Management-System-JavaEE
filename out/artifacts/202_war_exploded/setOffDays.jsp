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
    <title>Calender</title>
    <script src="http://yui.yahooapis.com/3.18.1/build/yui/yui-min.js"></script>

    <link rel="stylesheet" href="css/tpicker/jquery.timeselector.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ"
            crossorigin="anonymous">
    </script>
    <script src="js/tpicker/jquery.timeselector.js"></script>

    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/setOffDays.css">
    <style>
        .yui3-skin-sam .redtext {
            color:#ff0000;
        }
    </style>


</head>
<body class="yui3-skin-sam">
<div class="contanier" id="container">
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
        <div class="leftContiner">
            <form action="" method="post">

                <br><br><br>
                <div>
                    <button type="button" name="button" class="showButton" onclick="createForm()">Apply</button>
                </div>
            </form>
        </div>

        <!--
        <form action="index.html" method="post" style="display: flex; justify-content: center;">
          <input type="text" name="" value="" id="formDays">
          <input type="text" name="" value="" id="formTimes">
          <button type="button" name="button">Set</button>
        </form>
      -->
    </div>
</div>


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
            let list = document.getElementsByTagName('ul')[0];

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
<script src="js/offDays.js"></script>
</body>
</html>

