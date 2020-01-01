import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class PreviousAppointmentsServlet2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String userEmail = "";
        for(Cookie cookie: cookies){
            if(cookie.getName().equals("email"))
                userEmail = cookie.getValue();
        }
        String prevDays = request.getParameter("days");
        DB_Handler handler = new DB_Handler();
        handler.init();
        int userID = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select u_id from cs202.Users where email ='"+ userEmail +"'");
            while(rs.next()){
                userID = rs.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }


        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatter2= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
        String currentDate = formatter.format(date);
        //MEVCUT GUNDEN ONCESINI BULMA

        int year = Integer.parseInt(currentDate.split("-")[0]);
        int month = Integer.parseInt(currentDate.split("-")[1]);
        int day = Integer.parseInt(currentDate.split("-")[2]);

        ArrayList<String> stringtimeDB = new ArrayList<>();
        stringtimeDB.add(currentDate.replace("/","-"));
        for(int i=0; i<Integer.parseInt(prevDays); i++){
            boolean isNewYear = false;
            if(month == 1 && day == 1){
                year--;
                day = 31;
                month = 12;
                isNewYear = true;
            }
            else if(day == 1){
                if(month == 5 || month == 7 || month == 10 || month == 12){
                    day = 30;
                    month--;
                }
                else if(month == 2 || month == 4 || month == 6 || month == 9 || month == 11){
                    day = 31;
                    month--;
                }
                else if(month == 8){
                    day = 31;
                    month--;
                }
                else if(month == 3){
                    day = 28;
                    month = 2;
                }
            }
            else{
                if(!isNewYear)
                    day--;
            }

            if(month < 10 && day < 10)
                stringtimeDB.add(year + "-0" + month + "-0" + day);
            else{
                if(month < 10)
                    stringtimeDB.add(year + "-0" + month + "-" + day);
                else if(day < 10){
                    stringtimeDB.add(year + "-" + month + "-0" + day);
                }
                else
                    stringtimeDB.add(year + "-" + month + "-" + day);
            }
        }
        //database doktorun randevusu olan günleri çekme
        ArrayList<Timestamp> datetimeDB2 = new ArrayList<>();
        ArrayList<String> handledDateTimeDB = new ArrayList<>();
        ArrayList<Integer> doctorID = new ArrayList<>();
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select datetime,d_id from cs202.Appointments where p_id ='"+ userID + "'");
            while(rs.next()){
                datetimeDB2.add(rs.getTimestamp(1));
                doctorID.add(rs.getInt(2));
                handledDateTimeDB.add(formatter.format(rs.getTimestamp(1)));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        //Getting Doctor Names From Patient ID
        ArrayList<String> doctorNames = new ArrayList<>();
        for(int i = 0;i<doctorID.size();i++){
            try {
                Statement stmt = handler.getConn().createStatement();
                ResultSet rs = stmt.executeQuery("select name from cs202.Users where u_id =" + doctorID.get(i)+"");
                while (rs.next()) {
                    doctorNames.add(rs.getString(1));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
//        System.out.println(doctorID);
//        System.out.println(doctorNames);
//        System.out.println(handledDateTimeDB);
//        System.out.println(handledDateTimeDB.size());
//        System.out.println(stringtimeDB.size());
        //Handling date and times
        ArrayList<String> reservedDoctors = new ArrayList<>();
        ArrayList<String> reservedDays = new ArrayList<>();
        for(int i=0;i<handledDateTimeDB.size();i++ ){
            for(int j = 0; j<stringtimeDB.size(); j++){
//                System.out.println("stDB:"+stringtimeDB.get(j));
//                System.out.println("htDB:"+handledDateTimeDB.get(i));
                if(stringtimeDB.get(j).equals(handledDateTimeDB.get(i))) {
                    reservedDays.add(formatter2.format(datetimeDB2.get(i)));
                    reservedDoctors.add(doctorNames.get(i));
                }
            }
        }
        handler.close();
        ///////

        String html = "<ul class=\"list\">\n" +
                "                <span>Date</span>";

        ArrayList<String> Date = new ArrayList<>();
        ArrayList<String> time = new ArrayList<>();

        for(int i=0; i<reservedDays.size(); i++){
            Date.add(reservedDays.get(i).split(" ")[0].split("-")[2] +
                    "-" +
                    reservedDays.get(i).split(" ")[0].split("-")[1] +
                    "-" +
                    reservedDays.get(i).split(" ")[0].split("-")[0]);

            time.add(reservedDays.get(i).split(" ")[1]);
        }

        for(int i=0; i<reservedDays.size(); i++){
            html += "<li>" + Date.get(i) + "</li>";
        }
        html += "</ul>\n" +
                "            <ul class=\"list\">\n" +
                "                <span>Time</span>";

        for(int i=0; i<reservedDays.size(); i++){
            html += "<li>" + time.get(i) + "</li>";
        }

        html += "</ul>\n" +
                "            <ul class=\"list\">\n" +
                "                <span>Doctor Name</span>\n";
        for(int i=0; i<reservedDoctors.size();i++){
            html += "<li>" + reservedDoctors.get(i) + "</li>";

        }
        html += "</ul>";


        //request.setAttribute("value", "");
        request.setAttribute("html", html);
        request.getRequestDispatcher("previous_appointments.jsp").forward(request,response);

    }
}
