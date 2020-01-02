import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;


public class UpcomingAppointmentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String email = "";
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("email"))
                email = cookie.getValue();
        }
        int days = Integer.parseInt(request.getParameter("days"));

        //Take current date, subtract days from it
        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date currentDate = new Date(System.currentTimeMillis());

        Calendar calendar = new GregorianCalendar();
        calendar.setTime(currentDate);
        calendar.add(Calendar.DAY_OF_WEEK,days);
        Date previousDate = calendar.getTime();

        String cDate = formatter.format(currentDate);
        //System.out.println(cDate);
        String pDate = formatter.format(previousDate);
        //System.out.println(pDate);

        ArrayList<String> names = new ArrayList<>();
        ArrayList<String> dates = new ArrayList<>();
        DB_Handler handler = new DB_Handler();
        try{
            handler.init();
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("SELECT datetime,name from appointments inner join users on p_id = u_id " +
                    "where d_id = (select u_id from users " +
                    "where email = '"+email+"') " +
                    "and datetime between '"+cDate+"' and '"+pDate+"' order by datetime asc");
            while (rs.next()){
                dates.add(rs.getString(1));
                names.add(rs.getString(2));
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        //System.out.println(names);
        //System.out.println(dates);

        System.out.println("dates: " + dates);
        System.out.println("names: " + names);
        String html = "<ul class=\"list\">\n" +
                "                <span>Date</span>";


        ArrayList<String> Date = new ArrayList<>();
        ArrayList<String> time = new ArrayList<>();

        for(int i=0; i<dates.size(); i++){
            Date.add(dates.get(i).split(" ")[0].split("-")[2] +
                    "-" +
                    dates.get(i).split(" ")[0].split("-")[1] +
                    "-" +
                    dates.get(i).split(" ")[0].split("-")[0]);

            time.add(dates.get(i).split(" ")[1]);
        }

        for(int i=0; i<dates.size(); i++){
            html += "<li>" + Date.get(i) + "</li>";
        }
        html += "</ul>\n" +
                "            <ul class=\"list\">\n" +
                "                <span>Time</span>";

        for(int i=0; i<dates.size(); i++){
            html += "<li>" + time.get(i).substring(0,8) + "</li>";
        }
        html += "</ul>\n" +
                "            <ul class=\"list\">\n" +
                "                <span>Patient Name</span>\n";
        for(int i=0; i<names.size();i++){
            html += "<li>" + names.get(i) + "</li>";

        }
        html += "</ul>";



            //request.setAttribute("value", "");
        request.setAttribute("html", html);
        request.getRequestDispatcher("upcoming_appointments.jsp").forward(request,response);

        }

        protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        }
    }
