# Laboratório 2 - Adicionando uma camada de persitência na sua Java Web

## Visão geral e objetivos do laboratório

Este laboratório apresenta os conceitos básicos para criar uma aplicação Java Web contendo uma camada de persitêcia de dados!

Depois de concluir este laboratório, você deverá ser capaz de:

- Provisionar uma camada de persitência para sua aplicação Java Web;
- Subir um servidor Tomcat (Servlet Container) e um banco de dados em metória (H2 DB) embed para executar sua aplicação Java e persistir seus dados;
- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet e gravar esses dados no banco de dados.

## Tarefa 1: Adicionar uma nova dependência ao seu projeto

Agora que você já tem sua aplicação devidamente criada, já conseguiu subir seu servidor web, chegou a hora de adicionar uma camada de persistência de dados na sua aplicação. 

1) Abra o arquivo arquivo *pom.xml*

2) Localize o bloco *</dependencies>*. Você deverá adicionar uma nova dependência dentro do bloco *</dependencies>* no **pom.xml** da sua aplicação. 

OBS: Nenhuma dependência deve ser removida nesse processo. Adicione a dependência a seguir dentro do bloco *</dependencies>*: 

```xml
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <version>2.1.214</version>
</dependency>
```

3) O resultado final deve ser igual ao código a seguir:

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

![vídeo demonstrando como adicionar a nova dependência no projeto](/gifs/10.gif)

4) Revise tudo que foi feito até aqui!

Parabéns! :+1:

Você adicionu a dependência do H2 DB (Banco de dados em memória).

## Tarefa 2: Registrando o Servlet listener do H2 DB

Para saber mais sobre o H2 DB, visite a documentação oficial através desse [LINK](https://www.h2database.com)

1) Agora que a dependência do H2 foi adicionada ao projeto, é necessário registrar o listener do H2 no arquivo web.xml. Navegue até o arquivo web.xml que fica no caminho: car-store/src/main/webapp/WEB-INF/web.xml

2) Com o arquivo web.xml aberto, adicione o listener dentro do bloco *web-app* conforme código a seguir:

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

4) Salve tudo (CTRL + S) e execute sua aplicação. Com o listener do H2 devidamente registrado, é possível acessar a console de gerênciamento através do link: http://localhost:8080/console

