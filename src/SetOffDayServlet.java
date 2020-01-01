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

public class SetOffDayServlet extends HttpServlet {
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

        for(int i=0; i<timesArray.length; i++){
            if(timesArray[i].split("-")[0].substring(timesArray[i].split("-")[0].length()-2).equals("pm")
                    && !timesArray[i].split("-")[0].equals("12:00pm")){
                timesArray[i] = (Integer.parseInt(timesArray[i].split("-")[0].split(":")[0])+12) +
                        ":" +
                        timesArray[i].split("-")[0].split(":")[1] +
                        "-" +
                        timesArray[i].split("-")[1];
            }
            //System.out.println(timesArray[i]);
            if(timesArray[i].split("-")[1].substring(timesArray[i].split("-")[1].length()-2).equals("pm")){
                timesArray[i] = timesArray[i].split("-")[0] +
                        "-" +
                        (Integer.parseInt(timesArray[i].split("-")[1].split(":")[0])+12) +
                        ":" +
                        timesArray[i].split("-")[0].split(":")[1];
            }
            if(timesArray[i].split("-")[1].equals("12:00am")){
                timesArray[i] = timesArray[i].split("-")[0] +
                        "-" +
                        "23:59pm";
            }
        }

        System.out.println("Times array: ");
        for(int i=0; i<timesArray.length; i++) {
            if (timesArray[i].split("-")[0].length() == 6){
                timesArray[i] = "0" + timesArray[i];
                //System.out.println("line33: " + timesArray[i]);
            }

            if (timesArray[i].split("-")[1].length() == 6){
                timesArray[i] = timesArray[i].split("-")[0] + "-" + "0" + timesArray[i].split("-")[1];
                //System.out.println("line38: " + timesArray[i]);
            }
            System.out.println(timesArray[i]);
        }

        ArrayList<String> daysList = new ArrayList<>();

        for(int i=0; i<daysArray.length; i++){
            if(daysArray[i].split("-")[0].length() == 1)
                daysArray[i] = "0" + daysArray[i].split("-")[0] + "-" + daysArray[i].split("-")[1] + "-" + daysArray[i].split("-")[2];
            if(daysArray[i].split("-")[1].length() == 1){
                daysArray[i] = daysArray[i].split("-")[0] + "-0" + daysArray[i].split("-")[1] + "-" + daysArray[i].split("-")[2];
            }
        }

        for(int i = 0; i<daysArray.length; i++){
            daysList.add(daysArray[i].split("-")[2] + "-" + daysArray[i].split("-")[1] + "-" + daysArray[i].split("-")[0]);
        }




        ArrayList<String> enterList = new ArrayList<>();
        ArrayList<String> endList = new ArrayList<>();

        DB_Handler handler = new DB_Handler();
        for(int i=0; i<daysArray.length; i++){
            enterList.add(daysList.get(i)+ " " + timesArray[i].substring(0,5));
            endList.add(daysList.get(i)+ " "+ timesArray[i].substring(8,13));
        }
        //doktor idsini alma
        int dID = 0;
        try {
            handler.init();
            Statement stmt = handler.getConn().createStatement();
            ResultSet rss = stmt.executeQuery("select u_id from Users where email ='"+ doctorEmail +"'");
            while(rss.next()){
                dID=rss.getInt(1);
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        ///////////////////
        System.out.println(enterList);
        System.out.println(endList);

        boolean success = false;

        handler.init();
        try {
            for(int i = 0; i< enterList.size(); i++) {
                Statement stmt = handler.getConn().createStatement();
                String sql = "SELECT * " +
                        "FROM cs202.appointments A , cs202.offdays O " +
                        "WHERE ? = O.d_id AND O.d_id = A.d_id AND NOT" +
                        "( ? < A.datetime OR ? > DATE_ADD(A.datetime,INTERVAL 1 HOUR)) ";
                String sql3 = "SELECT * FROM OFFDAYS O WHERE ? = d_id and NOT(? > O.end OR ? < O.start)";
                PreparedStatement ps = handler.getConn().prepareStatement(sql);
                PreparedStatement ps2 = handler.getConn().prepareStatement(sql3);
                ps.setInt(1,dID);
                ps.setString(2,endList.get(i));
                ps.setString(3,enterList.get(i));
                ps2.setInt(1,dID);
                ps2.setString(2,enterList.get(i));
                ps2.setString(3,endList.get(i));
                ResultSet rs = ps.executeQuery();
                ResultSet rs2 = ps2.executeQuery();
                if (rs.next()||rs2.next()){
                    success = false;
                }
                else{
                    success = true;
                    String sql2 = "INSERT INTO offdays(start,end,d_id) VALUES(?,?,?)";
                    PreparedStatement ps22 = handler.getConn().prepareStatement(sql2);
                    ps22.setString(1,enterList.get(i));
                    ps22.setString(2,endList.get(i));
                    ps22.setInt(3,dID);
                    ps22.executeUpdate();
                }
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        handler.close();

        if(!success){
            request.setAttribute("success", "false");
        }
        else{
            request.setAttribute("success", "true");
        }
        request.getRequestDispatcher("setOffDays.jsp").forward(request,response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
