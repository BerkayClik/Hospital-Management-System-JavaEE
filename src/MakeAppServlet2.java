import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public class MakeAppServlet2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String times = request.getParameter("times");
        String doctor = request.getParameter("doctor");
        String doctorEncodedName = doctor.replace(" ", "-");

        String startDate = date.split("/")[0];
        String endDate = date.split("/")[1];
        String startTime = times.split("-")[0];
        String endTime = times.split("-")[1];

        startTime = changeFormat(startTime);
        endTime = changeFormat(endTime);

        System.out.println("startDate: " + startDate);
        System.out.println("endDate: " + endDate);
        System.out.println("startTime: " + startTime);
        System.out.println("endTime: " + endTime);
        System.out.println("Doctor: " + doctor);

        //Siteden gelen veriler
//        String startDate = "10-01-2020";
//        String endDate = "15-01-2020";
//        String startTime = "10:00";
//        String endTime = "14:00";
//        String doctor = "Dogukan Duduoglu";
        //

        ///////////////////////////
        ///////////////////////////
        if(startTime.length()==4){
            startTime = '0' + startTime;
        }
        if(endTime.length()==4){
            endTime = '0' + endTime;
        }

        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat format2 = new SimpleDateFormat("HH:ss");
        SimpleDateFormat format3 = new SimpleDateFormat("yyyy-MM-dd");
        int howManyDays = 0;
        int howManyHours = 0;
        //finding howManyDays and howManyHours to run in a for loop
        try {
            Date countDayStart = format.parse(startDate);
            Date countDayEnd = format.parse(endDate);
            long howManyDaysMilli = countDayEnd.getTime()-countDayStart.getTime();
            howManyDays = (int) (howManyDaysMilli/86400000);
            Date countTimeStart = format2.parse(startTime);
            Date countTimeEnd = format2.parse(endTime);
            long howManyHoursMilli = countTimeEnd.getTime()-countTimeStart.getTime();
            howManyHours = (int) (howManyHoursMilli/3600000);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        //////////////////////////
        /////////////////
        Date queryDate = null;
        try {
            queryDate = format.parse(startDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Calendar gc = new GregorianCalendar();
        gc.setTime(queryDate);

        Date queryTime = null;
        try {
            queryTime = format2.parse(startTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Calendar gct = new GregorianCalendar();
        gct.setTime(queryTime);
        Date temp = queryTime;

        ArrayList<String> unavailableTimes = new ArrayList<>();
        DB_Handler handler = new DB_Handler();
        handler.init();
        int dId = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet nameToId = stmt.executeQuery("select u_id from users where name = '"+doctor+"'");
            while (nameToId.next()){
                dId = nameToId.getInt(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }


        ArrayList<Timestamp> offdayEnd = new ArrayList<>();
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet offCheck = stmt.executeQuery("select start,end from offdays where d_id = " + dId + "");
            while (offCheck.next()) {
                offdayEnd.add(offCheck.getTimestamp(2));
            }
        }
        catch (SQLException e){

        }
        System.out.println("offdayEnd:\n" + offdayEnd);

        for(int k = 0;k<=howManyDays;k++){
            queryDate = gc.getTime();
            String queryRunDate = format3.format(queryDate);
            for (int j = 0;j<howManyHours;j++){
                queryTime = gct.getTime();
                String queryRunTime = format2.format(queryTime);
                try {
                    Statement stmt = handler.getConn().createStatement();
                    ResultSet appCheck = stmt.executeQuery("select datetime from appointments " +
                            "where d_id ="+dId+" and datetime ='"+queryRunDate+" "+queryRunTime+"'");
                    while(appCheck.next()){
                        unavailableTimes.add(appCheck.getString(1).substring(0, 16));
                    }
                    ResultSet offDayCheck = stmt.executeQuery("select start from offdays " +
                            "where '"+queryRunDate+" "+queryRunTime+"' between start and end");
                    while(offDayCheck.next()){
                        boolean isLast = false;
                        for(int i=0; i<offdayEnd.size(); i++){
                            if(offdayEnd.get(i).toString().substring(0,10).equals(queryRunDate)
                                    && offdayEnd.get(i).toString().substring(11,16).equals(queryRunTime))
                                isLast = true;
                        }
                        if(!isLast)
                            unavailableTimes.add(queryRunDate + " " + queryRunTime);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                gct.add(Calendar.HOUR,1);
            }
            gct.setTime(temp);
            gc.add(Calendar.DAY_OF_WEEK,1);
        }
        handler.close();

        System.out.println(unavailableTimes);

        String html = "  <p style=\"text-align: center; color: black; border-bottom: 1px solid black\">Available times for Doctor" + doctor + " between " + startTime + " and " + endTime + "at</p>\n" +
                "                <div style=\"width: 80%; margin: 0 auto;\">\n" +
                "                    <form action=\"setAppointment\" method=\"post\" style=\"\">\n" +
                "                      <div class=\"allRes\">";

        Date date1 = null;
        try {
            date1 = format.parse(startDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Calendar c1 = new GregorianCalendar();
        c1.setTime(date1);

        Date time = null;
        try {
            time = format2.parse(startTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Calendar c2 = new GregorianCalendar();
        c2.setTime(time);
        Date temp1 = time;

        int i = 0;
        int n = 0;
        for(int k = 0;k<=howManyDays;k++){
            date1 = c1.getTime();
            date = format3.format(date1);
            //date = date.split("-")[2] + "-" + date.split("-")[1] + "-" + date.split("-")[0];
            System.out.println(date);

            html += "<div class=\"dateRes\">\n" +
                    "                          <span style=\"text-decoration: underline;\">" + date.split("-")[2] + "-" + date.split("-")[1] + "-" + date.split("-")[0] + "</span>";
            for (int j = 0;j<howManyHours;j++){
                time = c2.getTime();
                times = format2.format(time);
                c2.add(Calendar.HOUR,1);
                System.out.println(times);

                if((date + " " + times).equals(unavailableTimes.get(n))) {
                    html += "<div class=\"res\">\n" +
                            "                            <div class=\"custom-control custom-radio\" style=\"width: fit-content; position: relative\">\n" +
                            "                                 <input type=\"radio\" name=\"customRadio\" value=\""+ times+":00" + "\" class=\"custom-control-input\" disabled=\"\">\n" +
                            "                                 <label class=\"custom-control-label\">" + times+":00" + "\n" +
                            "                                     <span style=\"font-style: italic; position: absolute; right: -100px;\">Not Available</span>\n" +
                            "                                 </label>\n" +
                            "                             </div>\n" +
                            "                          </div>";
                    n++;
                    if(n == unavailableTimes.size())
                        n=0;
                }
                else{
                    html += "<div class=\"res\">\n" +
                            "                            <div class=\"custom-control custom-radio\" style=\"width: fit-content\">\n" +
                            "                                 <input type=\"radio\" id=\"customRadio" + i + "\" name=\"customRadio\" value=\"" + times+":00" + "\" class=\"custom-control-input\" onchange=\"setTime2(this)\">\n" +
                            "                                 <label class=\"custom-control-label\"  for=\"customRadio" + i + "\">" + times+":00" + "</label>\n" +
                            "                             </div>\n" +
                            "                          </div>";
                    i++;
                }
            }

            html += "</div>";
            c2.setTime(temp);
            c1.add(Calendar.DAY_OF_WEEK,1);
        }

        html += "</div>" +
                "<input type=\"text\" name=\"selectedTime\" value=\"\" id=\"resTime\" style=\"\">\n" +
                "                       <br>\n" +
                "                       <div class=\"\" style=\"margin: 0 auto; margin-top: 2em;\">\n" +
                "                          <input type=\"submit\" value=\"Submit\" class=\"showButton\">\n" +
                "                       </div>" +
                "</form>\n" +
                "                </div>";

        if(!date.equals("") && !doctor.equals(""))
            request.setAttribute("html", html);
        request.setAttribute("date", date);
        request.setAttribute("doctorName", doctorEncodedName);
        request.getRequestDispatcher("makeAppointment2.jsp").forward(request,response);
    }

    public String changeFormat(String time){
        if(time.split(":")[1].substring(2).equals("pm") && !time.equals("12:00pm")){
            time = ((Integer.parseInt(time.split(":")[0]))+12) + ":" + time.split(":")[1];
        }
        return time.substring(0,time.length()-2);
    }
}
