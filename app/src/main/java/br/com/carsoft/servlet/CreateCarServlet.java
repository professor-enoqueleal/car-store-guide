package br.com.carsoft.servlet;

import br.com.carsoft.dao.CarDao;
import br.com.carsoft.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String carName = req.getParameter("car-name");

        Car car = new Car();
        car.setName(carName);

        new CarDao().createCar(car);

        req.getRequestDispatcher("index.html").forward(req, resp);

    }

}
