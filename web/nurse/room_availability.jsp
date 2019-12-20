<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 12/20/2019
  Time: 1:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Room Availability</title>
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
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">

    <link rel="stylesheet" href="../css/rooms.css">

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
        if (cookies[i].getName().equals("role_id") && cookies[i].getValue().equals("4")) {
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
                    <a href="">Room Availability</a>
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

        <div class="main-content">
            <div class="showAvailability">
                <h4 style="text-align: center">Show Availability</h4>
                <form action="showRoomAvailability" method="post" style="width: 40%; margin:0 auto;">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <label class="input-group-text" for="inputGroupSelect01">Room Number:  </label>
                        </div>
                        <select class="custom-select" name="roomName" id="inputGroupSelect01">
                            <option> </option>
                            <%
                                cookies = request.getCookies();
                                String htmlRoomNames = "";
                                for(Cookie cookie : cookies){
                                    //System.out.println(cookie.getName());
                                    if(cookie.getName().equals("htmlRoomNames")){
                                        htmlRoomNames = cookie.getValue();
                                        //System.out.println(htmlRoomNames);
                                    }
                                }
                                if(htmlRoomNames.equals(""))
                                    response.sendRedirect("/setRoomNames");
                                else{
                                    //String roomName = (String) request.getAttribute("htmlRoomNames");
                                    //out.println(roomName);
                                    String[] roomNames = htmlRoomNames.split("%2F");
                                    for(String room : roomNames){
                                        out.println("<option value=\"" + room + "\">" + room + "</option>");
                                    }
                                    //out.println(htmlRoomNames);
                                }
                            %>
                        </select>
                    </div>
                    <div class="input-group mb-3 md-form">
                        <div class="input-group-prepend">
                            <label class="input-group-text">Date:  </label>
                        </div>
                        <input type="date" name="date" id="inputMDEx" class="custom-select form-control">
                    </div>
                    <div style="overflow: auto; margin-bottom: 0.5rem">
                        <div style="float: right; margin-right: 50px;">
                            <span style="font-family: sans-serif; padding-left: 9px; text-decoration: underline">End Time</span>
                        </div>
                        <div style="float: left; margin-left: 50px;">
                            <span style="font-family: sans-serif; padding-left: 9px; text-decoration: underline">Start Time</span>
                        </div>
                    </div>
                    <div style="overflow: auto; margin-bottom: 1.5rem">
                        <div style="float: right; margin-right: 50px;">
                            <input type="text" name="time2" style="width: 51px;margin-right: 12px;">
                        </div>
                        <div style="float: left; margin-left: 50px;">
                            <input type="text" name="time" style="width: 51px;margin-left: 17px;">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-outline-secondary" style="display: block; margin: 0 auto;">Show</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%} else{
    response.sendRedirect("/user");
}%>

<!-- jQuery CDN - Slim version (=without AJAX) -->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
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
    $(function() {
        $('[name="time"]').timeselector({
            min: '00:00',
            max: '23:59',
            hours12: false
        })
    });
    $(function() {
        $('[name="time2"]').timeselector({
            min: '00:00',
            max: '23:59',
            hours12: false
        })
    });
</script>



</body>
</html>

