import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    String sql;
    DB_Handler handler = new DB_Handler();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");

        if(email.equals("") || password.length() < 6 || !password.equals(password2) || name.equals("")){
            System.out.println(email + name);
            request.setAttribute("email", email);
            request.setAttribute("name", name);
            request.setAttribute("pw", password);
            request.setAttribute("pw2", password2);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
        else{
            String hashedPass = new Hash(password, email).hash();
            //System.out.println(hashedPass);
            handler.init();

            sql = "INSERT INTO cs202.users(name, pw, email, role_id)" + " VALUES(" +
            "'" + name + "'," +
                    "'" +hashedPass + "'," +
                    "'" + email + "'," +
            "1);";
            System.out.println(sql);
            if(handler.handleQuery(sql))
                System.out.println("Registered");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
