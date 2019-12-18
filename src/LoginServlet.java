import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.sql.ResultSet;

public class LoginServlet extends HttpServlet {
    DB_Handler handler;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        password = new Hash(password,email).hash();

        //handler.init();
        int role = 0;
        try {
          // PreparedStatement pstmt = handler.getConn().prepareStatement("select role_id from user where email = ? and pw = ?");
             handler = new DB_Handler();
             handler.init();
           PreparedStatement pstmt = handler.getConn().prepareStatement("select role_id from users where email = ? and pw = ?");
           pstmt.setString(1,email);
           pstmt.setString(2,password);
           ResultSet rs = pstmt.executeQuery();
           while(rs.next()){
               role = rs.getInt(1);
           }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        if(role != 0){
            handler.close();
            response.addCookie(new Cookie("role_id",""+role));
            response.addCookie(new Cookie("email",email));
            response.sendRedirect("/user");
            System.out.println(role);
        }
        else{
            response.sendRedirect("index.jsp");
            System.out.println(role);
        }
      /*  if(email.equals("dogukan.duduoglu@ozu.edu.tr")){//todo verify user
            response.addCookie(new Cookie("JX_userstuff",email));
            response.sendRedirect("/user");

        }else{
            request.setAttribute("status","fail");
            request.setAttribute("email", email);
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }*/


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
