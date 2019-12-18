import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class setOffDayServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String days = request.getParameter("days");
        String times = request.getParameter("times");

        String[] daysArray = days.split("/");
        String[] timesArray = times.split("/");

        for(int i=0; i<daysArray.length; i++){
            System.out.print(daysArray[i]);
            System.out.println("-->" + timesArray[i]);
        }

        //ArrayList<String> cars = new ArrayList<String>();

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
