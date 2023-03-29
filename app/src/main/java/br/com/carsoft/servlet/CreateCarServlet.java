package br.com.carsoft.servlet;

import br.com.carsoft.dao.CarDao;
import br.com.carsoft.dao.CarDaoImpl;
import br.com.carsoft.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static br.com.carsoft.util.ObjectMapper.transformRequestToObject;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse resp) throws ServletException, IOException {

        Car car = transformRequestToObject(httpServletRequest, Car.class);

        new CarDaoImpl().createCar(car);

        httpServletRequest.getRequestDispatcher("index.html").forward(httpServletRequest, resp);

    }

}
