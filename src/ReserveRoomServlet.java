import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReserveRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomName = request.getParameter("roomName");
        String date = request.getParameter("date");
        String patientEmail = request.getParameter("patientEmail");
        String startTime = request.getParameter("start");
        String endTime = request.getParameter("end");

        System.out.println("Room name: " + roomName);
        System.out.println("Date: " + date);
        System.out.println("Patient Email: " + patientEmail);
        System.out.println("Starts: " + startTime);
        System.out.println("Ends: " + endTime);
    }
}
