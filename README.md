# Laboratório - Criando uma Aplicação Web com Java

## Visão geral e objetivos do laboratório

Este laboratório apresenta os conceitos básicos para criar uma aplicação Web utilizando Java.

Depois de concluir este laboratório, você deverá ser capaz de:

- Criar uma aplicação Web com Java
- Subir um servidor Tomcat (Servlet Container) Embed para executar sua aplicação Java
- Fazer requisições através de um formulário HTML e capturar essa requisição em uma Servlet

## Tarefa 1: Criar uma aplicação Java utilizando o IntelliJ

1) Garanta que você possui o IntelliJ Instalado na sua maquina. Caso não tenha faça a instalação conforme demonstrado nesse vídeo: [Instalando o IntelliJ no Windows](https://youtu.be/RBxAySum8UU).

2) Abra o IntelliJ

OBS: Caso seja a primeira vez que esteja abrindo o IntelliJ na sua maquina, você precisa clicar no *checkbox* para confirmar que leu os termos de uso da ferramenta e clicar em *continue*.

Na tela seguinte, você precisa escolher se deseja compartilhar os dados de uso de forma anônima ou não, clique em *Don't Send*.

Caso contrário, você pode desconsiderar esse trecho.

3) Depois que o IntelliJ estiver aberto, na tela de boas vindas, cliquei no menu *Projects* e depois no botão *New Project*. 

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

Depois disso basta aguardar toda a etapa de carregamento ser finalizada e sua aplicação estará pronta.

OBS: O processo de carregamento pode demorar alguns minutos caso seja a primeira vez que você esteja executando esse processo.

6) Revise tudo que foi criado até aqui!

Parabéns! :+1: 

Você criou uma nova aplicação Web utilizando Java, Maven e um Archetype Web. Com isso já podemos avançar para próxima etapa.
