import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doPost");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        System.out.println("UserServlet");
        for(int i=0; i<cookies.length; i++){
            if(cookies[i].getName().equals("role_id")){
                if(cookies[i].getValue().equals("-1")){
                    response.addCookie(cookies[i]);
                    response.sendRedirect("index.jsp");
                }
                if(cookies[i].getValue().equals("1")){
                    response.addCookie(cookies[i]);
                    response.sendRedirect("patient/home.jsp");
                }
                if(cookies[i].getValue().equals("2")){
                    response.addCookie(cookies[i]);
                    response.sendRedirect("doctor/home.jsp");
                }
                if(cookies[i].getValue().equals("3")){
                    response.addCookie(cookies[i]);
                    response.sendRedirect("admin/home.jsp");
                }
                if(cookies[i].getValue().equals("4")){
                    response.addCookie(cookies[i]);
                    response.sendRedirect("nurse/home.jsp");
                }
            }
        }
    }
}
