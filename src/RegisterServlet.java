import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLOutput;

public class RegisterServlet extends HttpServlet {
    String sql;
    DB_Handler handler = new DB_Handler();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");

        int ifUserExist = 0;
        try {
            handler = new DB_Handler();
            handler.init();
            PreparedStatement pstmt = handler.getConn().prepareStatement("SELECT u_id FROM cs202.Users where email = ?;");
            pstmt.setString(1,email);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                ifUserExist = rs.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        System.out.println(ifUserExist);

        if(email.equals("") || password.length() < 6 || !password.equals(password2) || name.equals("") || ifUserExist != 0){
            System.out.println(email + name);
            request.setAttribute("email", email);
            request.setAttribute("name", name);
            request.setAttribute("pw", password);
            request.setAttribute("pw2", password2);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
        else{
            String hashedPass = new Hash(password, email).hash();
            try {
                handler = new DB_Handler();
                handler.init();
                PreparedStatement pstmt = handler.getConn().prepareStatement("INSERT INTO cs202.users(name, pw, email, role_id) VALUES(?,?,?,?)" );
                pstmt.setString(1,name);
                pstmt.setString(2,hashedPass);
                pstmt.setString(3,email);
                pstmt.setInt(4,1);
                pstmt.executeUpdate();
                request.setAttribute("regStatus","success");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
