# Laboratório 5 — Criando o método para atualizar dados no Banco de Dados

## Visão geral e objetivos do laboratório

Este laboratório tem como objetivo apresentar uma forma básica sobre como atualizar dados em uma tabela no banco de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Atualizar dados que foram persistidos no banco de dados (update ... where id = ?).

## Tarefa 1: Criando o método updateCar()

Agora que você já tem sua aplicação devidamente criada, já conseguiu subir seu servidor web e já consegue gravar, consultar e deletar dados no banco, chegou a hora de implementar a operação que consiste em atualizar dados que foram persistidos no banco de dados da sua aplicação.

1 - Para isso, vamos criar um novo método chamado **updateCar()** que recebe um objeto do tipo car por parâmetro. Esse método deverá ser criado dentro da classe **CarDao**.

OBS: A classe **CarDao** já existe e possui três métodos, sendo eles **createCar()**, **findAllCars** e **deleteCarById()**. Nesta seção nós vamos apenas adicionar um novo método dentro dessa classe. O nome do método deve ser **updateCar()**. Este méotodo receberá um objeto do tipo *Car* como parâmetro e o seu retorno será do tipo *void*.

Para isso, abra a classe **CarDao** e implemente o método **updateCar()**. O código resultante deverá ser igual ao código a seguir:


```java
public void updateCar(Car car) {

}
```

2 - Agora vamos implementar a lógica que faz a atualização do dado na nossa tabela. O primeiro passo consiste em criar uma variável do tipo *string*. Chamaremos essa variável de SQL. Essa variável recebe como valor uma string contento o comando SQL para fazer o delete (UPDATE ... WHERE ID = ?).

O código resultante deverá ser igual ao código a seguir:

```java
public void updateCar(Car car) {

    String SQL = "UPDATE CAR SET NAME = ? WHERE ID = ?";

}
```

OBS: Esse comando fará a atualização do dado armazenado na nossa tabela de acordo com o ID informado. Irá atualizar os dados contigos nos campos informados atravé do comando **SET**. Esse exemplo é extremamente simples. Muita atenção quando você for replicar essa função no seu projeto. 


3 - O restante da implementação do método será bem similar a implementação que fizemos anteriormente no método **createCar()**. Teremos o bloco *try / catch* e também as mensagens de feedback para que possamos saber se a operação foi bem-sucedida ou não.

O código resultante deverá ser igual ao código a seguir:

```java
public void updateCar(Car car) {

    String SQL = "UPDATE CAR SET NAME = ? WHERE ID = ?";

    try {

        Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa","sa");

        System.out.println("success in database connection");

        PreparedStatement preparedStatement = connection.prepareStatement(SQL);

        preparedStatement.setString(1, car.getName());
        preparedStatement.setString(2, car.getId());
        preparedStatement.execute();

        System.out.println("success in update car");

        connection.close();

    } catch (Exception e) {

        System.out.println("fail in database connection");
        System.out.println("Error: " + e.getMessage());

    }

}
```

OBS: Não se preocupe com repetição de código nesse momento. Nos próximos laboratórios nós faremos uma refatoração para remover código repetido *(Boilerplate)*.

4 - Agora que já implementamos o método **updateCar()** que recebe um objeto do tipo *Car* por parâmetro e executa a lógica para a atualização do registro de um carro em nossa tabela, já podemos seguir com a refatoração da *Servlet* que ficará responsável por receber as requisições de *update*. 

No pacote *br.com.carstore.servlet*, procure pela *Servlet* chamada **CreateCarServlet**.

Essa Servlet já existe e receberá algumas alterações. Agora ao receber uma requisição no método *doPost()*, além de coletar o parâmetro *car-name*, nós vamos coletar também o *ID* e armazená-lo em uma variável do tipo String chamada *carId*.

Após essa implementação, o código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import br.com.carstore.dao.CarDao;
import br.com.carstore.model.Car;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String carId = req.getParameter("id");
        String carName = req.getParameter("car-name");

        Car car = new Car(carName);

        new CarDao().createCar(car);

        resp.sendRedirect("/find-all-cars");

    }

}

```

5 - Agora precisamos validar se o valor da variável *carId* é vazio. Se for vazio (não contém um ID) significa que se trata de uma requisição de cadastro. E se o valor da variável *carId* não for um valor vazio (contém um ID) significa que se trata de uma requisição de atualização. 

Para a construção dessa lógica nós utilizaremos o método *isBlank()* da classe **String** que foi introduzido na versão 11 do Java. 

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import br.com.carstore.dao.CarDao;
import br.com.carstore.model.Car;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String carId = req.getParameter("id");
        String carName = req.getParameter("car-name");

        CarDao carDao = new CarDao();
        Car car = new Car(carId, carName);

        if (carId.isBlank()) {

            carDao.createCar(car);

        } else {

            carDao.updateCar(car);
        }


        resp.sendRedirect("/find-all-cars");

    }

}

```

OBS: Repare que se for uma requisição de criação *(insert)*, nós continuaremos chamando o método **createCar()**, caso contrário, nós chamaremos agora o novo método **updateCar()**. O restante da lógica permanece igual.

Pronto, nossas classes *DAO* e *Servlet* estão prontas para receber as requisições e executar o comando de atualização ou criação no nosso banco de dados.

Após executar a chamada para a classe **carDao** e no método **updateCar** uma requisição e feita para o endpoint **/find-all-cars** que por sua vez executa uma nova consulta no banco de dados e exibe os dados atualizados na página **dashboard.jsp**.

## Tarefa 2: Refatorando a página dashboard.jsp

Agora que já construímos a lógica para atualizar os dados de um carro, nós precisamos refatorar a página *dashboard.jsp* e adicionar o *anchor / hyperlink* que irá redirecionar a requisição para a página *index.jsp*, enviados os dados devidamente preenchidos nos campos de input.

1 - Para isso, abra a página *dashboard.jsp*. Localize o *form* que criamos no laboratório anterior dentro da tabela *(table)* e adicione um *anchor* dentro da coluna Actions, ao lado do botão (button) de delete, antes do fechamento do form. Adicionaremos também um label para que visualmente fique dividido o *botão* e o *anchor*.

Após a implementação, o código resultante deverá ser igual ao código a seguir:

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
                    <span> | </span>
                    <a href="index.jsp?id=${car.id}&name=${car.name}">Update</a>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
```

OBS: Repare que o *anchor* irá fazer um *hyperlink* com a página *index.jsp*. Essa operação irá enviar alguns parametrôs como a variável *car.id* e *car.name*. Isso é necessário para que possamos acessar esses valores na página *index.jsp* conforme será demonstrado a seguir.

2 - Trocando a extensão da página **index**

O próximo passo é modificar extensão da página index de **.html** para **.jsp**. Isso é necessário para que possamos acessar os valores que foram enviados por parâmetro na requisição feita através de *hyperlink* da página *dashboard.jsp* para a página *index.jsp*. 

No IntelliJ, navegue até a página **index.html** que fica no diretório: car-store-guide/app/src/main/webapp. Clique com o botão direito do mouse em cima do arquivo index.html, selecione a opção *refactor / rename*, troque a extensão de *.html* para *.jsp*.

![gif animado demonstrando como trocar a extensão da página](/gifs/15-trocando-a-extensao.gif)

3 - Refatorando a página *index.jsp*

Agora que a página index contém a extensão *.jsp*, podemos fazer a refatoração necessária na página para que nossa operação de *update / atualização* possa funcionar corretamente.

Com a página *index.jsp* aberta, iremos adicionar um novo campo *input* do tipo *hidden* (escondido) para armazenar o variável ID ${param.id} e adicionar a propriedade value no campo input para armazenar a variável ${param.name}.

Após a refatoração, o código resultante deverá ser igual ao código a seguir:

```html
<html>
<body>
<h2>Create Car</h2>

<form action="/create-car" method="post">

    <label>Car Name</label>
    <input type="text" name="car-name" id="car-name" value="${param.name}">
    <input type="hidden" id="id" name="id" value="${param.id}">

    <button type="submit">Save</button>

</form>

</body>
</html>

```

4 - Faça uma revisão tudo que foi feito até aqui!

Salve todas as alterações **(CTRL + S)** e execute sua aplicação *(tomcat7:run)*. Acesse sua aplicação através do link http://localhost:8080 e faça o cadastro de um carro. Repare que agora após a tela de cadastro, na tabela da página *dashbard.jsp* é exibido um *hyperlink* com o a label *Update*. Ao clicar nesse hyperlink você será redirecionado novamente para a *index.jsp*, porém os campos vão estar devidamente preenchidos com os valores exibidos na tabela. Basta alterar o valor e clicar no botão register. O usuário será redirecionando para a *dashboard.jsp* e os valores serão alterados no banco de dados conforme demonstrado no gif animado a baixo.

![gif animado demonstrando como trocar a extensão da página](/gifs/16-testando-update.gif)

5 - Mudando o texto do botão *(Opcional)*

Por questões de organização, vamos trocar o texto do botão na página *index.jsp* de *Register* para *Save*.

No IntelliJ, navegue até a página *index.jsp* que fica no diretório: car-store-guide/app/src/main/webapp. Abra o arquivo e localize o botão **register**. 

Troce a palavra *Register* por *Save*.

---

Parabéns! :+1:

Você criou a quarta parte do CRUD (update). Implementou o método *updateCar()* e agora os dados já são atualizados no banco de dados. 

Voltar para: [LABORATÓRIO 4](./LABORATORIO-4.md)

*ou*

Ir para: LABORATÓRIO 6
