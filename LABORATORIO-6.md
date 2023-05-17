### Laboratório 6 — Configurando o pool de conexões

## Visão geral e objetivos do laboratório

Este laboratório tem como objetivo apresentar uma forma básica sobre como configurar um pool de conexões para gerenciar as conexões com o banco de dados!

Um pool de conexões é uma técnica usada para melhorar o desempenho de aplicações que fazem uso frequente de conexões com um banco de dados.

Após concluir este laboratório, você deverá ser capaz de:

- Implementar um pool de conexões utilizando a biblioteca [Apache Commons DBCP](https://github.com/apache/commons-dbcp);

## Tarefa 1: Adicionando a dependência do Apache Commons DBCP

1: Adicionando a dependência

No IntelliJ IDEA, abra o arquivo de configuração do projeto chamado "pom.xml" (geralmente localizado na raiz do projeto).

Localize a seção <dependencies> e adicione a seguinte dependência:

```xml

<dependency>
  <groupId>org.apache.commons</groupId>
  <artifactId>commons-dbcp2</artifactId>
  <version>2.9.0</version>
</dependency>


```
OBS: Nenhum código deve ser removido nesta etapa. Apenas adicione a nova dependência no *pom.xml*.

2: Salve todas as alterações **(CTRL + S)**

OBS: Após salvar as alterações, o IntelliJ IDEA deve sincronizar automaticamente as alterações do arquivo de configuração e baixar a biblioteca Apache Commons DBCP.


## Tarefa 2: Criando a classe para o Pool de Conexões

1: Crie uma classe de configuração para o pool de conexões

No IntelliJ IDEA, navegue até o pacote principal *br.com.carstore.servlet*, clique com o botão direto do mouse e selecione *New / Package* digite **config** e pressione a tecla ENTER.

Após ter criado o pacote *config*, clique com o botão direito do mouse no pacote **config** e selecione *New / Java Class*.

Defina o nome da classe como "ConnectionPoolConfig" e clique em "OK".

2: Abra a classe que acabamos de criar e implemente um método estático (static) chamado *getDataSource* que não recebe nenhum parâmetro e retorna um **BasicDataSource** conforme código a seguir:

```java

import org.apache.commons.dbcp2.BasicDataSource;

public class ConnectionPoolConfig {
    
    private static BasicDataSource dataSource;

    public static BasicDataSource getDataSource() {

    }
    
}
```

OBS: Não esqueça de importar (import) a classe BasicDataSource do pacote *org.apache.commons.dbcp2*. Para realizar o importe utilizando o IntelliJ, clique com o botão direito do mouse em cima do nome da classe e utilize o atalho **(ALT + ENTER)** e selecione a opção **import class**.

3: Agora que já temos nossa classe **BasicDataSource** e nosso método **getDataSource()** devidamente criados, vamos iniciar nossa implementacão. A primeira parte consiste em uma validação condicional que verifica se a variável *dataSource* é nula (null).

O código resultante deverá ser igual ao código a seguir:

```java

package br.com.carstore.config;

import org.apache.commons.dbcp2.BasicDataSource;

public class ConnectionPoolConfig {

    private static BasicDataSource dataSource;
    
    private static BasicDataSource getDataSource() {

        if (dataSource == null) {
            
        }

        return dataSource;

    }
    
}

```

Se o resultado dessa validação condicional for verdadeiro, nós iremos criar um novo *dataSource* (será demonstrado na próxima seção). Caso o retorno seja falso, significa que já existe um dataSource criado e portando nós iremos retornar ele, sem executar nenhuma ação adicional. 

4: Assumindo que o retorno da validação condicional foi verdadeiro (true), nós precisamos criar um novo dataSource. para isso nós iremos criar uma nova instância de **BasicDataSource** e passar alguns parâmetros sendo eles:

* URL
* Username
* Password
* Min Idle
* Max Idle
* Max total

Perceba que alguns desses parâmetros nós já Utilizávamos nas implementações anteriores como (url, username e password). Porém agora estamos adicionando três novos parâmetros sendo eles (Min Idle, Max Idle e Max total).

Esses parâmetros são necessários para que o nosso pool possa ser configurado e eles podem variar de acordo com as características da sua aplicação. 

A seguir, uma breve descrição sobre o papel desses parâmetros:

* MinIdle: Número mínimo de conexões ociosas no pool
* MaxIdle: Número máximo de conexões ociosas no pool
* MaxTotal: Número máximo de conexões totais no pool

Por último, vamos adicionar uma mensagem de feedback para nossos usuários sinalizando que um novo pool de conexões foi criado com sucesso.

O código resultante deverá ser igual ao código a seguir:

```java
package br.com.carstore.config;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionPoolConfig {

    private static BasicDataSource dataSource;

    private static BasicDataSource getDataSource() {

        if (dataSource == null) {
            dataSource = new BasicDataSource();
            dataSource.setUrl("jdbc:h2:~/test");
            dataSource.setUsername("sa");
            dataSource.setPassword("sa");
            dataSource.setMinIdle(5);   // Número mínimo de conexões ociosas no pool
            dataSource.setMaxIdle(10);  // Número máximo de conexões ociosas no pool
            dataSource.setMaxTotal(50); // Número máximo de conexões totais no pool

            System.out.println("New connection pool created with successful");

        }

        return dataSource;

    }

}

```

5: Criando o método getConnection

Agora que já temos o método getDataSource devidamente implementado, precisamos criar o método que devolve as requisições para os usuários.

Para isso, vamos criar um novo método estático (static) chamado getConnection que devolve uma connection.

O código resultante deverá ser igual ao código a seguir:

```java
public static Connection getConnection() throws SQLException {

    return getDataSource().getConnection();

}
```

6: Criando um construtor privado

Agora que já temos o método getDataSource() e getConnection() devidamente criados, precisamos criar um construtor privado que chama o método getDataSource para iniciar um novo pool de conexões assim que nossa classe for chamada pela primeira vez.

O código resultante deverá ser igual ao código a seguir:

```java
private ConnectionPoolConfig() {
    getDataSource();
}
```

Com toda a implementação feita, o código da classe **ConnectionPoolConfig** deverá ser igual ao código a seguir:

```java
package br.com.carstore.config;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionPoolConfig {

    private static BasicDataSource dataSource;

    private ConnectionPoolConfig() {
        getDataSource();
    }

    private static BasicDataSource getDataSource() {

        if (dataSource == null) {
            dataSource = new BasicDataSource();
            dataSource.setUrl("jdbc:h2:~/test");
            dataSource.setUsername("sa");
            dataSource.setPassword("sa");
            dataSource.setMinIdle(5);   // Número mínimo de conexões ociosas no pool
            dataSource.setMaxIdle(10);  // Número máximo de conexões ociosas no pool
            dataSource.setMaxTotal(50); // Número máximo de conexões totais no pool

            System.out.println("New connection pool created with successful");

        }

        return dataSource;

    }

    public static Connection getConnection() throws SQLException {

        return getDataSource().getConnection();

    }

}

```

Salve todas as alterações **(CTRL + S)**

## Tarefa 3: Refatorando (refactor) a classe DAO para usar o pool de conexões

1: Agora que já temos nosso pool de conexões devidamente criado e configurado, chegou a hora de refatorar a classe **CarDAO** para que ela passe a utilizar as conexões fornecidas através do nosso pool de conexões.

Para isso, no IntelliJ IDEA, navegue até o pacote *br.com.carstore.dao* e com dois cliques rápidos (double click) abra a **CarDAO**.

Com a classe CarDAO aberta podemos iniciar nossa refatoração.

2: A classe CarDAO possui diversos métodos, sendo eles:

* createCar()
* findAllCars()
* deleteCarById()
* updateCar()

Todos eles abrem uma nova conexão com o banco de dados o que não é uma boa prática.

OBS: Isso foi feito propositalmente.

Agora com a implementação do nosso connection pool, nenhum método da DAO irá mais criar conexões, ao invés disso, ele irá pedir uma conexão para o nosso pool que por sua vez irá fazer o reaproveitamento de conexões existesntes que estiverem disponíveis e caso não existe, irá criar uma nova conexão.

Dessa forma nós iremos economizar recursos computacionais e como consequência nossa aplicação ficará mais performática.

Dentro de cada método mencionado acima, localize a linha que abre a conexão e faça a substituição:

REMOVA:
  
```java
Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa","sa");
  
System.out.println("success in database connection");
```
  
ADICIONE: 

```java
Connection connection = ConnectionPoolConfig.getConnection();
```

Agora, os métodos não irão abrir mais conexões diretamente e portando não escreverá a mensagem ("success in database connection") porque a abertura de novas conexões agora é responsabilidade da nossa classe **BasicDataSource**.

Estamos aqui implementando o **S** do [SOLID](https://www.freecodecamp.org/news/solid-principles-explained-in-plain-english/).

3: Faça uma revisão tudo que foi feito até aqui!

4: Salve todas as alterações **(CTRL + S)** e execute sua aplicação *(tomcat7:run)*. 

Acesse sua aplicação através do link http://localhost:8080 e faça o cadastro de um carro. Repare que o comportamento da aplicação não mudou, porém a mensagem ("New connection pool created with successful") só é escrita uma vez no *stdout*. Esse é o compartamento esperado porque agora a nossa aplicação reaproveita as conexões que já foram abertas e estão disponíveis sempre que possível e tudo isso é gerenciado pelo nosso pool de conexões.

---

Parabéns! :+1:

Você adicionou um pool de conexões na sua aplicação utilizando a biblioteca **Apache Commons DBCP** e agora sua aplicação gerencia as conexões com o banco de dados de forma eficiente. 

Voltar para: [LABORATÓRIO 5](./LABORATORIO-5.md)

*ou*

Ir para: LABORATÓRIO 7
