package dk.solarSystem.model;

import java.sql.*;
import java.util.ArrayList;

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
            connect = DriverManager.getConnection(url, user, password);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    private ResultSet MySQLQuarry(String quarry){
        Statement stmt = null;
        try {
            stmt = connect.createStatement();

            return stmt.executeQuery(quarry);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // get all planets information
    public ArrayList<Planet3DInformation> GetAll3DPlanetsInformation (){

        ArrayList<Planet3DInformation> planets = new ArrayList<Planet3DInformation>();

        try {
            ResultSet resultSet = MySQLQuarry("CALL `solarsystem`.`All3DPlanetInformation`();");

            while (resultSet.next()){
                Planet3DInformation planet3DInformation = new Planet3DInformation(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getDouble(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getString(7),
                        resultSet.getDouble(8),
                        resultSet.getString(9),
                        resultSet.getString(10),
                        resultSet.getString(11),
                        resultSet.getDouble(12),
                        resultSet.getString(13),
                        resultSet.getString(14),
                        resultSet.getString(15),
                        resultSet.getString(16),
                        resultSet.getString(17),
                        resultSet.getDouble(18),
                        resultSet.getDouble(19),
                        resultSet.getDouble(20),
                        resultSet.getDouble(21)
                    );

                planet3DInformation.setMoons(getMoonToPlanet(planet3DInformation.getName()));

                planets.add(planet3DInformation);

            }
        }catch (SQLException e){
            System.out.println(e);
        }
        return planets;
    }

    // get the moon to a planet
    public ArrayList<Moon3DInformation> getMoonToPlanet(String planetName){
        ArrayList<Moon3DInformation> moons = new ArrayList<Moon3DInformation>();

        try {
            PreparedStatement preparedStatement = connect.prepareStatement("CALL `solarsystem`.`3DMoonInformation`(?);");
            preparedStatement.setString(1,planetName);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()){
                Moon3DInformation moon3DInformation = new Moon3DInformation(
                        resultSet.getString(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getDouble(4),
                        resultSet.getDouble(5),
                        resultSet.getDouble(6),
                        resultSet.getDouble(7),
                        resultSet.getDouble(8),
                        resultSet.getDouble(9),
                        resultSet.getInt(10),
                        resultSet.getInt(11),
                        resultSet.getString(12)
                        );

                moons.add(moon3DInformation);

            }
        }catch (SQLException e){
            System.out.println(e);
        }
        return moons;
    }

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
