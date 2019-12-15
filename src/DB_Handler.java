import java.sql.*;

public class DB_Handler {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cs202";
    private static final String USER = "root";
    private static final String PASS = "13212karE";

    private static Connection conn = null;
    private static Statement stmt = null;
    private static PreparedStatement pstmt = null;

    public boolean init() {
        try {
            //Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
            System.out.println("Connected");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Problem!");
            return false;
        }
    }

    public boolean handleQuery(String query) {
        try {
            stmt.executeUpdate(query);
            close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void close(){
        try {
            conn.close();
        } catch (Exception e) {
            System.out.println("Error while Closing");
        }
    }
}
