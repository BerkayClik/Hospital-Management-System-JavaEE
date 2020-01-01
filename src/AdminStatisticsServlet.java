import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        start = start.split("-")[2] + "/" + start.split("-")[1] + "/" + start.split("-")[0];
        end = end.split("-")[2] + "/" + end.split("-")[1] + "/" + end.split("-")[0];

        System.out.println(start);
        System.out.println(end);

        //Databaseten kullanıcının seçtiği başlangıç ve bitiş değerleri bu formatta gelmeli
        String startTime = start;
        String endTime = end;
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

        System.out.println(DepartmentNamesDesc);
        System.out.println(DepartmentAppCount);


        //DB'den kullanıcının seçtiği başlangıç ve bitiş değerleri bu formatta gelmeli
        ///////////////////////////////////////////////////////////////////////////////////
        handler.init();
        ArrayList<String> DepartmentNamesDesc2 = new ArrayList<>();
        ArrayList<Integer> DepartmentAppCount2 = new ArrayList<>();
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
                DepartmentAppCount2.add(rs.getInt(2));
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }

        System.out.println(DepartmentNamesDesc2);
        System.out.println(DepartmentAppCount2);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
