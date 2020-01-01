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


         /*
        <table style="width:70%; margin: 0 auto; border-collapse: separate; border-spacing: 0 1em;">
            <tr>
                <th>User Name</th>
                <th>Role</th>
                <th>E-mail</th>
            </tr>
            <tr>
                <td>01-01-2020</td>
                <td>09:00:00</td>
            </tr>
            <tr>
                <td>01-02-2020</td>
                <td>16:00:00</td>
            </tr>
        </table>
         */

         String html ="<p style=\"color: black; text-align: center;\">Current Users in DB</p>" +
                 "<div>" +
                 "<table style=\"width:70%; margin: 0 auto; border-collapse: separate; border-spacing: 0 1em;\">\n" +
                 "            <tr>\n" +
                 "                <th>User Name</th>\n" +
                 "                <th style=\"width: 30%\">Role</th>\n" +
                 "                <th style=\"width: 30%\">E-mail</th>\n" +
                 "            </tr>";

         for(int i=0; i<names.size(); i++){
             html += "<tr><td>" + names.get(i) + "</td>" +
                     "<td>" + roleNames.get(i) + "</td>" +
                     "<td>" + emails.get(i) + "</td><tr>";
         }

         html += "</table></div>";

         request.setAttribute("html", html);
         request.getRequestDispatcher("users.jsp").forward(request,response);
    }
}
