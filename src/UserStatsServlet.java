import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class UserStatsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DB_Handler handler = new DB_Handler();
        ArrayList<String> names = new ArrayList<>();
        ArrayList<String> emails = new ArrayList<>();
        ArrayList<String> roleNames = new ArrayList<>();
        try{
            handler.init();
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select users.name,roles.name, email from users inner join roles on users.role_id = roles.role_id");
            while(rs.next()){
                names.add(rs.getString(1));
                roleNames.add(rs.getString(2));
                emails.add(rs.getString(3));
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        System.out.println(names);
        System.out.println(roleNames);
        System.out.println(emails);
    }
}
