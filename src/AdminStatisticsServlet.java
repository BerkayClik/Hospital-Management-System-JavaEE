import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class AdminStatisticsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dates = request.getParameter("date");
        String start = dates.split("/")[0];
        String end = dates.split("/")[1];

        String start2 = start.split("-")[2] + "/" + start.split("-")[1] + "/" + start.split("-")[0];
        String end2 = end.split("-")[2] + "/" + end.split("-")[1] + "/" + end.split("-")[0];

        System.out.println(start);
        System.out.println(end);

        //Databaseten kullanıcının seçtiği başlangıç ve bitiş değerleri bu formatta gelmeli
        String startTime = start2;
        String endTime = end2;
        ///////////////////////////////////////////////////////////////////////////////////
        DB_Handler handler = new DB_Handler();
        handler.init();
        ArrayList<String> DepartmentNamesDesc = new ArrayList<>();
        ArrayList<Integer> DepartmentAppCount = new ArrayList<>();
        try {
            String sql = "SELECT d.name AS department, COUNT(r.d_id) AS appointment_count\n" +
                    "FROM departments AS d\n" +
                    "JOIN userdeprel AS ud ON d.dept_id = ud.dept_id\n" +
                    "JOIN users AS u ON u.u_id = ud.u_id\n" +
                    "LEFT JOIN appointments AS r ON r.d_id = u.u_id AND r.datetime > '"+ startTime +"' AND r.datetime < '"+ endTime + "'\n" +
                    "WHERE u.role_id = 2 \n" +
                    "GROUP BY d.dept_id\n" +
                    "ORDER BY appointment_count DESC";
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                DepartmentNamesDesc.add(rs.getString(1));
                DepartmentAppCount.add(rs.getInt(2));
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }

        //System.out.println(DepartmentNamesDesc);
        //System.out.println(DepartmentAppCount);

        String html = "<p style=\"color: black; text-align: center;\">Results between " + start + " and " + end + "</p>" +
                "<div style=\"overflow: auto; margin-bottom: 100px;\">" +
                "<table style=\"width:40%; margin-left: 100px; border-collapse: separate; border-spacing: 0 1em; float: left;\">\n" +
                "            <tr>\n" +
                "                <th>Department Name</th>\n" +
                "                <th># of Appointments</th>\n" +
                "            </tr>\n" +
                "";

        for(int i=0; i<DepartmentNamesDesc.size(); i++){
            html += "<tr><td>" + DepartmentNamesDesc.get(i) +"</td>" +
                    "<td>" + DepartmentAppCount.get(i) + "</td></tr>";
        }


        /*
        <table style="width:70%; margin: 0 auto; border-collapse: separate; border-spacing: 0 1em;">
            <tr>
                <th>Department Name</th>
                <th>Start</th>
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



        //DB'den kullanıcının seçtiği başlangıç ve bitiş değerleri bu formatta gelmeli
        ///////////////////////////////////////////////////////////////////////////////////
        handler.init();
        ArrayList<String> DepartmentNamesDesc2 = new ArrayList<>();
        ArrayList<Integer> DepartmentRoomCount = new ArrayList<>();
        try {
            String sql = "SELECT d.name AS department, COUNT(r.d_id) AS room_count\n" +
                    "FROM departments AS d\n" +
                    "JOIN userdeprel AS ud ON d.dept_id = ud.dept_id\n" +
                    "JOIN users AS u ON u.u_id = ud.u_id\n" +
                    "LEFT JOIN roomreservations AS r ON r.d_id = u.u_id AND r.enter > '"+ startTime +"' AND r.exit_ < '"+ endTime + "'\n" +
                    "WHERE u.role_id = 2 \n" +
                    "GROUP BY d.dept_id\n" +
                    "ORDER BY room_count DESC";
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                DepartmentNamesDesc2.add(rs.getString(1));
                DepartmentRoomCount.add(rs.getInt(2));
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }

        //System.out.println(DepartmentNamesDesc2);
        //System.out.println(DepartmentRoomCount);

        html += "" +
                "</table>" +
                "<table style=\"width:40%; margin-left: 100px; border-collapse: separate; border-spacing: 0 1em; float: right;\">\n" +
                "            <tr>\n" +
                "                <th>Department Name</th>\n" +
                "                <th># of Rooms Reserved</th>\n"+
                "            </tr>\n" +
                "";

        for(int i=0; i<DepartmentNamesDesc2.size(); i++){
            html += "<tr><td>" + DepartmentNamesDesc2.get(i) +"</td>" +
                    "<td>" + DepartmentRoomCount.get(i) + "</td></tr>";
        }

        html += "" +
                "</table>" +
                "</div>";


        request.setAttribute("html", html);
        request.getRequestDispatcher("statistics.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
