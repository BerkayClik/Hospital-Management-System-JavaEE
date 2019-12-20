import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class setRoomNamesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DB_Handler handler = new DB_Handler();
        handler.init();
        ArrayList<String> roomList = new ArrayList<>();//list of all rooms

        try {//select all rooms
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select name from Rooms");
            while(rs.next()){
                roomList.add(rs.getString(1));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        String roomNames = "";
        for(String room : roomList){
            //System.out.println(room);
            roomNames = roomNames + room + "/";
        }
        //System.out.println(roomNames);
        handler.close();

        response.addCookie(new Cookie("htmlRoomNames", URLEncoder.encode(roomNames, "UTF-8")));
        response.sendRedirect("nurse/room_availability.jsp");
        //request.setAttribute("isSet", "true");
        //request.setAttribute("htmlRoomNames", roomNames);
        //request.getRequestDispatcher("nurse/room_availability.jsp").forward(request, response);

        //Düzenlicek
        //response.sendRedirect("patient/makeAppointment.jsp");
        /*
        String html = "";
        for(String dep : depList){
            //System.out.println(dep);
            //deptNames = deptNames + dep + "/";
            html = html + "<option value=\"" + dep+ "\">" + dep + "</option>";
        }
        //response.addCookie(new Cookie("deptNames", URLEncoder.encode(deptNames, "UTF-8")));
        handler.close();
        request.setAttribute("firstLoad", "true");
        request.setAttribute("html", html);
        request.setAttribute("htmlDocs", htmlDocs);
        //System.out.println("inServlet");
        request.getRequestDispatcher("patient/makeAppointment.jsp").forward(request, response);
         */
    }
}
