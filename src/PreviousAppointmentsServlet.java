import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class PreviousAppointmentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String userEmail = "";
        for(Cookie cookie: cookies){
            if(cookie.getName().equals("email"))
                userEmail = cookie.getValue();
        }
        String prevDays = request.getParameter("days");
        DB_Handler handler = new DB_Handler();
        handler.init();
        int userID = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select u_id from cs202.Users where email ='"+ userEmail +"'");
            while(rs.next()){

                userID = rs.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }


        System.out.println("User Email: " + userEmail);
        System.out.println("Past "  + prevDays + " days ");

        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatter2= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
        String currentDate = formatter.format(date);
        //MEVCUT GUNDEN ONCESINI BULMA

        int year = Integer.parseInt(currentDate.split("-")[0]);
        int month = Integer.parseInt(currentDate.split("-")[1]);
        int day = Integer.parseInt(currentDate.split("-")[2]);

        ArrayList<String> stringtimeDB = new ArrayList<>();
        stringtimeDB.add(currentDate.replace("-","/"));
        for(int i=0; i<Integer.parseInt(prevDays); i++){
            boolean isNewYear = false;
            if(month == 1 && day == 1){
                year++;
                day = 31;
                month = 12;
                isNewYear = true;
            }
            else if(day == 1){
                if(month == 5 || month == 7 || month == 10 || month == 12){
                    day = 30;
                    month--;
                }
                else if(month == 2 || month == 4 || month == 6 || month == 9 || month == 11){
                    day = 31;
                    month--;
                }
                else if(month == 8){
                    day = 31;
                    month--;
                }
                else if(month == 3){
                    day = 28;
                    month = 2;
                }
            }
            else{
                if(!isNewYear)
                    day--;
            }

            if(month < 10 && day < 10)
                stringtimeDB.add(year + "-0" + month + "-0" + day);
            else{
                if(month < 10)
                    stringtimeDB.add(year + "-0" + month + "-" + day);
                else if(day < 10){
                    stringtimeDB.add(year + "-" + month + "-0" + day);
                }
                else
                    stringtimeDB.add(year + "-" + month + "-" + day);
            }
        }

        System.out.println("Current Date -" + prevDays + " days:");
        System.out.println(stringtimeDB);

        ArrayList<Timestamp> datetimeDB2 = new ArrayList<>();
        ArrayList<String> handledDateTimeDB = new ArrayList<>();
        int role = 0;
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select role_id from users where u_id = "+userID);
            rs.next();
            role = rs.getInt(1);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        System.out.println("This is the role id: "+role);
        if (role == 2){
        try {
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select datetime from cs202.Appointments where d_id ='"+ userID + "'");
            while(rs.next()){
                datetimeDB2.add(rs.getTimestamp(1));
                handledDateTimeDB.add(formatter.format(rs.getTimestamp(1)));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        if (role == 1){
            try {
                Statement stmt = handler.getConn().createStatement();
                ResultSet rs = stmt.executeQuery("select datetime from cs202.Appointments where p_id ='"+ userID + "'");
                while(rs.next()){
                    datetimeDB2.add(rs.getTimestamp(1));
                    handledDateTimeDB.add(formatter.format(rs.getTimestamp(1)));
                }
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }

        }
        System.out.println("\nAll appointments of Doctor ID " + userID + ":");
        System.out.println(datetimeDB2);
        System.out.println("handleDateTimeDB: ");
        System.out.println(handledDateTimeDB);

        ArrayList<String> reservedDays = new ArrayList<>();
        for(int i=0;i<handledDateTimeDB.size();i++ ){
            for(int j = 0; j<stringtimeDB.size(); j++){
                System.out.println("This is stringtimedb: "+stringtimeDB.get(j));
                System.out.println("This is handleddatetimedb: "+handledDateTimeDB.get(i));
                if(stringtimeDB.get(j).equals(handledDateTimeDB.get(i))) {
                    reservedDays.add(formatter2.format(datetimeDB2.get(i)));
                }
            }

        }
        ///////
        System.out.println(reservedDays);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
