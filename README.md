# Laboratório - Criando uma Aplicação Web com Java

## Visão geral e objetivos do laboratório

Este laboratório apresenta os conceitos básicos para criar uma aplicação Web utilizando Java.

Depois de concluir este laboratório, você deverá ser capaz de:

- Criar uma aplicação Web com Java
- Subir um servidor Tomcat (Servlet Container) Embed para executar sua aplicação Java
- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet

## Tarefa 1: Criar uma aplicação Java utilizando o IntelliJ

1) Garanta que você possui o IntelliJ Instalado em seu computador. Caso não tenha faça a instalação conforme demonstrado nesse vídeo: [Instalando o IntelliJ no Windows](https://youtu.be/RBxAySum8UU).

![vídeo demonstrando como installar o intellij no windows](/gifs/01-instalando-intellij.gif)

2) Abra o IntelliJ

  OBS: Caso seja a primeira vez que esteja abrindo o IntelliJ na sua maquina, você precisa clicar no *checkbox* para confirmar que leu os termos de uso da ferramenta e depois clicar no botão *continue*.

  Na tela seguinte, você precisa escolher se deseja compartilhar o uso dos seus dados de forma anônima. Sugiro que selecione não, clicando em *Don't Send*.

  Se não for a primeira vez que você esteja usando o IntelliJ nesse computador, você pode desconsiderar esse trecho.

3) Depois que o IntelliJ estiver aberto, na tela de boas vindas (welcome), cliquei no menu *Projects* e depois clique no botão *New Project*.

4) Na tela do assistente de novos projetos, clique em **Maven Archetype**, nesta seção, configure:

- **Name**: carsoft
- **Location**: Mantenha o valor padrão
- **JDK**: Escolha a JDK instalada no menu suspenso
  OBS: Caso não tenha nenhuma JDK Instalada, ciente em *Download JDK* no menu suspenso, selecione a versão 11 no campo version e depois clique no botão *Download*.
- **Catalog**: Mantenha o valor padrão
- **Archetype**: maven-archetype-webapp

  Na seção **Advanced Settings**, configure:
  - GroupId: br.com.carsoft
  - ArtifactId: carsoft
  - Version: 1.0-SNAPSHOT


5) Clique no botão *Create*

![víde demonstrando como criar um novo projeto usando o archetype web](/gifs/02-criando-o-projeto.gif)

Depois disso basta aguardar toda a etapa de carregamento ser finalizada e sua aplicação estará pronta.

OBS: O processo de carregamento pode demorar alguns minutos, você deve aguardar toda a etapa de carregamento ser finalizada.

6) Revise tudo que foi criado até aqui!

Parabéns! :+1:

Você criou uma nova aplicação Web utilizando Java com Maven, com base em um Archetype Web.


## Tarefa 2: Adicionar o Tomcat plugin e o Maven War Plugin

Agora que você já tem sua aplicação devidamente criada, chegou a hora de adicionar o plugin do Tomcat (Servlet Container), para que você possa executar sua aplicação Web em um servidor sem esforços adicionais.

1) Com a aplicação criada, abra o arquivo *pom.xml*

2) O arquivo pom.xml é o arquivo utilizando pelo Maven para o processo de construção e empacotamento de uma aplicação Java. O arquivo pom.xml é composto por diferentes seções. Encontre a seção *build*. Dentro da seção build, adicione o bloco de código a seguir:

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
![vídeo demonstrando como adicionar o plugin do tomcat](/gifs/03-adicioando-o-plugin-do-tomcat.gif)

3) Adicione um segundo plugin dentro do bloco *plugins*, conforme código a seguir:

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
![vídeo demonstrando como adicionar o plugin do maven-war](/gifs/04-adicioando-o-plugin-do-maven.gif)

4) O resultado final conterá a seguinte ficará da seguinte forma, conforme código a seguir:

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

5) Feito isso, já é possível executar sua aplicação e ver sua primeira página web. Para isso, navegue até o menu Maven, expanda o projeto *carstore*, *plugins*, *tomcat7* e clique duas vezes na opção *tomcat7:run*

6) Após o processo de carregamento, abra uma aba no seu navegador e digite o endereço: http://localhost:8080

7) Uma página web deverá ser renderizada com a mensagem **Hello, world!**

![vídeo demonstrando como executar o projeto criando](/gifs/05-executando-o-servidor.gif)

8) Revise tudo que foi criado até aqui!

Parabéns! :+1:

Você criou uma nova aplicação Web utilizando Java, Maven e um Archetype Web. Adicionou o plugin do Tomcat Embed e o Plugin de Build do Maven e com isso já possível subir o servidor e renderizar a nossa primeira pagina web (Hello, world!).
