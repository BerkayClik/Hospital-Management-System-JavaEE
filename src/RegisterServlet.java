import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

public class RegisterServlet extends HttpServlet {

    public static boolean isValid(String email)
    {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+
                "[a-zA-Z0-9_+&*-]+)*@" +
                "(?:[a-zA-Z0-9-]+\\.)+[a-z" +
                "A-Z]{2,7}$";

        Pattern pat = Pattern.compile(emailRegex);
        if (email == null)
            return false;
        return pat.matcher(email).matches();
    }


    DB_Handler handler = new DB_Handler();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");

        int isUserExist = 0;
        try {
            handler = new DB_Handler();
            handler.init();
            PreparedStatement pstmt = handler.getConn().prepareStatement("SELECT u_id FROM cs202.Users where email = ?;");
            pstmt.setString(1,email);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                isUserExist = rs.getInt(1);
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }

        if(email.equals("") || password.length() < 6 || !password.equals(password2) || name.equals("") || isUserExist != 0 || isValid(email) == false){

            if(isUserExist != 0)
                request.setAttribute("isExists", "true");
            if(!isValid(email))
                request.setAttribute("isInvalidEmail" , "true");
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
                handler.close();
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
