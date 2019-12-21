import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class showRoomAvailability extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomNumber = request.getParameter("roomName");
        String date = request.getParameter("date").toString() ;
        String start = request.getParameter("start");
        String end = request.getParameter("end");

        System.out.println(roomNumber);
        System.out.println(date);
        System.out.println(start);
        System.out.println(end);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
