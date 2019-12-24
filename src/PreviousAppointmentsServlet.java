import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class PreviousAppointmentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String userEmail = "";
        for(Cookie cookie: cookies){
            if(cookie.getName().equals("email"))
                userEmail = cookie.getValue();
        }
        String prevDays = request.getParameter("days");


        System.out.println("User Email: " + userEmail);
        System.out.println("Past "  + prevDays + " days ");


        /*MEVCUT GUNDEN ONCESINI BULMA

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
                System.out.println(year + "/0" + month + "/0" + day);
            else{
                if(month < 10)
                    System.out.println(year + "/0" + month + "/" + day);
                else if(day < 10){
                    System.out.println(year + "/" + month + "/0" + day);
                }
                else
                    System.out.println(year + "/" + month + "/" + day);
            }
        }

        System.out.println("Current Date -" + prevDays + " days:");
        System.out.println(stringtimeDB);
        */

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
