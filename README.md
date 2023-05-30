# Car Store Guide 

Este guia (Guide) tem como objetivo ajudar os alunos do *Projeto Integrador III* a criarem uma aplicação Web utilizando **Java**, **Maven** e um bando de dados em memória **H2 DB** através de laboratórios auto guiados.

## Laboratórios auto guiados

Os laboratórios consistem em um guia passo a passo sobre como criar uma aplicação Java Web, adicionar as depedências e plugins que serão utilizado durante o desenvolvimento do projeto.

Os laboratórios serão organizados por numeros e devem ser executado de forma sequêncial. É extremamente importante a execução de forma sequencial para evitar erros.

Os laboratórios disponíveis até o momento são: 

### Laboratório 1 — Criando uma Aplicação Web com Java
- [LABORATÓRIO 1](./LABORATORIO-1.md)

Este laboratório apresenta os conceitos básicos para criar uma aplicação Web utilizando Java.

Após concluir este laboratório, você deverá ser capaz de:

- Criar uma aplicação Web com Java
- Subir um servidor Tomcat (Servlet Container) Embed para executar sua aplicação Java
- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet


### Laboratório 2 — Adicionando uma camada de persistência na sua Java Web
- [LABORATÓRIO 2](./LABORATORIO-2.md)

Este laboratório apresenta os conceitos básicos para criar uma aplicação Java Web contendo uma camada de persitêcia de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Provisionar uma camada de persistência para a aplicação Java Web;
- Subir um servidor Tomcat (Servlet Container) e um banco de dados em memória (H2 DB) embed para executar sua aplicação Java e persistir seus dados;
- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Gravar os dados que foram capturados de um formulário HTML e persisti-los em um banco de dados (insert).

### Laboratório 3 — Criando o método para buscar os dados no Banco de Dados
- [LABORATÓRIO 3](./LABORATORIO-3.md)

Este laboratório apresenta as ações básicas criar uma camada de consulta na camada de persitêcia de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Consultar os dados que foram persistido no banco de dados (select * from car) e exibir os dados em um formulário HTML.


### Laboratório 4 — Criando o método para deletar dados no Banco de Dados
- [LABORATÓRIO 4](./LABORATORIO-4.md)

Este laboratório tem como objetivo apresentar uma forma básica sobre como deletar dados em uma tabela no banco de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Deletar / remover dados que foram persistidos no banco de dados (delete car where id = ?).


### Laboratório 5 — Criando o método para atualizar dados no Banco de Dados
- [LABORATÓRIO 5](./LABORATORIO-5.md)

Este laboratório tem como objetivo apresentar uma forma básica sobre como atualizar dados em uma tabela no banco de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Atualizar dados que foram persistidos no banco de dados (update ... where id = ?).

### Laboratório 6 — Configurando o pool de conexões
- [LABORATÓRIO 6](./LABORATORIO-6.md)

Este laboratório tem como objetivo apresentar uma forma básica sobre como configurar um pool de conexões para gerenciar as conexões com o banco de dados!

Após concluir este laboratório, você deverá ser capaz de:

- Implementar um pool de conexões utilizando a biblioteca [Apache Commons DBCP](https://github.com/apache/commons-dbcp);

### Laboratório 7 — Criando a a funcionalidade de login
- [LABORATÓRIO 7](./LABORATORIO-7.md)

Este laboratório tem como objetivo apresentar uma forma básica sobre como implementar uma funcionalidade de login utilizando usuário e senha.

Após concluir este laboratório, você deverá ser capaz de:

- Fazer requisições http através de um formulário HTML e capturar os dados dessa requisição em uma Servlet;
- Criar uma tabela no banco de dados para armazenar as credencias de login (username e password);
- Criar uma classe DAO (Data Access Object) para verificação das credencias de login;
- Implementar um formulário HTML para capturar as credenciais de login;
- Implementar um Filter para verificar se o usuário esta logado a cada requisição;

