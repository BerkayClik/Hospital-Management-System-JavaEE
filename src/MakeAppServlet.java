import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class MakeAppServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String doctor = request.getParameter("doctor");
        String doctorEncodedName = doctor.replace(" ", "-");



        int dId = 0;
        Object dateTime = new Object();
        try {
            Date uDate = new SimpleDateFormat("dd-MM-yyyy").parse(date);
            dateTime = new java.sql.Timestamp(uDate.getTime());
            //System.out.println("Selected day: " + dateTime.toString());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        DB_Handler handler = new DB_Handler();
        handler.init();
        ArrayList<Timestamp> unavailableStart = new ArrayList<>();
        ArrayList<java.sql.Timestamp> unavailableEnd = new ArrayList<>();
        ArrayList<java.sql.Timestamp> appTime = new ArrayList<>();

        try{
            Statement stmt = handler.getConn().createStatement();
            ResultSet nameToId = stmt.executeQuery("select u_id from users where name = '"+doctor+"'");
            while (nameToId.next()){
                dId = nameToId.getInt(1);
            }

            ResultSet appCheck = stmt.executeQuery("select datetime from appointments where d_id = "+dId+"");
            while(appCheck.next()){
                appTime.add(appCheck.getTimestamp(1));
            }
            ResultSet offCheck = stmt.executeQuery("select start,end from offdays where d_id = "+dId+"");
            while(offCheck.next()){
                unavailableStart.add(offCheck.getTimestamp(1));
                unavailableEnd.add(offCheck.getTimestamp(2));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        handler.close();
        ArrayList<String> unavailableTimes = new ArrayList<>();
        ArrayList<String> unavailableDays = new ArrayList<>();

        for(int i=0; i<unavailableStart.size(); i++){
            if(unavailableStart.get(i).toString().substring(0,11).equals(dateTime.toString().substring(0,11))){
                unavailableTimes.add(unavailableStart.get(i).toString().substring(11,19));
                String time = unavailableStart.get(i).toString().substring(11,19);
                for(;;){
                    time = (Integer.parseInt(time.split(":")[0])+1) +
                            ":" +
                            time.split(":")[1] +
                            ":" +
                            time.split(":")[2];
                    //System.out.println(time);
                    if(!unavailableEnd.get(i).toString().substring(11,19).equals(time))
                        unavailableTimes.add(time);
                    else
                        break;
                }

            }
        }

//        System.out.println("Offday times: ");
//        System.out.println(unavailableTimes);

        for(java.sql.Timestamp time : appTime){
            if(time.toString().substring(0,11).equals(dateTime.toString().substring(0,11)))
                unavailableTimes.add(time.toString().substring(11,19));
        }




        String html = "<p style=\"text-align: center; color: black; border-bottom: 1px solid black\">" +
                "Available times for Doctor " + doctor + " at " + date + "</p>" +
                "<div style=\"width: 80%; margin: 0 auto;\">\n" +
                "                <form action=\"setAppointment\"  method=\"post\" style=\"width: 70%; margin: 0 auto\">\n";

        String availableTime = "09:00:00";
        int k = 1;
        for(;;){
            boolean isAvailable = true;
            for(int i=0; i<unavailableTimes.size(); i++){
                if(unavailableTimes.get(i).equals(availableTime))
                    isAvailable = false;
            }
            if(!isAvailable)
                html = html + "<div class=\"custom-control custom-radio\" style=\"width: fit-content;margin: 0 auto; position: relative\">\n" +
                        "  <input type=\"radio\" name=\"customRadio\" value=\"" + availableTime + "\"class=\"custom-control-input\" disabled>\n" +
                        "  <label class=\"custom-control-label\">" + availableTime +
                        "<span style=\"font-style: italic; position: absolute; right: -100px;\">Not Available</span>" +
                        "</label>\n" +
                        "</div>";
            else{
                html = html + "<div class=\"custom-control custom-radio\" style=\"width: fit-content;margin: 0 auto\">\n" +
                        "  <input type=\"radio\" id=\"customRadio" + k + "\" name=\"customRadio\" value=\"" + availableTime + "\"class=\"custom-control-input\" onchange=\"setTime(this)\">\n" +
                        "  <label class=\"custom-control-label\" for=\"customRadio" + k +"\">" + availableTime +
                        "</label>\n" +
                        "</div>";
                k++;
            }

            availableTime = String.valueOf(Integer.parseInt(availableTime.substring(0,2))+1) + availableTime.substring(2);
            if(availableTime.equals("20:00:00"))
                break;
        }

        html += "<input type=\"text\" name=\"selectedTime\" value=\"\" id=\"resTime\" style=\"display:none\">" +
                "<br>\n" +
                "<div class=\"\" style=\"width: fit-content; margin: 0 auto; margin-top: 2em;\">\n" +
                "                      <input type=\"submit\" value=\"Submit\" class=\"showButton\">\n" +
                "                  </div>" +
                "</form></div>";


        if(!date.equals("") && !doctor.equals(""))
            request.setAttribute("html", html);
        request.setAttribute("date", date);
        request.setAttribute("doctorName", doctorEncodedName);
        request.getRequestDispatcher("makeAppointment.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
