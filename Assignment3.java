import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Assignment3 extends JDBCSubmission {

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



        // you may need to set searh sets the search path to parlgov here
        // https://stackoverflow.com/questions/4168689/is-it-possible-to-specify-the-schema-when-connecting-to-postgres-with-jdbc
        
        try {
            super.connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to the PostgreSQL server successfully.");
            return true;
        
        } catch (Exception e) 
        {
            e.printStackTrace();
            // System.err.println(e.getMessage());
        }
        return false;
    }

    @Override
    public boolean disconnectDB() {
        try {
            super.connection.close();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ElectionResult presidentSequence(String countryName) {
       
        /* Execute a query and iterate through the resulting tuples. */
        try {
            List<Integer> presidents = new ArrayList<Integer>();
            List<String> parties = new ArrayList<String>();
            // formator http://web.chacuo.net/formatsql/
            String sql = "select politician_president.id as president_id, politician_president.start_date, politician_president.party_id, party.party_name, country.country_id, country.country_name from politician_president Natural Join (select id as country_id, name as country_name from country where name = ?) country Natural Join (select id as party_id, country_id, name as party_name from party) party order by start_date DESC";
    
            PreparedStatement execStat = super.connection.prepareStatement(sql);

            execStat.setString(1, countryName);
            ResultSet rs = execStat.executeQuery();
            while (rs.next()) {
                int president_id = rs.getInt("president_id");
                String party_name = rs.getString("party_name");

                presidents.add(president_id);
                parties.add(party_name);
            }

            JDBCSubmission.ElectionResult er = new JDBCSubmission.ElectionResult(presidents, parties);
            
            return er;

        } catch(SQLException e){
            e.printStackTrace();
        }
        return null;
        
	}

    @Override
    public List<Integer> findSimilarParties(Integer partyId, Float threshold){
    //     PreparedStatement descripStat = conn.prepareStatement(
    //         "select description from party where id = ?");
    //     descripStat.setInt(1, partyId);
    //     descripStat.executeUpdate();

    //     ResultSet descrip = execStat.descripStat;
    //     String description = getString(1);

    //     PreparedStatement get_party_descrips = conn.prepareStatement(
    //         "select id, description from party");
    //     ResultSet party_descrips = execStat.get_party_descrip();

    //     // String description = "";
    //     // while (party_descrips.next()) {
    //     //     Int id = paty_descrips.party_descrips.getInt(id);

    //     //     if (partyId == id) {
    //     //         description = party_descrips.getString(desription);
    //     //         break;
    //     //     }
    //     // }

    //     List<Integer> result = new ArrayList<Integer>();
    //     party_descrips.first();
    //     while (party_descrips.next()) {
    //         String des = party_descrips.getString(desription);
    //         int id = paty_descrips.party_descrips.getInt(id);

    //         if (id == partyId) {
    //             continue;
    //         }

    //         if (similarity(des, description) > threshold) {
    //             result.add(id);
    //         }
    //     }

        return null;
    }

    public static void main(String[] args) throws Exception {
   	    //Write code here. 
	    System.out.println("Hellow World");
    }

}