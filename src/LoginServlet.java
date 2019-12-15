import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    DB_Handler handler;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //handler.init();

        if(email.equals("dogukan.duduoglu@ozu.edu.tr")){//todo verify user
            response.addCookie(new Cookie("JX_userstuff",email));
            response.sendRedirect("/user");

        }else{
            request.setAttribute("status","fail");
            request.setAttribute("email", email);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
