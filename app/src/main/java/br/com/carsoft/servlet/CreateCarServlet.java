package br.com.carsoft.servlet;

import br.com.carsoft.dao.CarDao;

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
        System.out.println(carName);

        CarDao.databaseConnection(carName);

        req.getRequestDispatcher("index.html").forward(req, resp);

    }

}
