import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SetAppointmentServlet2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        String times = request.getParameter("times");
        String doctor = request.getParameter("doctor");

        String startDate = date.split("/")[0];
        String endDate = date.split("/")[1];
        String startTime = times.split("-")[0];
        String endTime = times.split("-")[1];

        startTime = changeFormat(startTime);
        endTime = changeFormat(endTime);

        System.out.println("startDate: " + startDate);
        System.out.println("endDate: " + endDate);
        System.out.println("startTime: " + startTime);
        System.out.println("endTime: " + endTime);
        System.out.println("Doctor: " + doctor);



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    public String changeFormat(String time){
        if(time.split(":")[1].substring(2).equals("pm") && !time.equals("12:00pm")){
            time = ((Integer.parseInt(time.split(":")[0]))+12) + ":" + time.split(":")[1];
        }
        return time.substring(0,time.length()-2);
    }
}
