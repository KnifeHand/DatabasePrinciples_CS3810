import java.io.*;
import java.sql.*;
import java.util.*;

public class JavaSPExample {

    public static void main(String[] args) throws Exception {

        // open config.properties file
        Properties prop = new Properties();
        prop.load(new FileInputStream("config.properties"));

        // read properties
        String server = prop.getProperty("server");
        String database = prop.getProperty("database");
        String user = prop.getProperty("user");
        String password = prop.getProperty("password");
        String connectURL = "jdbc:mysql://" + server + "/"
                + database + "?serverTimezone=UTC&user="
                + user + "&password=" + password;

        // connects to the database
        Connection conn = DriverManager.getConnection(connectURL);
        System.out.println("Connection to MySQL database "
                + database + " was successful!");

        // get artist from the user
        System.out.print("artist? ");
        String artist = (new Scanner(System.in)).nextLine();

        // send the query using a CallableStatement
        String sql = "{call albums_number_tracks(?)}";
        CallableStatement cs = conn.prepareCall(sql);
        cs.setString(1, artist);
        cs.execute();

        // get the results
        ResultSet rs = cs.getResultSet();
        while (rs.next()) {
            int year = rs.getInt("year");
            String title = rs.getString("title");
            int tracks = rs.getInt("tracks");
            System.out.println(year + ", " + title + ", " + tracks);
        }

        // closes the connection
        System.out.println("Bye!");
        conn.close();
    }
}