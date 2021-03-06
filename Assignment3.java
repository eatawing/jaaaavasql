import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Assignment3 extends JDBCSubmission {

    public Assignment3() throws ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
    }

    @Override
    public boolean connectDB(String url, String username, String password) {
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
        try {
            List<Integer> presidents = new ArrayList<Integer>();
            List<String> parties = new ArrayList<String>();
            
            //SQL statements to get the corresponding ids, start dates, party name etc. of each president of the given country.
            String sql = "select politician_president.id as president_id, politician_president.start_date, " +
                         "  politician_president.party_id, party.party_name, country.country_id, country.country_name " + 
                         "from politician_president Natural Join " +
                         "  (select id as country_id, name as country_name from country where name = ?) country Natural Join " + 
                         "  (select id as party_id, country_id, name as party_name from party) party " + 
                         "order by start_date DESC";
    
            PreparedStatement execStat = super.connection.prepareStatement(sql);

            execStat.setString(1, countryName);
            ResultSet rs = execStat.executeQuery();

            //iterate through the result set and add them to lists
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
        try {
            //SQL statments to get the description of the given partyId.
            PreparedStatement descripStat = super.connection.prepareStatement("select description from party where id = ?");
            descripStat.setInt(1, partyId);
            ResultSet rs = descripStat.executeQuery();

            //extract the description into a string.
            String description = null;
            List<Integer> retlist = new ArrayList<Integer>();        
            while (rs.next()) {
                description = rs.getString("description");
            }

            //if cannot find, return null
            if (description == null) {
                return retlist;
            }

            PreparedStatement get_party_descrips = super.connection.prepareStatement("select id, description from party");
            rs = get_party_descrips.executeQuery();

            //iterate through the result set to find party ids with similar descriptions
            while (rs.next()) {
                String des = rs.getString("description");
                int id = rs.getInt("id");

                //omit the given party itslef
                if (id == partyId) {
                    continue;
                }

                if (super.similarity(des, description) >= threshold) {
                    //add to result list
                    retlist.add(id);
                }
            }

            return retlist;
        } catch(SQLException e){
            e.printStackTrace();
        }
        
        return null;
    }

    public static void main(String[] args) throws Exception {
   	    //Write code here. 
	    System.out.println("Hellow World");
    }
}
