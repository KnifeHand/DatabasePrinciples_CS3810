import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class HelloMySQL {

    public static void main(String[] args) throws Exception {
        String server = "localhost";
        String database = "hr";
        String user = "hr_admin";

        // you should NEVER hard-code passwords like shown in this example in a production environment!!!
        String password = "135791";
        String connectURL = "jdbc:mysql://" + server + "/" + database +
                "?user=" + user + "&password=" + password;

        // connects to the database
        Connection conn = DriverManager.getConnection(connectURL);
        System.out.println("Connection to MySQL database " +
                database + " was successful!");

        // run a simple query
        Statement stmt = conn.createStatement();
        String sql = "SELECT id, name FROM employees";
        ResultSet resultSet = stmt.executeQuery(sql);

        // navigate through the rows of the result set
        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            System.out.println(id + ", " + name);
        }
        // closes the connection
        System.out.println("Bye!");
        conn.close();
    }
}