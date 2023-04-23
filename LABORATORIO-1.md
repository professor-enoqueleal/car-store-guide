# Laboratório 1 — Criando uma Aplicação Web com Java

## Visão geral e objetivos do laboratório

Este laboratório apresenta os conceitos básicos para criar uma aplicação Web utilizando Java.

Após concluir este laboratório, você deverá ser capaz de:

- Criar uma aplicação Web com Java
- Subir um servidor Tomcat (Servlet Container) Embed para executar sua aplicação Java
- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet

## Tarefa 1 — Criar uma aplicação Java utilizando o IntelliJ

1) Garanta que você possui o IntelliJ instalado no seu computador. Caso não tenha faça a instalação conforme demonstrado nesse vídeo do youtube: [Instalando o IntelliJ no Windows](https://youtu.be/RBxAySum8UU).

![gif animado demonstrando como installar o intellij no windows](/gifs/01-instalando-intellij.gif)

2) Abra o IntelliJ

  OBS: Caso seja a primeira vez que esteja abrindo o IntelliJ na sua máquina, você precisa clicar no *checkbox* para confirmar que leu os termos de uso da ferramenta e depois clicar no botão *continue*.

  Na tela seguinte, você precisa escolher se deseja compartilhar o uso dos seus dados de forma anônima. Clique em *Don't Send*.

  Caso não seja a primeira vez que você esteja usando o IntelliJ nesse computador, desconsidere essa informação.

3) Depois que o IntelliJ estiver aberto, na tela de boas vindas (welcome), clique no menu *Projects* e depois clique no botão *New Project*.

4) Na tela do assistente de novos projetos, clique em **Maven Archetype**, nesta seção, configure:

  - **Name**: carstore
  - **Location**: Mantenha o valor padrão
  - **JDK**: Escolha a JDK instalada no menu suspenso
    OBS: Caso não tenha nenhuma JDK Instalada, clique em *Download JDK* e no menu suspenso, selecione a versão 11 no campo version e depois clique no botão *Download*.
  - **Catalog**: Mantenha o valor padrão
  - **Archetype**: maven-archetype-webapp

  Na seção **Advanced Settings**, configure:
  - **GroupId**: br.com.carstore
  - **ArtifactId**: carstore
  - **Version**: 1.0-SNAPSHOT


5) Clique no botão *Create*

![gif animado demonstrando como criar um novo projeto usando um archetype maven para projeto web](/gifs/02-criando-o-projeto.gif)

Depois disso basta aguardar toda a etapa de carregamento ser finalizada. No final sua aplicação estará pronta.

OBS: O processo de carregamento pode demorar alguns minutos, é imprescindível aguardar toda a etapa de carregamento ser finalizada.

6) Faça uma revisão tudo que foi feito até aqui!

Parabéns! :+1:

Agora temos uma nova aplicação Web criada utilizando Java e Maven, com base em um Archetype Web.

---

## Tarefa 2 — Adicionar o Tomcat plugin e o Maven War Plugin

Agora que temos a aplicação devidamente criada, chegou a hora de adicionar o plugin do Tomcat (Servlet Container). Dessa forma será possível executar a aplicação Web no servidor Tomcat sem esforços adicionais.

1) Com a aplicação criada, abra o arquivo *pom.xml*

2) O arquivo pom.xml é o arquivo utilizando pelo Maven para o processo de construção e empacotamento de uma aplicação Java. Este arquivo é composto por diferentes seções. Encontre a seção *<build>*. Dentro dessa seção, adicione o bloco de código a seguir.

OBS: Nenhum código deve ser removido nessa etapa. Apenas adicione o código a seguir dentro do bloco *<build>*:

```xml
<plugins>
  <plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.1</version>
    <configuration>
      <path>/</path>
    </configuration>
    <executions>
      <execution>
        <id>tomcat-run</id>
        <goals>
          <goal>exec-war</goal>
        </goals>
        <phase>package</phase>
        <configuration>
            <enableNaming>false</enableNaming>
        </configuration>
      </execution>
    </executions>
  </plugin>
</plugins>
```
![gif animado demonstrando como adicionar o plugin do tomcat](/gifs/03-adicioando-o-plugin-do-tomcat.gif)

3) Adicione um segundo plugin dentro do bloco *plugins* que foi criado na etapa anterior, conforme código a seguir:

```xml
<plugin>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.2.2</version>
    <configuration>
        <webXml>src\main\webapp\WEB-INF\web.xml</webXml>
        <warSourceDirectory>src/main/webapp</warSourceDirectory>
    </configuration>
</plugin>
```
![gif animado demonstrando como adicionar o plugin do maven-war](/gifs/04-adicioando-o-plugin-do-maven.gif)

4) O código resultante deverá ser igual ao código a seguir:

```xml
<plugins>
  <plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.1</version>
    <configuration>
      <path>/</path>
    </configuration>
    <executions>
      <execution>
        <id>tomcat-run</id>
        <goals>
          <goal>exec-war</goal>
        </goals>
        <phase>package</phase>
        <configuration>
            <enableNaming>false</enableNaming>
        </configuration>
      </execution>
    </executions>
  </plugin>
  <plugin>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.2.2</version>
    <configuration>
        <webXml>src\main\webapp\WEB-INF\web.xml</webXml>
        <warSourceDirectory>src/main/webapp</warSourceDirectory>
    </configuration>
  </plugin>
</plugins>
```

5) Salve todas as alterações **(CTRL + S)** e depois clique no botão *Load Maven Changes*. Com isso, o Maven irá identificar que novos *plugins* foram adicionados no projeto e irá fazer o download dos mesmos de forma automática. Aguarde o carregamento finalizar.

6) Feito isso, já é possível executar a aplicação e renderizar sua primeira página web no browser. Para isso, navegue até o menu Maven dentro do IntelliJ, expanda o projeto *carstore*, depois clique em *plugins*, depois clique em *tomcat7* e por último clique duas vezes na opção *tomcat7:run*. Fazendo isso o servidor web (Servlet Container) será ligado (start).

7) Após o processo de carregamento, abra uma aba no seu browser e digite o endereço a seguir: http://localhost:8080

8) Uma página web deverá ser renderizada contendo a mensagem **Hello, world!**

![gif animado demonstrando como executar o projeto que foi criando](/gifs/05-executando-o-servidor.gif)

9) Faça uma revisão tudo que foi feito até aqui!

Parabéns! :+1:

Você criou uma nova aplicação Web utilizando **Java**, **Maven** e um **Archetype** Web. Adicionou o plugin do *Tomcat Embed* e o Plugin de *Build* do Maven. Com isso já é possível subir o servidor e renderizar a nossa primeira pagina web **(Hello, world!)**.

---

## Tarefa 3 — Criando sua primeira Servlet e fazendo uma requisição *http*

Agora que você já tem sua aplicação devidamente criada, já conseguiu subir seu servidor web, chegou a hora de criar sua primeira Servlet e fazer sua primeira requisição **http**

1) Abra novamente o arquivo arquivo *pom.xml*

2) Localize o bloco *</dependencies>*. Você deverá adicionar duas dependências dentro do bloco *</dependencies>* no **pom.xml** da sua aplicação, conforme o código a seguir.


OBS: Nenhum código deve ser removido nessa etapa. Apenas adicione o código a seguir dentro do bloco *<dependencies>*:

```xml
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
```
![gif animado demonstrando como adicionar as dependência no pom.xml do projeto](/gifs/06-adicionando-dependencias.gif)

3) Salve todas as alterações **(CTRL + S)** e depois clique no botão *Load Maven Changes*. Com isso, o Maven irá identificar que duas novas *dependências* foram adicionadas ao seu projeto e irá fazer o download das mesmas de forma automática para você. Aguarde o carregamento finalizar.

4) Depois que o carregamento / download das novas *dependências* finalizar, volte para a aba *Project* e navegue no seu projeto clicando na pasta *carstore*, *src* e depois em *main*. Clique com o botão direto em cima da pasta *main* e escolha a opção *New* e depois *Directory*. O assistente de criação de novos diretórios será aberto, selecione a opção **Java**.

5) Após o diretório **Java** ter sido criado, vamos criar um pacote (*package*) para que possamos criar nossa primeira classe **Java**. Para isso clique com o botão direto em cima do diretório Java, escolha a opção *New* e depois a opção *Package*, no assistente criação digite: *br.com.carstore.servlet*. Esse será o pacote padrão da nossa aplicação.

![gif animado demonstrando como criar o diretório java o e package br.com.carstore](/gifs/07-criando-diretorio-java-e-package.gif)

6) Agora vamos criar nossa primeira (Servlet) classe Java. Clique com o botão direto em cima do package que acabamos de criar (*br.com.carstore.servlet*), selecione a opção *New* e depois a opção *Java Class*. No assistente de criação, digite o nome da classe: **CreateCarServlet**

7) Agora com sua primeira *servlet* devidamente criada, é necessário adicionar a anotação *@WebServlet*. Essa anotação deverá ficar uma linha acima de onde o nome da classe **CreateCarServlet** está declarado, depois adicione a extensão (extends) para a classe HttpServlet. O código resultante deverá ficar igual ao código a seguir:

```java
package br.com.carstore.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

}
```
![gif animado demonstrando como criar a classe create car servlet e adicionar a anotação @ web servlet](/gifs/08-criando-servlet.gif)

8) O Próximo passo é sobrescrever (Override) o método doPost(). Este é o método que vai receber as requisições *http* feitas com o método *POST* através do formulário *HTML*.

Para sobrescrever o método *doPost()*, basta digitar *doPost* e depois usar as teclas de atalho (CTRL + barra de espaço) dentro da declaração da sua classe. O auto complete colocará uma sugestão, basta apertar a tecla enter que o método será sobrescrito. O código resultante deverá ficar igual ao código a seguir:

```java
package br.com.carstore.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        super.doPost(request, response);

    }

}
```
![gif animado demonstrando como sobrescrever o método doPost](/gifs/09-override-dopost.gif)

9) Após ter sobrescrito o método doPost, vamos implementar a chamada para o req.getParameter("car-name"). É dessa forma que pegamos as informações que serão enviadas através do formulário html. 

Dentro do método doPost(), apague a linha **super.doPost(req, resp)** e na sequência implemente o seguinte código:

```java
String carName = request.getParameter("car-name");

System.out.println(carName);

request.getRequestDispatcher("index.html").forward(request, response);
```

O código completo deverá ficar igual ao código a seguir:

```java
package br.com.carstore.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/create-car")
public class CreateCarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String carName = request.getParameter("car-name");

        System.out.println(carName);

        request.getRequestDispatcher("index.html").forward(request, response);

    }

}
```
![gif animado demonstrando como implementar a chamada para o método getParameter](/gifs/10-implementando-get-parameter.gif)

10) O último passo será a implementação do formulário HTML. Esse formulário deverá conter três elementos. Um *label* contendo o nome do campo, um *input* para que o usuário possa escrever o valor no formato texto e um *button* para que o usuário possa clicar e submeter (submit) a requisição *http* para o servidor.

No seu projeto, navegue até o diretório: car-store-guide/app/src/main/webapp/index.html

A implementação do formulário deverá ser igual ao código a seguir:

```html
<html>
<body>
<h2>Create Car</h2>

<form action="/create-car" method="post">

    <label>Car Name</label>
    <input type="text" name="car-name" id="car-name">

    <button type="submit">Register</button>

</form>

</body>
</html>
```

11) Faça uma revisão tudo que foi feito até aqui!

---

Parabéns! :+1:

Você criou uma nova aplicação Web utilizando **Java**, **Maven** e um **Archetype** Web. Adicionou o plugin do *Tomcat Embed* e o Plugin de *Build* do Maven. Criou sua primeira Servlet e sobrescreveu o método doPost, preparando ele para receber um atributo que você receberá no Java quando o seu formulário html for submetido. Depois você criou um formulário html contento um campo input text para que o usuário possa fazer a requisiçãp. Com isso já é possível subir o servidor e renderizar a nossa primeira página web, fazer a primeira requisição e recuperar o valor enviado na sua Java Servlet.

Ir para: [LABORATÓRIO 2](./LABORATORIO-2.md)
