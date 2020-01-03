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
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class UpcomingAppointmentsServlet2 extends HttpServlet {
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
//        System.out.println(cDate);
        String pDate = formatter.format(previousDate);
//        System.out.println(pDate);

        ArrayList<String> names = new ArrayList<>();
        ArrayList<String> dates = new ArrayList<>();
        DB_Handler handler = new DB_Handler();
        try{
            handler.init();
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("SELECT datetime,name from appointments inner join users on d_id = u_id " +
                    "where p_id = (select u_id from users " +
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
//        System.out.println(names);
//        System.out.println(dates);
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

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        boolean isOk = false;



        for(int i=0; i<dates.size(); i++){
            html += "<li>" + Date.get(i) + "</li>";
        }


        html += "</ul>\n" +
                "            <ul class=\"list\">\n" +
                "                <span>Doctor Name</span>\n";
        for(int i=0; i<names.size();i++){
            html += "<li>" + names.get(i) + "</li>";
        }

        html += "</ul>\n" +
                "            <ul class=\"list\">\n" +
                "                <span>Time</span>";

        for(int i=0; i<dates.size(); i++){
            String newDate = Date.get(i).split("-")[2] + "-" + Date.get(i).split("-")[1] + "-" + Date.get(i).split("-")[0];
            System.out.println("line97 " + newDate + " " + time.get(i).substring(0,8));
            try {
                Date current = sdf.parse(sdf.format(cal.getTime()));
                Date appTime = sdf.parse(newDate + " " + time.get(i).substring(0,8));
                Calendar gc = new GregorianCalendar();
                gc.setTime(appTime);
                gc.add(Calendar.HOUR, -24);
                Date appTimeMinus24 = gc.getTime();
                System.out.println("This is app time - 24: "+sdf.format(appTimeMinus24));
                System.out.println("This is current: "+sdf.format(current));
                if (current.getTime()<appTimeMinus24.getTime())
                    isOk = true;
            }
            catch (ParseException e) {
                e.printStackTrace();
            }
            System.out.println("isOk:" + isOk);

            if(isOk)
                html += "<li>" + time.get(i).substring(0,8) + "<a style=\"cursor: pointer; width: 20px;margin-left: 30px;\" onclick=\"cancel(this)\"><img src=\"../css/img/cancel.png\" style=\"width: 20px;\"></a></li>";
            else
                html += "<li>" + time.get(i).substring(0,8) + "<span style=\"color: grey;font-style: italic;margin-left: 7px;\">Not Cancellable</span></li>";
        }

        html += "</ul>" +
                "" +
                "<form action=\"cancelApp\" method=\"post\" style=\"display:none\">\n" +
                "                    <input type=\"text\" name=\"date\" id=\"trDate\" style=\"\">\n" +
                "                    <input type=\"text\" name=\"time\" id=\"time\" style=\"\">\n" +
                "                    <input type=\"text\" name=\"doctor\" id=\"doctor\" style=\"\">\n" +
                "                    <div style=\"\">\n" +
                "                        <button type=\"submit\" name=\"button\" class=\"showButton\" style=\"margin-top: 2em\">Show</button>\n" +
                "                    </div>\n" +
                "                </form>";

        //request.setAttribute("value", "");
        request.setAttribute("html", html);
        request.getRequestDispatcher("upcoming_appointments.jsp").forward(request,response);

    }

    protected void doGet (HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

    }
}
