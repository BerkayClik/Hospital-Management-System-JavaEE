import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

public class ShowOffDaysServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String doctorEmail = "";
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("email"))
                doctorEmail = cookie.getValue();
        }
        //doktorun emaili geldi

        DB_Handler handler = new DB_Handler();
        handler.init();

        //Doctor ID Bulma
        int doctorID = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select u_id from cs202.Users where email ='"+ doctorEmail +"'");
            while(rs.next()){
                doctorID = rs.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        //System.out.println(doctorID);
        ////////////////
        ArrayList<Timestamp> offDaysStart = new ArrayList<>();
        ArrayList<Timestamp> offDaysEnd = new ArrayList<>();
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select start,end from cs202.OffDays where d_id =" + doctorID);
            while(rs.next()){
                offDaysStart.add(rs.getTimestamp(1));
                offDaysEnd.add(rs.getTimestamp(2));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        System.out.println("offDaysStart:\n" + offDaysStart);
        System.out.println("offDaysEnd:\n" + offDaysEnd);

        /*
        <table style="width:70%; margin: 0 auto; border-collapse: separate; border-spacing: 0 1em;">
            <tr>
                <th>Date</th>
                <th>Start</th>
                <th>End</th>
            </tr>
            <tr>
                <td>01-01-2020</td>
                <td>09:00:00</td>
                <td>12:00:00</td>
            </tr>
            <tr>
                <td>01-02-2020</td>
                <td>14:00:00</td>
                <td>16:00:00</td>
            </tr>
        </table>
         */

        String html = "<table style=\"width:70%; margin: 0 auto; border-collapse: separate; border-spacing: 0 1em;\">\n" +
                "            <tr>\n" +
                "                <th>Starts</th>\n" +
                "                <th>Ends</th>\n" +
                "            </tr>\n";

        for(int i=0; i<offDaysStart.size(); i++){
            html += "<tr><td>" + offDaysStart.get(i).toString().substring(0,16) + "</td>" ;
            html += "<td>" + offDaysEnd.get(i).toString().substring(0,16) + "</td></tr>" ;
        }
        html += "</table>";

        request.setAttribute("html", html);
        request.getRequestDispatcher("showOffDays.jsp").forward(request,response);
    }
}
