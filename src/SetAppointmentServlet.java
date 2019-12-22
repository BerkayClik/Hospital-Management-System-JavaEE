import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class SetAppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String info = request.getParameter("selectedTime");

        String selectedAppTime = info.substring(0,8);
        String selectedDay = info.substring(9,19);

        String[] Name = info.substring(20).split("-");
        String doctorName = "";
        for(String name : Name)
            doctorName = doctorName + name + " ";

        String patientEmail = "";
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("email"))
                patientEmail = cookie.getValue();
        }

        System.out.println("Selected Appointment Time: " + selectedAppTime);
        System.out.println("Selected Date: " + selectedDay);
        System.out.println("Selected Doctor Name: " + doctorName);
        System.out.println("Patient E-mail: " + patientEmail);

        DB_Handler handler = new DB_Handler();
        handler.init();

        //siteden dönen veriler
        String day = selectedDay;
        String time = selectedAppTime;
        String docName = doctorName;
        int patientID = 21;
        ///////////////////

        ////////day ve time ile database gönderilicek datetime oluşturma işlemi
        Date datetime= null;
        try {
            datetime = new SimpleDateFormat("dd-MM-yyyy HH:mm", Locale.UK).parse(day+" "+time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String datetimeDB = formatter.format(datetime);
        System.out.println("\nDB Time: " + datetimeDB);
        ////////////////////

        //doktorun idsini alma
        int doktorID = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select u_id from Users where name ='"+ docName +"'");
            while(rs.next()){
                doktorID=rs.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        System.out.println("doctorID: " + doktorID);
        ////////////////////

        ////////// Appointment Insert İşlemi
        try {
            handler = new DB_Handler();
            handler.init();
            PreparedStatement pstmt = handler.getConn().prepareStatement("INSERT INTO `cs202`.`Appointments` (`datetime`, `p_id`, `d_id`) VALUES (?,?,?)");
            pstmt.setString(1, datetimeDB);
            pstmt.setInt(2,patientID);
            pstmt.setInt(3,doktorID);
            pstmt.executeUpdate();
            System.out.println("Done");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        ////////////////////




    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
