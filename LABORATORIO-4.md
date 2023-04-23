# Laboratório 4 — Criando o método para deletar dados no Banco de Dados

## Visão geral e objetivos do laboratório

Este laboratório tem como objetivo apresentar uma forma básica sobre como deletar dados em uma tabela no banco de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Deletar / remover dados que foram persistidos no banco de dados (delete car where id = ?).

## Tarefa 1: Criando o método deleteCarById()

Agora que você já tem sua aplicação devidamente criada, já conseguiu subir seu servidor web e já consegue gravar e consultar os dados no banco de dados, chegou a hora de implementar a operação que consiste em deletar / remover dados que foram persistidos no banco de dados da sua aplicação.

1 - Para isso, vamos criar um novo método chamado **deleteCarById()**. Esse método deverá ser criado dentro da classe **CarDao**.

OBS: A classe **CarDao** já existe e possui dois métodos, sendo eles **createCar()** e **findAllCars**. Nesta seção nós vamos apenas criar /adicionar um novo método dentro dessa classe. O nome do método deve ser **deleteCarById()**. Este méotodo receberá uma String como parâmetro e o seu retorno será do tipo *void*.

Para isso, abra a classe **CarDao** e implemente o método **deleteCarById()**. O código resultante deverá ser igual ao código a seguir:


```java
public void deleteCarById(String carId) {

}
```

2 - Agora vamos implementar a lógica que faz a remocão / delete do dado no banco de dados. O primeiro passo é criar uma variável do tipo string que chamaremos de SQL. Essa variável recebe como valor uma string contento o comando SQL para fazer o delete (DELETE CAR WHERE ID = ?).

```java
public void deleteCarById(String carId) {

    String SQL = "DELETE CAR WHERE ID = ?";

}
```

OBS: Esse comando fará a remoção do dado armazenado na nossa tabela de acordo com o ID informado. 


3 - O restante da implementação do método será bem similar a implementação que fizemos anteriormente no método **createCar()**. Teremos o bloco *try / catch* e também as mensagens de feedback para que possamos saber se a operação foi bem sucedida ou não.

O código resultante deverá ser igual ao código a seguir:

```java
public void deleteCarById(String carId) {

    String SQL = "DELETE CAR WHERE ID = ?";

    try {

        Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

        System.out.println("success in database connection");

        PreparedStatement preparedStatement = connection.prepareStatement(SQL);
        preparedStatement.setString(1, carId);
        preparedStatement.execute();

        System.out.println("success on delete car with id: " + carId);

        connection.close();

    } catch (Exception e) {

        System.out.println("fail in database connection");

    }

}
```

OBS: Não se preocupe com repetição de código nesse momento. Nos próximos laboratórios nós faremos uma refatoração para remover código repetido *(Boilerplate)*.

4 - Agora que já implementamos o método **deleteCarById()** que recebe um ID por parâmetro e executa a lógica para a remoção do registro de um carro em nossa tabela, já podemos seguir com a criação da *Servlet* que ficará responsável por receber as requisições de *delete*.

No pacote br.com.carstore.servlet, selecione a opção *New* e depois a opção *Java Class*. No assistente de criação, digite o nome da classe: **DeleteCarServlet**.

A estrutura dessa servlet será semelhante a estrutura da servlet **CreateCarServlet**, porém o endpoint cadastrado na anotação **@WebServlet** deve ser **/delete-car** e o método a ser sobrescrito (Override) deve ser o método **doPost()**.

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import br.com.carstore.dao.CarDao;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/delete-car")
public class DeleteCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String carId = req.getParameter("id");

        new CarDao().deleteCarById(carId);

        resp.sendRedirect("/find-all-cars");

    }

}
```

Pronto, nossas classes *DAO* e *Servlet* estão prontas para receber a requisição e executar o comando de remoção / delete no nosso banco de dados.

Após executar a chamada para a classe **carDao** e no método **deleteCarById** uma requisição e feita para o endpoint **/find-all-cars** que por sua vez executa uma nova consulta no banco de dados e exibe os dados atualizados na página **dashboard.jsp**.

---

## Tarefa 2: Refatorando o código para retornar o ID

Para que o comando de *remoção / delete* funcione corretamente, nós precisamos que o ID do carro cadastrado seja retornado no momento da consulta. Para isso teremos que fazer uma refatoração no nosso código.

1 - O primeiro passo é refatorar a classe *model* **Car**, adicionando uma nova variável do tipo *String* chamada *id* e um novo construtor sobrecarregado que recebe o *ID* e o *Name* por parametrô. Abra a classe Car que esta localizada dentro do pacote *br.com.carstore.model*, crie uma nova variável privada / private do tipo String chamada ID e crie o seu respectivo método *(getter)* getId(). Na sequência, crie um construtor que recebe *id* e *name* como parâmetro.

OBS: Nenhum código deve ser removido nesta etapa. Apenas adicione uma nova variável e o construtor sobrecarregado.

O código resultante deverá ser igual ao código a seguir:


```java
package br.com.carstore.model;

public class Car {

    private String id;
    private String name;

    public Car(String name) {
        this.name = name;
    }

    public Car(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

}

```

2 - Agora será necessário refatorar o método **findAllCars()** que foi criado no Laboratório 3, para que ao varrer *(while)* o *resultSet*, ele pegue duas propriedades sendo elas *id* e *name*.

O código existente é o seguinte:

```java

while (resultSet.next()) {

    String carName = resultSet.getString("name");

    Car car = new Car(carName);

    cars.add(car);

}

```

Após a refatoração, o código resultante deverá ser igual ao código a seguir:


```java

while (resultSet.next()) {

    String carId = resultSet.getString("id");
    String carName = resultSet.getString("name");

    Car car = new Car(carId, carName);

    cars.add(car);

}

```

3 - Agora será necessário refatorar o formulário html (dashboard.jsp) para exibir o ID no momento da consulta. Abra a página **dashboard.jsp** e adicione a variável *${car.id}*

O código existente é o seguinte:

```html
<c:forEach var="car" items="${cars}">
    <tr>
        <td></td>
        <td>${car.name}</td>
    </tr>
</c:forEach>

```

Após a refatoração, o código resultante deverá ser igual ao código a seguir:

```html
<c:forEach var="car" items="${cars}">
    <tr>
        <td>${car.id}</td>
        <td>${car.name}</td>
    </tr>
</c:forEach>

```

4 - Faça uma revisão tudo que foi feito até aqui!

Parabéns! :+1:

5 - Garanta que tudo até aqui esteja funcionando adequadamente. Salve tudo (CTRL + S) e faça um teste em sua aplicação *tomcat7:run*, faça o cadastro de um carro e veja se o ID agora é exibido quando a página *dashboard.jsp* é renderizada conforme imagem a seguir:

![gif animado demonstrando o id do carro sendo exibido na tabela](/gifs/13-exibindo-o-campo-id.gif)

## Tarefa 3: Refatorando a página dashboard.jsp

Agora que o ID do carro é exibido na página, chegou a hora de implementar a lógica para remoção do carro no formulário html *dashboard.jsp*.

1 - Para isso, abra novamente a página *dashboard.jsp*. Dentro da tabela (table), adicione mais uma coluna (th). A label será *Actions*.

```html
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="car" items="${cars}">
        <tr>
            <td>${car.id}</td>
            <td>${car.name}</td>
        </tr>
    </c:forEach>
</table>
```

2 - O valor que será preenchido será um formulário (form) que ao ser submetido, fará uma requisição HTTP para a nossa nova servlet **DeleteCarServlet** passando o ID do veículo como parametrô.

O código resultante deverá ser igual ao código a seguir:

```html
 <table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="car" items="${cars}">
        <tr>
            <td>${car.id}</td>
            <td>${car.name}</td>
            <td>
                <form action="/delete-car" method="post">
                    <input type="hidden" id="id" name="id" value="${car.id}">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
```

![imagem mostrando o botão delete sendo renderizado no formulário de listagem](/images/02-formulario-com-o-botao.png)

3 - Faça uma revisão tudo que foi feito até aqui!

![gif animado demonstrando a remoção funcionando](/gifs/14-delete-funcionando.gif)

---

Parabéns! :+1:

Você criou a terceira parte do CRUD (delete). Implementou o médoto *deleteCarById()* e agora os dados já são deletados no banco de dados. 

Voltar para: [LABORATÓRIO 3](./LABORATORIO-3.md)

*ou*

Ir para: [LABORATÓRIO 5](./LABORATORIO-5.md)
