# Laboratório 2 — Adicionando uma camada de persistência na sua Java Web

## Visão geral e objetivos do laboratório

Este laboratório apresenta os conceitos básicos para criar uma aplicação Java Web contendo uma camada de persitêcia de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Provisionar uma camada de persistência para a aplicação Java Web;
- Subir um servidor Tomcat (Servlet Container) e um banco de dados em memória (H2 DB) embed para executar sua aplicação Java e persistir seus dados;
- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Gravar os dados que foram capturados de um formulário HTML e persisti-los em um banco de dados (insert).

## Tarefa 1: Adicionar uma nova dependência ao seu projeto

Agora que você já tem sua aplicação devidamente criada, já conseguiu subir seu servidor web, chegou a hora de adicionar uma camada de persistência de dados na sua aplicação. 

1) Abra o arquivo arquivo **pom.xml**

2) Localize o bloco **dependencies**. Você deverá adicionar uma nova dependência dentro deste bloco.

**OBS**: Nenhuma dependência deve ser removida nesse processo. Adicione a dependência a seguir dentro do bloco **dependencies**: 

```xml
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <version>2.1.214</version>
</dependency>
```

3) O código resultante deverá ser igual ao código a seguir:

```xml
<dependencies>

    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>3.8.1</version>
        <scope>test</scope>
    </dependency>

    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>3.0.1</version>
        <scope>provided</scope>
    </dependency>

    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>

    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
        <version>2.1.214</version>
    </dependency>

</dependencies>

```

4) Faça uma revisão tudo que foi feito até aqui!

Parabéns! :+1:

Você adicionou a dependência do H2 DB (Banco de dados em memória).


## Tarefa 2: Registrando o listener do H2 DB no arquivo web.xml

:warning: Para saber mais sobre o H2 DB, visite a documentação oficial através desse link: [H2 Database Engine](https://www.h2database.com)

1) Agora que a dependência do H2 foi adicionada ao projeto, será necessário registrar o *listener* do H2 no arquivo web.xml. Para isso navegue até o arquivo web.xml. Este arquivo fica localizado no diretório: car-store/src/main/webapp/WEB-INF/web.xml

2) Com o arquivo web.xml aberto, adicione o *listener* dentro do bloco *web-app* conforme código a seguir:

```xml
<listener>
    <listener-class>org.h2.server.web.DbStarter</listener-class>
</listener>

<servlet>
    <servlet-name>H2Console</servlet-name>
    <servlet-class>org.h2.server.web.WebServlet</servlet-class>
    <load-on-startup>1</load-on-startup>
</servlet>

<servlet-mapping>
    <servlet-name>H2Console</servlet-name>
    <url-pattern>/console/*</url-pattern>
</servlet-mapping>
```

**OBS**: Nenhuma configuração deverá ser removida nesse processo.

3) O resultado final deverá ser igual ao código a seguir:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns="http://java.sun.com/xml/ns/javaee"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
         id="WebApp_ID" version="3.0">

    <display-name>car-store</display-name>

    <listener>
        <listener-class>org.h2.server.web.DbStarter</listener-class>
    </listener>

    <servlet>
        <servlet-name>H2Console</servlet-name>
        <servlet-class>org.h2.server.web.WebServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>H2Console</servlet-name>
        <url-pattern>/console/*</url-pattern>
    </servlet-mapping>

</web-app>
```

4) Salve todas as alterações **(CTRL + S)** e execute sua aplicação *(tomcat7:run)*. Com o *listener* do **H2 DB** devidamente registrado, é possível acessar a console de gerênciamento através do link: *http://localhost:8080/console*

5) Após acessar a console do **H2 DB**, faça o login utilizando as informações a seguir:

    * Driver Class: *org.h2.Driver*
    * JDBC URL: *jdbc:h2:~/test*
    * User Name: *sa*
    * Password: *sa*

6) Após efetuar o login, você poderá criar sua primeira tabela. Você deverá criar uma tabela chamada **CAR**. Para isso utilize o comando **SQL** a seguir:

```sql
CREATE TABLE CAR(ID INT PRIMARY KEY AUTO_INCREMENT, NAME VARCHAR(255));
```

![gif animado demonstrando como criar_uma_tabela_no_h2_db](/gifs/11-criando-tabela-no-h2.gif)

7) Faça uma revisão tudo que foi feito até aqui!

Parabéns! :+1:

Você adicionou a dependência de um banco de dados em memória (H2 DB) na sua aplicação Java Web. Agora que você adicionou a dependência do H2 DB no arquivo pom.xml da sua aplicação, ao fazer o start *(tomcat7:run)*, quando a aplicação é iniciada temos um banco de dados relacional a nossa disposição e temos também uma console para gerenciamento do mesmo.


## Tarefa 3: Criando a primeira Model e a primeira DAO

Agora que temos tem um banco de dados devidamente configurado, chegou a hora de criar a primeira classe model (Car) e a primeira classe DAO (CarDao).

1) Agora vamos criar dois novos pacotes (packages), o primeiro se chama *dao* e o segundo *model*. Para isso, navegue até o pacote principal (br.com.carstore). No seu projeto, navegue até o diretório: car-store-guide/app/src/main/java/br.com.carstore, clique com o botão direito do mouse em cima do pacote principal (br.com.carstore) e escolha a opção *New / Package* e insira o nome do primeiro pacote (dao). Repita a operação para criar o segundo pacote (dao).

No final da criação, o resultado esperado é que tenhamos agora três subpacotes dentro do pacote principal seguindo a hierarquia:

```
car-store/
|..| src/
|  |..| main/
|  |  |..| java/
|  |  |  |..| br.com.carstore
|  |  |  |  |..| dao
|  |  |  |  |..| model
|  |  |  |  |..| servlet
|  |  |..| webapp/
|  |  |  |..| WEB-INF/
|  |  |  |  |..| web.xml
|  |  |  |..| index.html
```

![imagem demonstrando a estrutura do projeto](/images/01-project-structure.png)

2) Agora com os novos pacotes devidamente criados, vamos criar a nossa classe model chamada Car. Para isso, clique com o botão direito do mouse em cima do pacote model, escolha a opção *New, Java Class*, depois digite *Car* e aperte a tecla ENTER. O assistente de criação do IntelliJ irá criar uma nova classe Java chamada **Car**.

3) Com a classe Car devidamente criada, vamos criar um atribute para ela do tipo *String* com o modificador de acesso *privado* e com o nome de **name**.

4) Crie os métodos acessores (getters and setters) para esse atributo que acabamos de criar *(private String name)*.

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.model;

public class Car {

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}

```

5) Agora que já temos a classe Car devidamente criada, podemos criar nossa classe CarDao. Para isso, clique com o botão direito do mouse em cima do pacote dao, escolha a opção *New, Java Class*, depois digite *CarDao* e aperte a tecla ENTER. O assistente de criação do IntelliJ irá criar uma nova classe Java chamada **CarDao**.

6) Com a classe **CarDao** criada, vamos implementar um método chamado **createCar** que retorna **void** (não retorna nada) e que recebe por parâmetro um objeto do tipo Car.

Nessa etapa, o código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.dao;

import br.com.carstore.model.Car;

public class CarDao {

    public void createCar(Car car) {

    }

}

```

7) Agora com o método *createCar* devidamente criado, vamos implementar a lógica de persistência dos valores do objeto car no nosso banco de dados. Nessa etapa, o código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.dao;

import br.com.carstore.model.Car;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class CarDao {

    public void createCar(Car car) {

        String SQL = "INSERT INTO CAR (NAME) VALUES (?)";

        try {

            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa","sa");

            System.out.println("success in database connection");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            preparedStatement.setString(1, car.getName());
            preparedStatement.execute();

            System.out.println("success in insert car");

            connection.close();

        } catch (Exception e) {

            System.out.println("fail in database connection");

        }

    }

}
```

8) Atenção em toda a implementação e nos imports. Nessa etapa nenhum erro deve ser sinalizado pela sua IDE. Caso seu IDE sinalize algum erro, reveja todos os passos anteriores para garantir que esteja tudo correto.

9) Com toda a implementação devidamente feita, já é possível testar o projeto para garantir que tudo funciona corretamente.

![gif animado demonstrando o projeto funcionando e gravando dados no h2 db](/gifs/12-mostrando-o-projeto-funcionando.gif)

10) Faça uma revisão tudo que foi feito até aqui!

---

Parabéns! :+1:

Você adicionou a dependência de um banco de dados em memória (H2 DB) na sua aplicação Java Web, criou a primeira classe model e dao. Implementou a lógica para abrir uma conexão com o bando de dados (H2) e o comando de persistência (insert) dos dados no banco.

Agora ao fazer o start *(tomcat7:run)*, quando a aplicação é iniciada temos um banco de dados relacional a nossa disposição e temos também uma console para gerenciamento do mesmo. Nesse momento a parte do create do nosso CRUD está implementada e funcionando.

Voltar para: [LABORATÓRIO 1](./LABORATORIO-1.md)

*ou*

Ir para: [LABORATÓRIO 3](./LABORATORIO-3.md)