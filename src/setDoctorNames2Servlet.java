import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class SetDoctorNames2Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //System.out.println(department);
        String department = request.getParameter("departments");
        String date = request.getParameter("dateInForm");
        String time = request.getParameter("timeInForm");

        DB_Handler handler = new DB_Handler();
        handler.init();

        ArrayList<String> docList = new ArrayList<>();//list of doctors that work in a given department

        int dept_id = 0;
        try{//find the id of the given department
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select dept_id from departments where name = '"+department+"'");
            while(rs.next()){
                dept_id = rs.getInt(1);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        try{//find the doctors that work in that department
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select distinct users.name from users natural join userdeprel inner join departments where userdeprel.dept_id ="+dept_id);
            while(rs.next()){
                docList.add(rs.getString(1));
            }
            String doctorNames = "";
            for(String doctor : docList){
                //System.out.println(doctor);
                doctorNames = doctorNames + doctor + "/";
            }
            response.addCookie(new Cookie("doctorNames", URLEncoder.encode(doctorNames, "UTF-8")));
            //System.out.println("doctorNames cookie added");
            handler.close();
            //response.sendRedirect("makeAppointment.jsp");

            response.addCookie(new Cookie("selectedDept",  URLEncoder.encode(department, "UTF-8")));
            //response.addCookie(new Cookie("dateInForm", date));
            System.out.println("time: " + time);
            System.out.println( URLEncoder.encode(time, "UTF-8"));
            response.addCookie(new Cookie("timeInForm2", URLEncoder.encode(time, "UTF-8")));
            response.addCookie(new Cookie("dateInForm2", URLEncoder.encode(date, "UTF-8")));
            response.sendRedirect("makeAppointment2.jsp");
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}

