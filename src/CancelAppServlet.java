import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

public class CancelAppServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DB_Handler handler = new DB_Handler();
        handler.init();

        String date = request.getParameter("date");
        String dName = request.getParameter("doctor");
        String time = request.getParameter("time");

        String patientEmail = "";
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("email"))
                patientEmail = cookie.getValue();
        }

        System.out.println(date);
        System.out.println(time);
        System.out.println(dName);

        //2020-02-01 10:00

        String appDate = date.split("-")[2] + "-" + date.split("-")[1] + "-" + date.split("-")[0];
        appDate += " " + time.split(":")[0] + ":" + time.split(":")[1];


        System.out.println("appDate: " + appDate);

        String pEmail = patientEmail;

        int pId = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select u_id from users where email = '"+pEmail+"'");
            rs.next();
            pId = rs.getInt(1);
        }
        catch (Exception e){
            e.printStackTrace();
        }

        int dId = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select u_id from users where name = '"+dName+"'");
            rs.next();
            dId = rs.getInt(1);
        }
        catch (Exception e){
            e.printStackTrace();
        }

        try {
            Statement stmt = handler.getConn().createStatement();
            stmt.executeUpdate("delete from appointments where p_id = " + pId + " and d_id = " + dId + " and datetime = '" + appDate + "'");
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("done", "true");
        request.getRequestDispatcher("upcoming_appointments.jsp").forward(request,response);
    }
}
