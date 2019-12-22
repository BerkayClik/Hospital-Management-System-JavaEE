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
        doctorName = doctorName.substring(0,doctorName.length()-1);
        DB_Handler handler = new DB_Handler();
        handler.init();

        //siteden dönen veriler
        String day = selectedDay;
        String time = selectedAppTime;
        String docName = doctorName;
        String patMail = patientEmail;
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
        ////////////////////

        //doktorun idsini alma
        int doktorID = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rss = stmt.executeQuery("select u_id from Users where name ='"+ docName +"'");
            while(rss.next()){
                doktorID=rss.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        ////////////////////

        //patient idsini alma
        int patientID = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select u_id from Users where email ='"+ patMail +"'");
            while(rs.next()){
                patientID=rs.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }


        ////////////////////

        ////////// Appointment Insert İşlemi
        try {
            PreparedStatement pstmt = handler.getConn().prepareStatement("INSERT INTO `cs202`.`Appointments` (`datetime`, `p_id`, `d_id`) VALUES (?,?,?)");
            pstmt.setString(1, datetimeDB);
            pstmt.setInt(2,patientID);
            pstmt.setInt(3,doktorID);
            pstmt.executeUpdate();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        ////////////////////
        handler.close();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
