import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Assignment3 extends JDBCSubmission {

    private static Connection con;

    public Assignment3() throws ClassNotFoundException {

        Class.forName("org.postgresql.Driver");
    }

    @Override
    public boolean connectDB(String url, String username, String password) {
	    //write your code here.
        // private final String url = "jdbc:postgresql://localhost/dvdrental";
        // private final String user = "postgres";
        // private final String password = "<add your password>";
        // Connection conn = null;

        try {
            super.connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to the PostgreSQL server successfully.");
            return true;
        
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        catch (ClassNotFoundException ex) 
        {
            System.err.println(ex.getMessage());
        }
        return false;
        

    }

    @Override
    public boolean disconnectDB() {
        try {
            super.connection.close();
            return true;
        } catch (SQLException e) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public ElectionResult presidentSequence(String countryName) {
            //Write your code here.
            return null;
	}

    @Override
    public List<Integer> findSimilarParties(Integer partyId, Float threshold) {
	//Write your code here.
        return null;
    }

    public static void main(String[] args) throws Exception {
   	    //Write code here. 
	    System.out.println("Hellow World");
    }

}