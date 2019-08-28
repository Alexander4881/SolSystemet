package dk.solarSystem.model;

import java.sql.*;

public class MySQLAccess {

    /**
     * 3306 is the default port for MySQL in XAMPP. Note both the
     * MySQL server and Apache must be running.
     */
    String url = "jdbc:mysql://localhost:3306/solarsystem";

    /**
     * The MySQL user.
     */
    String user = "root";

    /**
     * Password for the above MySQL user. If no password has been
     * set (as is the default for the root user in XAMPP's MySQL),
     * an empty string can be used.
     */
    String password = "";

    private Connection connect = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    public MySQLAccess(){

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connect = DriverManager.getConnection(url, user, password);

            Statement stmt = connect.createStatement();
            ResultSet rs = stmt.executeQuery("select * from Planet");

            printResultSet(rs);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public

    private void printResultSet(ResultSet resultSet) throws SQLException {
        // ResultSet is initially before the first data set
        while (resultSet.next()) {
            // It is possible to get the columns via name
            // also possible to get the columns via the column number
            // which starts at 1
            // e.g. resultSet.getString(2);
            String column1 = resultSet.getString(1);
            String column2 = resultSet.getString(2);
            /*String column3 = resultSet.getString(3);
            String column4 = resultSet.getString(4);*/

            System.out.println("column1: " + column1);
            System.out.println("column2: " + column2);
            /*System.out.println("column3: " + column3);
            System.out.println("column4: " + column4);*/
        }
    }
}
