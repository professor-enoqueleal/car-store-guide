package br.com.carsoft.dao;

import br.com.carsoft.model.Car;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class CarDaoImpl implements CarDao {

    @Override
    public void createCar(Car car) {

        String SQL = "INSERT INTO CAR (NAME) VALUES (?)";

        try {

            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

            System.out.println("success in database connection");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, car.getName());
            preparedStatement.execute();

            connection.close();

        } catch (Exception e) {

            System.out.println("Error in database connection");

        }

    }

}
