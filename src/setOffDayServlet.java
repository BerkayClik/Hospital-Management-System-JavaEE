import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

public class setOffDayServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String days = request.getParameter("days");
        String times = request.getParameter("times");

        String doctorEmail = "";
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("email"))
                doctorEmail = cookie.getValue();
        }

        String[] daysArray = days.split("/");
        String[] timesArray = times.split("/");
        ArrayList<String> enterList = new ArrayList<>();
        ArrayList<String> endList = new ArrayList<>();

        DB_Handler handler = new DB_Handler();
        for(int i=0; i<daysArray.length; i++){
            enterList.add(daysArray[i]+ " " + timesArray[i].substring(0,5));
            endList.add(daysArray[i]+ " "+ timesArray[i].substring(8,13));
        }
        //doktor idsini alma
        int doktorID = 0;
        try {
            handler.init();
            Statement stmt = handler.getConn().createStatement();
            ResultSet rss = stmt.executeQuery("select u_id from Users where email ='"+ doctorEmail +"'");
            while(rss.next()){
                doktorID=rss.getInt(1);
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        ///////////////////


        for(int i = 0;i<enterList.size();i++){
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy hh:mm");
                Date parsedDate = dateFormat.parse(enterList.get(i));
                Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());
                SimpleDateFormat dateFormat2 = new SimpleDateFormat("dd-MM-yyyy hh:mm");
                Date parsedDate2 = dateFormat.parse(endList.get(i));
                Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());

                handler.init();
                PreparedStatement pstmt = handler.getConn().prepareStatement("INSERT INTO `cs202`.`OffDays` (`start`, `end`, `d_id`) VALUES (?,?,?)");
                pstmt.setTimestamp(1, timestamp);
                pstmt.setTimestamp(2,timestamp2);
                pstmt.setInt(3,doktorID);
                pstmt.executeUpdate();
                handler.close();
            }
            catch (Exception e){
                e.printStackTrace();
            }
        }

        System.out.println(enterList);
        System.out.println(endList);

        //ArrayList<String> cars = new ArrayList<String>();

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
