# Laboratório 7 — Criando a a funcionalidade de login

## Visão geral e objetivos do laboratório

Este laboratório tem como objetivo apresentar uma forma básica sobre como implementar uma funcionalidade de login utilizando usuário e senha.

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Criar uma tabela no banco de dados para armazenar as credencias de login (username e password);
- Criar uma classe DAO (Data Access Object) para verificação das credencias de login;
- Implementar um formulário HTML para capturar as credenciais de login;
- Implementar um Filter para verificar se o usuário esta logado a cada requisição;

---
## Tarefa 1: Criando a tabela USR (Usuário)

Uma das características do sistema **Car Store** é sua área administrativa que só deve ser acessada por utilizadores autorizados. Para isso ser possível, será necessário a implementação de uma camada de autenticação.

1 - Criar uma nova tabela usuário. Com a aplicação em execução *(tomcat7:run)* navegue até a console de gerênciamento do *H2 DB* através do link: *http://localhost:8080/console*

2 - Após acessar a console do **H2 DB**, faça o login utilizando as informações a seguir:

   * Driver Class: *org.h2.Driver*
   * JDBC URL: *jdbc:h2:~/test*
   * User Name: *sa*
   * Password: *sa*

3 - Após efetuar o login, você poderá criar sua segunda tabela. Você deverá criar uma tabela chamada **USER**. Para isso utilize o comando **SQL** a seguir:

```sql
CREATE TABLE USR (ID INT PRIMARY KEY AUTO_INCREMENT, USERNAME VARCHAR(255), PASSWORD VARCHAR(255));
```

4 - Depois que a tabela foi criada, vamos fazer a criação do nosso primeiro usuário de forma manual. Para isso, utilize o seguinte comando SQL:

```sql
INSERT INTO USR (USERNAME, PASSWORD) VALUES ('your-user', 'your-password')
```

5 - Faça uma revisão tudo que foi feito até aqui, para garantir que a tabela foi criada e que o cadastro (INSERT) do primeiro usuário funcionou corretamente.

---

## Tarefa 2: Criando as classes Model e DAO responsáveis por recuperar as credenciais de login

1 - O primeiro paço é criar a classe User. Para isso, No IntelliJ o pacote *(package)* model que fica no diretório: car-store-guide/app/src/main/java/br.com.carstore.model, clique com o botão direito do mouse e selecione a opção New / Java Class e digite o nome **User** e pressione a tecla **ENTER**. 

Após a classe **User** ter sido criada, vamos adicionar duas propriedades do tipo String com o modificador de acesso private. As propriedades são **username** e **password**.

Precisamos implementar o método acessor (getters) e um construtor sobrecarregado que recebe essas duas novas propriedades.

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.model;

public class User {
    
    private String username;
    private String password;

    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

}

```

2 - O segundo paço consiste em criar a DAO chamada **UserDao**. Essa classe será a responsável por fazer a consulta no banco de dados e recuperar as credenciais do usuários armazenadas no banco de dados. 

Para isso, No IntelliJ navegue até o pacote *(package)* DAO que fica no diretório: car-store-guide/app/src/main/java/br.com.carstore.dao, clique com o botão direito do mouse e selecione a opção New / Java Class e digite o nome **UseDao** e pressione a tecla **ENTER**.

3 - Após a classe ter sido criada, vamos implementar o nosso primeiro método chamado **verifyCredentials()**. Esse método retorna um boolean e recebe um parâmetro do tipo **User**.

Ele será responsável por fazer a consulta no banco de dados com base no username informado pelo usuário através do formulário Web. 

O código resultante da implementação inicial deverá ser igual ao código a seguir:

```java
package br.com.carstore.dao;

import br.com.carstore.model.User;

public class UserDao {

    public boolean verifyCredentials(User user) {
        
        return false;
                
    }
    
}
```

4 - Agora vamos começar a implementar nossa lógica. O primeira parte consiste no script SQL que deverá ser executado. Esse script fará uma consulta no banco de dados a partir de um parâmetro informado em tela. Caso existam registros no banco que contenham o valor informado, esses valores serão retornados em um **resultSet**.

O script será o seguinte: 

```sql
SELECT * FROM USR WHERE USERNAME = ?
```

O restante das implementações será semelhante a implementação existente em todos os outros métodos implementados anteriormente, portando podemos copiar e colar. A diferença esta apenas em uma validação condicional de vamos fazer dentro do bloco **while**. Caso exista um username cadastrado no banco de dados igual (equals) ao informado, é feito a validação da senha. Se a senha estiver correta, será retornado (return) true. Caso contrário será retornado false.

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.dao;

import br.com.carstore.model.User;

import java.sql.*;

public class UserDao {

    public boolean verifyCredentials(User user) {

        String SQL = "SELECT * FROM USR WHERE USERNAME = ?";

        try {

            Connection connection = ConnectionPoolConfig.getConnection();

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            preparedStatement.setString(1, user.getUsername());
            ResultSet resultSet = preparedStatement.executeQuery();

            System.out.println("success in select username");

            while (resultSet.next()) {

                String password = resultSet.getString("password");

                if (password.equals(user.getPassword())) {

                    return true;

                }

            }

            connection.close();

            return false;

        } catch (Exception e) {

            System.out.println("Error: " + e.getMessage());

            return false;

        }

    }

}

```
---

## Tarefa 3: Criando a Servlet responsável por capturar as credenciais de login

1 - Agora com a tabela **USR** criada no banco de dados e a classe DAO devidamente criada, podemos implementar a classe Servlet que receberá as requisições HTTP com as informações de login (username e password).

2 - O primeiro paço é criar a classe User. Para isso, No IntelliJ o pacote *(package)* model que fica no diretório: car-store-guide/app/src/main/java/br.com.carstore.servlet, clique com o botão direito do mouse e selecione a opção New / Java Class e digite o nome **LoginServlet** e pressione a tecla **ENTER**.

Nessa servlet, nós iremos sobrescrever o método **doGet** e **doPost**. 

O método doGet ao receber uma requisição, irá redirecionar a requisição para a página *login.jsp*. Esta página será criada a seguir.

O método **doPost** terá uma implementação mais robusta. Ao receber uma requisição, ele irá capturar (getParameter) o **username** e a **password** que o usuário digitou no formulário HTML.

Após capturar os dados, um novo objeto do tipo **User** é criado, os dados são passados para esse objeto via construtor. Na sequência uma nova instância de UserDao é criada e o método **verifyCredentials()** é invocado e passamos o objeto user que acabamos de criar como parâmetro. Essa chamada terá como retorno um **boolean**. Esse retorno é armazenado em uma variável chamada **isValidUser** que será utilizada a seguir.

3 - Validar se o login é válido ou não. Com a variável **isValidUser** nós podemos fazer uma validação condicional (if ...), caso o valor do boolean seja true, significa que as credenciais informadas são válidas e portando podemos iniciar a sessão do nosso usuário. Se o valor for falso significa que as credenciais não são válidas e portando redirecionamos o usuário para a página de login novamente com uma mensagem informativa.

No caso de credencial válida, nós adicionamos uma variável a sessão chamada **loggedUser**, conforme código a seguir.

```java
req.getSession().setAttribute("loggedUser", username);
```

E depois redirecionamos o usuário para nossa roda find-all-carls, conforme código a seguir:

```java
resp.sendRedirect("find-all-cars");
```

Após toda implementação ter sido feia, o código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import br.com.carstore.dao.UserDao;
import br.com.carstore.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("login.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = new User(username, password);

        boolean isValidUser = new UserDao().verifyCredentials(user);

        if (isValidUser) {

            req.getSession().setAttribute("loggedUser", username);

            resp.sendRedirect("find-all-cars");

        } else {

            req.setAttribute("message", "Invalid credentials!");

            req.getRequestDispatcher("login.jsp").forward(req, resp);

        }

    }
    
}

```
---

## Tarefa 4: Criando a Servlet responsável pela operação de logout

1 - Com a servlet de login pronta, devemos criar uma servlet responsável pelo processo de logout (sair). Ela receberá requisições na rota ("/logout").

No IntelliJ o pacote *(package)* model que fica no diretório: car-store-guide/app/src/main/java/br.com.carstore.servlet, clique com o botão direito do mouse e selecione a opção New / Java Class e digite o nome **LogoutServlet** e pressione a tecla **ENTER**.

Nessa servlet, nós iremos sobrescrever apenas o método **doGet**.

O método **doGet** ao receber uma requisição, apenas faz a invalidação da sessão e redireciona o usuário para a tela de login novamente.

2 - resultado final deverá ser igual ao código a seguir:

```java
package br.com.carstore.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getSession().invalidate();

        req.setAttribute("message", "Success on logout");

        req.getRequestDispatcher("login.jsp").forward(req, resp);

    }

}
```

## Tarefa 5: Criando o Filter (filtro) responsável por verificar se o usuário está autenticado ou não

1 - Nossa implementação da funcionalidade de login esta quase pronta. Agora precisamos implementar o filtro (Filter) que vai filtrar todas as requisições para verificar se o usuário está autenticado ou não. 

Para isso, remos criar um novo pacote chamado filter. No IntelliJ navegue até o pacote *(package)* principal que fica no diretório: car-store-guide/app/src/main/java/br.com.carstore, clique com o botão direito do mouse e selecione a opção New / Package e digite o nome **filter** e pressione a tecla **ENTER**.

2 - Com o pacote filter criado, vamos criar a nossa classe que chamaremos de **AuthenticationFilter**. Para isso, no IntelliJ clique com o botão direito do mouse no pacote filter que acabamos de criar, e selecione a opção New / Java Class e digite o nome **AuthenticationFilter** e pressione a tecla **ENTER**.

A classe AuthenticationFilter implementar a interface **Filter** do pacote *javax.servlet.annotation.WebFilter*. Como estamos implementando a interface Filter, nós precisamos implementar sobrescrever três métodos, sendo eles: **init()**, **doFilter()** e **destroy()**.

3 - A lógica para o método doFilter é relativamente simples. A cada requisição filtrada, nós iremos fazer uma validação condiciona que verifica se o usuário está autenticado ou não. Se estiver autenticado, deixaremos a requisição passar sem nenhuma alteração. Se não estiver autenticado, redirecionamos a requisição para a página de login novamente com uma mensagem informado que o usuário não esta autenticado.

Após toda a implementação, o código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter({"/admin/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) { }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;

        if (isUserLoggedOn(httpServletRequest)) {

            servletRequest.setAttribute("message", "User not authenticated!");

            servletRequest.getRequestDispatcher("/login.jsp").forward(httpServletRequest, servletResponse);

        } else {

            chain.doFilter(servletRequest, servletResponse);

        }

    }

    @Override
    public void destroy() { }

    private boolean isUserLoggedOn(HttpServletRequest httpServletRequest) {

        return  httpServletRequest.getSession().getAttribute("loggedUser") == null;

    }

}

```
4 - Repare que a nossa **AuthenticationFilter**, na anotação **@WebFilter**, definimos um padrão "/admin/*". Isso significa que todas as requisições para o **path** admin serão filtradas. Todas as outras requisições não serão filtradas.

Esse comportamento é dado porque a apenas área administrativa do sistema é protegida. Já a área de visitante não é protegida. Portanto, as suas requisições não precisam ser filtradas.

5 - Faça uma revisão tudo que foi feito até aqui!

---

## Tarefa 6: Criando a página HTML responsável por capturar as credenciais de login

1 - Com a DAO, Servlet e Filter de login devidamente criadas, chegou o momento de criar a página (jsp) de login.

No IntelliJ navegue até a pasta **webapp*, fica no diretório: car-store-guide/app/src/main/webapp, clique com o botão direito do mouse e selecione a opção New / File e digite o nome **login.jsp** e pressione a tecla **ENTER**.

Com o arquivo login.jso Criado, cole o conteúdo abaixo:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

<form action="/login" method="post">

    <span>${requestScope.message}</span>

    <br>
    
    <label for="username">Username</label>
    <input type="text" id="username" name="username">

    <br>

    <label for="password">Password</label>
    <input type="password" id="password" name="password">

    <button type="submit">Login</button>

</form>

</body>
</html>
```
Essa é uma página simples que contém um formulário (form), dois campos **input**, onde será informado o usuário e a senha (username e password) e um botão (button) que faz a submissão da requisição para o **path** /login.

---

## Tarefa 7: Refatorando a página dashboard.jsp

Se todas as orientações foram executadas com sucesso, toda a implementação de login foi realizada com sucesso. Agora precisamos refatorar a nossa **dashboard.jsp** e a servlet **ListCarServlet**.

Essa refatoração é necessária porque as operações de cadastro, atualização de deleção só pode ser executada por um utilizador devidamente autenticado. Utilizadores não autenticados apenas podem consultar os dados cadastrados. Dessa forma, os botões de delete e update precisam ser ocultados caso o utilizador não esteja autenticado.

1 - No IntelliJ, navegue até o diretório car-store-guide/app/src/main/webapp, e abra a página **dashbord.jsp**, troca a implementação original:

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
  </div>
</body>
</html>
```

Por

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

    <c:if test="${sessionScope.loggedUser != null}">
        <span>${sessionScope.loggedUser}</span>
        <a href="/logout">Logout</a>
    </c:if>

    <h1>Cars</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <c:if test="${sessionScope.loggedUser != null}">
                <th>Actions</th>
            </c:if>
        </tr>
        <c:forEach var="car" items="${cars}">
            <tr>
                <td>${car.id}</td>
                <td>${car.name}</td>
                <td>
                    <c:if test="${sessionScope.loggedUser != null}">
                        <form action="/delete-car" method="post">
                            <input type="hidden" id="id" name="id" value="${car.id}">
                            <button type="submit">Delete</button>
                            <span> | </span>
                            <a href="index.jsp?id=${car.id}&name=${car.name}">Update</a>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
  </div>
</body>
</html>
```

2 - Repare que agora temos uma validação condiciona na linha 21 e na linha 30. Essa validação condicional utiliza a variável **loggedUser** que colocamos na sessão no momento do login. Essa variável não deve ser nula (null) caso o utilizador esteja autenticado, e dessa forma os campos envolvidos dentro da validação condicional devem ser renderizados no **DOM (Document Object Model)** no browser. Caso a variável seja null, significa que o utilizador não esta autenficado e portando esses campos não serão renderizados. 

3 - O último paço é ajustar a classe **ListCarServlet**, adicionando um novo mapeamento na anotação @WebServlet.

Para isso, No IntelliJ, navegue até o package servlet que fica no diretório car-store-guide/app/src/main/br.com.carstore.servlet, e abra a classe **ListCarServlet.java**.

Altere o mapeamento da anotação @WebServlet:

**DE**
```java
@WebServlet("/find-all-cars")
```

**PARA**
```java
@WebServlet({"/find-all-cars", "/admin/find-all-cars"})
```

4 - Faça uma revisão tudo que foi feito até aqui garantido assim que todas as etapas foram executadas.

5 - Salve todas as alterações **(CTRL + S)** e execute sua aplicação (tomcat7:run).

Acesse sua aplicação através do link http://localhost:8080 e faça o cadastro de um carro. Repare que a página que é exibida não é mais a página de cadastro e sim a página de login. Esse e o comportamento esperado, porque a página padrão agora é a página **login.jsp**. Para acessar a página **dashboard.jsp** as cre devem ser informadas. 

OBS: Atenção nesse ponto, pois você deve digitar as mesmas credenciais (username e password) que você incluiu no banco (INSERT) no paço 4. Caso contrário você irá receber um feedback de usuário ou senha inválidos.

Após digitar as credenciais corretamente você será redirecionado para a página dashboard.jsp.

Caso você não queira informar as credenciais, você pode acessar diretamente a página dashboard.jso através da URL: http://localhost:8080/find-all-cars. A página será renderizada corretamente, porém os botões de **delete** e **update** não devem aparecer.

---

Parabéns! :+1:

Você implementou a funcionalidade de login e as requisições para a área protegida ("/admin") são filtradas verificando se os utilizadores estão autenticados.

Voltar para [LABORATÓRIO 6](./LABORATORIO-6.md) *ou* ir para LABORATÓRIO 8
