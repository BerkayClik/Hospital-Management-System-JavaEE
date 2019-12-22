import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UpcomingAppointmentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String userEmail = "";
        for(Cookie cookie: cookies){
            if(cookie.getName().equals("email"))
                userEmail = cookie.getValue();
        }
        String inNextDays = request.getParameter("days");


        System.out.println("User Email: " + userEmail);
        System.out.println("In next days: " + inNextDays);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
