import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class ReserveRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomName = request.getParameter("roomName");
        String date = request.getParameter("date");
        String patientEmail = request.getParameter("patientEmail");
        String startTime = request.getParameter("start");
        String endTime = request.getParameter("end");

        String doctorEmail = "";
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("email"))
                doctorEmail = cookie.getValue();
        }

        System.out.println("Room name: " + roomName);
        System.out.println("Date: " + date);
        System.out.println("Doctor Email: " + doctorEmail);
        System.out.println("Patient Email: " + patientEmail);
        System.out.println("Starts: " + startTime);
        System.out.println("Ends: " + endTime);
        DB_Handler handler = new DB_Handler();
        int isUserExist = 0;
        try {
            handler.init();
            PreparedStatement pstmt = handler.getConn().prepareStatement("SELECT u_id,name FROM cs202.users WHERE email=? AND role_id=1");
            pstmt.setString(1,patientEmail);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                isUserExist = rs.getInt(1);
            }
            handler.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }

        if(isUserExist == 0){
            request.setAttribute("error", "true");

            request.setAttribute("isAvailable", "true");

            request.setAttribute("roomName", roomName);
            request.setAttribute("date", date);
            request.setAttribute("start", startTime);
            request.setAttribute("end", endTime);
            request.getRequestDispatcher("reserve_room.jsp").forward(request,response);
        }
        else{
            String enterDate = date + " " + startTime + ":00";
            String exitDate = date + " " + endTime + ":00";
            System.out.println(exitDate);
            try {
                handler.init();
                Statement stmt = handler.getConn().createStatement();
                stmt.executeUpdate("INSERT INTO roomreservations(enter,exit_,room_id,p_id,d_id) " +
                        "values('"+enterDate+"','"+exitDate+"'," +
                        "(select room_id from cs202.rooms where name ='"+ roomName +"')," +
                        "(select u_id from Users where email ='"+ patientEmail +"')," +
                        "(select u_id from Users where email ='"+ doctorEmail +"'))");
                handler.close();
            }
            catch (Exception e){
                e.printStackTrace();
            }
            request.setAttribute("isSet", "true");
            request.getRequestDispatcher("reserve_room.jsp").forward(request,response);
        }
    }
}
