package br.com.carsoft.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class CarDao {

    public static void databaseConnection(String carName) {

        String SQL = "INSERT INTO CAR (NAME) VALUES (?)";

        try {

            Connection conn = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            System.out.println("success in database connection");

            PreparedStatement preparedStatement = conn.prepareStatement(SQL);
            preparedStatement.setString(1, carName);
            preparedStatement.execute();

            conn.close();

        } catch (Exception e) {
            System.out.println("Error in database connection");
        }

    }

}
