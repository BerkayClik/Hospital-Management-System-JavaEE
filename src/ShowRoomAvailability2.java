import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

public class ShowRoomAvailability2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomNumber = request.getParameter("roomName");
        String date = request.getParameter("date");
        String start = request.getParameter("start");
        String end = request.getParameter("end");
        String dbDate = "";
        String user = "";

        Cookie[] cookies = request.getCookies();
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("role_id")){
                if(cookie.getValue().equals("2"))
                    user = "doctor";
                else
                    user = "nurse";
            }
        }

        System.out.println(date);

        if(roomNumber.equals("") || start.equals("") || end.equals("") || date.equals("")){
            request.setAttribute("errorAvail", "true");
            if(user.equals("doctor"))
                request.getRequestDispatcher("reserve_room.jsp").forward(request,response);
            else
                request.getRequestDispatcher("room_availability.jsp").forward(request,response);
        }
        else{
            dbDate = date.replace("-","/");
            start = start.substring(0,start.length()-2);
            end = end.substring(0,end.length()-2);

            if(start.length() == 4)
                start = "0" + start;
            if(end.length() == 4)
                end = "0" + end;


            //kullanıcın girdiği start time -1 dakika
            String userStart= dbDate + " " + start.substring(0,3) + "01";
            System.out.println(userStart);
            Date userStartDate= null;
            try {
                userStartDate = new SimpleDateFormat("yyyy/MM/dd HH:mm", Locale.UK).parse(userStart);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            //kullanıcın girdiği end time -1 dakika
            String userEnd=dbDate + " " + (Integer.parseInt(end.substring(0,2))) + ":58";//10:00
            if(userEnd.length() == 15)//09:59
                userEnd = userEnd.substring(0,11) + "0" + userEnd.substring(11);
            System.out.println(userEnd);
            Date userEndDate= null;
            try {
                userEndDate = new SimpleDateFormat("yyyy/MM/dd HH:mm", Locale.UK).parse(userEnd);
            } catch (ParseException e) {
                e.printStackTrace();
            }

            int difference = (((int) userEndDate.getTime()) - ((int) userStartDate.getTime())) / 3600000;
            System.out.println(difference);

            //kullanıcının seçtiği room id
            String roomName = roomNumber;


            DB_Handler handler = new DB_Handler();
            handler.init();
            ArrayList<Timestamp> enterExitList = new ArrayList<>();
            ArrayList<Integer> successList = new ArrayList<>();


            //ROOM ID BULUNMALI, SONRA ALTTAKI QUERY ÇALIŞMALI
            int roomID = 0;
            try {
                Statement stmt = handler.getConn().createStatement();
                ResultSet rs = stmt.executeQuery("select room_id from cs202.rooms where name ='"+ roomName +"'");
                while(rs.next()){
                    roomID = rs.getInt(1);
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }


            try {//select all rooms
                Statement stmt = handler.getConn().createStatement();
                ResultSet rs = stmt.executeQuery("select enter,exit_ from cs202.RoomReservations where room_id = " + roomID);
                while(rs.next()){
                    enterExitList.add(rs.getTimestamp(1));
                    enterExitList.add(rs.getTimestamp(2));

                }
            }
            catch (Exception e){
                e.printStackTrace();
            }

            boolean success = true;
            try {
                for (int i = 0;i<=difference;i++){
                    Statement stmt = handler.getConn().createStatement();
                    ResultSet rs = stmt.executeQuery("select res_id from RoomReservations where '" + userStart + "' between enter and exit_ and room_id = " + roomID);
                    while(rs.next()){
                        successList.add(rs.getInt(1));
                    }
                    //System.out.println("UserStart: " + userStart);
                    String time = userStart.substring(11).split(":")[0];
                    int hours = Integer.parseInt(time);
                    if(hours+1 < 10){
                        userStart = userStart.substring(0,11) + (hours+1) + ":01";
                    }
                    else{
                        userStart = userStart.substring(0,11) + (Integer.parseInt(userStart.split(" ")[1].split(":")[0])+1) + ":01";
                    }

                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
            if(successList.size()!=0){
                success = false;
            }
            System.out.println(success);



            if(success)
                request.setAttribute("isAvailable", "true");
            else
                request.setAttribute("isAvailable", "false");

            request.setAttribute("roomName", roomName);
            request.setAttribute("date", date);
            request.setAttribute("start", start);
            request.setAttribute("end", end);

            if(user.equals("doctor"))
                request.getRequestDispatcher("reserve_room.jsp").forward(request,response);
            else
                request.getRequestDispatcher("room_availability.jsp").forward(request,response);


        }
    }

}
