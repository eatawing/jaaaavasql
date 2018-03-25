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
    public List<Integer> findSimilarParties(Integer partyId, Float threshold){
        PreparedStatement descripStat = conn.prepareStatement(
            "select description from party where id = ?");
        descripStat.setInt(1, partyId);
        descripStat.executeUpdate();

        ResultSet descrip = execStat.descripStat;
        String description = getString(1);

        PreparedStatement get_party_descrips = conn.prepareStatement(
            "select id, description from party");
        ResultSet party_descrips = execStat.get_party_descrip();

        // String description = "";
        // while (party_descrips.next()) {
        //     Int id = paty_descrips.party_descrips.getInt(id);

        //     if (partyId == id) {
        //         description = party_descrips.getString(desription);
        //         break;
        //     }
        // }

        List<Integer> result = new ArrayList<Integer>();
        party_descrips.first();
        while (party_descrips.next()) {
            String des = party_descrips.getString(desription);
            int id = paty_descrips.party_descrips.getInt(id);

            if (id == partyId) {
                continue;
            }

            if (similarity(des, description) > threshold) {
                result.add(id);
            }
        }

        return result;
    }

    public static void main(String[] args) throws Exception {
   	    //Write code here. 
	    System.out.println("Hellow World");
    }

}