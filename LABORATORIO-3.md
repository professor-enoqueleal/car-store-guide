# Laboratório 3 — Criando o método para buscar os dados no Banco de Dados

## Visão geral e objetivos do laboratório

Este laboratório apresenta as ações básicas criar uma camada de consulta na camada de persitêcia de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Consultar os dados que foram persistido no banco de dados (select * from car) e exibir os dados em um formulário HTML.

## Tarefa 1: Criando o método findAllCar()

Agora que você já tem sua aplicação devidamente criada, já conseguiu subir seu servidor web. Já consegue gravar os dados no banco de dados, chegou a hora de implementar uma camada de consulta dos dados persistidos no banco de dados da sua aplicação.

1) Para isso, vamos refatorar a classe model **Car**, removendo o método setter e criando um construtor sobrecarregado. Abra a classe Car, apague o método getName() e criei um construtor que recebe name como parâmetro.

O código resultante deverá ser igual ao código a seguir:


```java
package br.com.carstore.model;

public class Car {

    private String name;

    public Car(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

}
```

2) Devido a essa refatoração na classe **Car**, é necessário fazer um ajuste na classe **CreateCarServlet.java**, removendo a linha **car.setCarName(carName)** e passando o parâmetro carName via construtor **Car car = new Car(carName)**.

Após a refotoração, o código da classe **CreateCarServlet.java** deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import br.com.carstore.dao.CarDao;
import br.com.carstore.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String carName = req.getParameter("car-name");

        Car car = new Car(carName);

        new CarDao().createCar(car);

        req.getRequestDispatcher("index.html").forward(req, resp);

    }

}
```

3) Agora vamos criar um novo método chamado **findAllCars** dentro da classe CarDao. Para isso, abra a classe CarDao.

Crie o método **findAllCars** que devolve uma lista do tipo **Car**. O código resultante deverá ser igual ao código a seguir:

```java
public List<Car> findAllCars() {

}
```
Nesse momento o seu IDE vai esta alertando erro porque o retorno (return) ainda não foi implementado. Não se preocupe porque isso será resolvido no passo a seguir.

4) Agora vamos implementar a lógica que faz a busca dos dados no banco de dados. O primeiro passo é criar nossa string SQL contento o comando SQL para a busca (SELECT * FROM).

O código resultante deverá ser igual ao código a seguir:

```java
public List<Car> findAllCars() {

     String SQL = "SELECT * FROM CAR";

}
```

Esse comando fará uma busca no nosso banco de dados, na tabela CAR e retornará todos os registros existentes nessa tabela.

5) O restante da implementação será bem similar a implementação do método **createCar()**. Teremos o bloco *try / catch* e também as mensagens de feedback para que possamos saber se a operação foi bem sucedida ou não.

O código resultante deverá ser igual ao código a seguir:

```java
 public List<Car> findAllCars() {

        String SQL = "SELECT * FROM CAR";

        try {

            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

            System.out.println("success in database connection");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            ResultSet resultSet = preparedStatement.executeQuery();

            List<Car> cars = new ArrayList<>();

            while (resultSet.next()) {

                String carName = resultSet.getString("name");

                Car car = new Car(carName);

                cars.add(car);

            }

            System.out.println("success in select * car");

            connection.close();

            return cars;

        } catch (Exception e) {

            System.out.println("fail in database connection");

            return Collections.emptyList();

        }

    }
```

6) Agora que já implementamos o método findAllCar que retorna uma lista com todos os carros que foram cadastrados na nossa tabela Car, podemos seguir com a criação da nossa Servlet responsável por receber as requisições de consulta.

No pacote servlet, selecione a opção *New* e depois a opção *Java Class*. No assistente de criação, digite o nome da classe: **ListCarServlet**.

A estrutura dessa servlet será semelhante a estrutura da servlet **CreateCarServlet**, porém o endpoint cadastrado na anotação **@WebServlet** deve ser **find-all-cars** e o método a ser sobrescrito (Override) é o método **doGet()**.

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import br.com.carstore.dao.CarDao;
import br.com.carstore.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/find-all-cars")
public class ListCarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        super.doGet(req, resp);

    }

}
```

7) Agora com a classe **ListCarServlet** criada e o método doGet sobrescrito, podemos implementar a lógica que chamará a classe CarDao e o médoto **findAllCars()**.

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import br.com.carstore.dao.CarDao;
import br.com.carstore.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/find-all-cars")
public class ListCarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Car> cars = new CarDao().findAllCars();

        req.setAttribute("cars", cars);

        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);

    }

}
```

Perceba que agora estamos redirecionando o usuário para uma nóva página chamada dashboard.jsp. Essa página ainda não existe e vamos cria-la no passo a seguir.

8) Agora vamos criar a página para exibir o resultado da nossa consulta em uma tabela (table) na nossa página HTML.

Crie uma nova página chamada **dashboard.jsp** dentro da pasta **webapp**. Dentro dessa página crie uma tabela (table) com duas colunas, uma coluna para a *propriedade* ID e a outra para a propriedade *Name*.

O código resultante deverá ser igual ao código a seguir:

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
  <div>
    <h1>Cars</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
        </tr>
        <tr>
            <td></td>
            <td></td>
        </tr>
    </table>
  </div>
</body>
</html>
```

9) Agora vamos adicionar o import da taglib do **JSTL** (The JavaServer Pages Standard Tag Library). É através dessa tag library que nós poderemos fazer o uso de IF ou FOR dentro da nossa página.

Após adicionar o import da tag library e o laço for, o código resultante deverá ser igual ao código a seguir:

```html
<!DOCTYPE html>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
  <div>
    <h1>Cars</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
        </tr>
        <c:forEach var="car" items="${cars}">
            <tr>
                <td></td>
                <td>${car.name}</td>
            </tr>
        </c:forEach>
    </table>
  </div>
</body>
</html>
```

10) O ultimo passo é redirecionar o usuário para a nova página a pós a criação (insert) de um novo carro no nosso banco de dados. Para isso, na classe **CreateCarServlet**, troque a linha que contém o código:

```java
 req.getRequestDispatcher("index.html").forward(req, resp);
```
Pela linha a seguir:

```java
resp.sendRedirect("/find-all-cars");
```

Feito isso, após a criação de um novo carro, a requisição será redirecionada para a nossa nova servlet **ListCarServlet** que executará o método **doPost()**, fará a consulta no banco de dados e no final irá redirecionar o usuário para a página dashboard.jsp onde os cadastraados no banco de dados serão renderizados no browser.

11) Faça uma revisão tudo que foi feito até aqui!

---

Parabéns! :+1:

Você criou a segunda parte do no CRUD (read). Implementou o médoto findAllCar e agora os dados já são consultados no banco de dados e exibidos em nosso novo formulário HTML. 

Voltar para: [LABORATÓRIO 2](./LABORATORIO-2.md)

*ou*

Ir para: [LABORATÓRIO 4](./LABORATORIO-4.md)
