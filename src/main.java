import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class main {
    public static void main(String[] args){
        DB_Handler handler = new DB_Handler();
        handler.init();
        ArrayList<String> depList = new ArrayList<>();//list of all departments
        ArrayList<String> docList = new ArrayList<>();//list of doctors that work in a given department

        try {//select all departments
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select name from departments");
            while(rs.next()){

                depList.add(rs.getString(1));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        for(String dep : depList){
            System.out.println(dep);
        }



        String dep = "a";//take the department input
        int dept_id = 0;
        try{//find the id of the given department
            Statement stmt = handler.getConn().createStatement();
            ResultSet rs = stmt.executeQuery("select dept_id from departments where name = '"+dep+"'");
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
            for(String doctor : docList){
                System.out.println(doctor);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }




    }
}
