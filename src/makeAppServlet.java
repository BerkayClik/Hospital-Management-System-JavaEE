import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class makeAppServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String department = request.getParameter("department");
        String doctor = request.getParameter("doctor");
        int dId = 0;
        Object dateTime = new Object();
        try {
            Date uDate = new SimpleDateFormat("dd-MM-yyyy").parse(date);
            dateTime = new java.sql.Timestamp(uDate.getTime());
            System.out.println(dateTime.toString());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        DB_Handler handler = new DB_Handler();
        handler.init();
        ArrayList<Timestamp> unavailableStart = new ArrayList<>();
        ArrayList<java.sql.Timestamp> unavailableEnd = new ArrayList<>();
        ArrayList<java.sql.Timestamp> appTime = new ArrayList<>();
        try{
            Statement stmt = handler.getConn().createStatement();
            ResultSet nameToId = stmt.executeQuery("select u_id from users where name = '"+doctor+"'");
            while (nameToId.next()){
                dId = nameToId.getInt(1);
            }

            ResultSet appCheck = stmt.executeQuery("select datetime from appointments where d_id = "+dId+"");
            while(appCheck.next()){
                appTime.add(appCheck.getTimestamp(1));
            }
            ResultSet offCheck = stmt.executeQuery("select start,end from offdays where d_id = "+dId+"");
            while(offCheck.next()){
                unavailableStart.add(offCheck.getTimestamp(1));
                unavailableEnd.add(offCheck.getTimestamp(2));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        for(java.sql.Timestamp time : unavailableStart)
            System.out.println("OffDay Start: "+time.toString());
        for(java.sql.Timestamp time : unavailableEnd)
            System.out.println("OffDay End: "+time.toString());
        for(java.sql.Timestamp time : appTime)
            System.out.println("Appointment: "+time.toString());

        System.out.println(department);
        System.out.println(doctor);

        request.getRequestDispatcher("makeAppointment.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
