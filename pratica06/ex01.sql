-- BD – EXERCÍCIOS – PRÁTICA 06
/*1. Fazer a modelagem lógica de um sistema para cadastrar os alunos da
faculdade, seus projetos e seus acompanhantes que eles poderão
trazer no dia da apresentação final do projeto. */
-- Cada aluno participa apenas de um projeto.
-- Cada projeto pode ter a participação de um ou mais alunos.
-- Cada aluno pode trazer zero ou mais acompanhantes.
-- Há alguns alunos que atuam como representantes de outros alunos.
-- Qualquer problema ou queixa que os alunos tiverem, devem falar com o
-- aluno que os representa. O aluno representante, por sua vez, reporta os
-- problemas/queixas à equipe de socioemocional.
-- Cada aluno é representado apenas por um aluno.
-- Sobre os alunos, o sistema guarda o ra (chave primária), nome, telefone.
-- Sobre os projetos, o sistema guarda um identificador (chave primária),
-- nome e a descrição do projeto.
-- Sobre os acompanhantes, o sistema guarda um identificador, nome e o
-- tipo de relação com o aluno (se é pai, amigo, irmão, namorado, etc).
-- Criar um banco de dados AlunoProjeto no MySQL, selecionar esse
-- banco de dados e executar as instruções relacionadas a seguir.
create database AlunoProjeto;
use AlunoProjeto;
-- Criar as tabelas equivalentes à modelagem.
create table projeto(
id int primary key auto_increment,
nome varchar(30),
descricao varchar(40)
);
create table aluno(

);
- Inserir dados nas tabelas.
- Exibir todos os dados de cada tabela criada, separadamente.
- Fazer os acertos da chave estrangeira, caso não tenha feito no momento
da criação.
- Exibir os dados dos alunos e dos projetos correspondentes.
- Exibir os dados dos alunos e dos seus acompanhantes.
- Exibir os dados dos alunos e dos seus representantes.
- Exibir os dados dos alunos e dos projetos correspondentes, mas somente
de um determinado projeto (indicar o nome do projeto na consulta).
- Exibir os dados dos alunos, dos projetos correspondentes e dos seus
acompanhantes.