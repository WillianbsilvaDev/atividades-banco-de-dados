create database sprint2;
-- 1. No MySQL Workbench, utilizando o banco de dados ‘sprint2’:
use sprint2;
-- Fazer a modelagem lógica e física conforme a regra de negócio:
/*• 1 professor leciona 1 ou muitas disciplinas;
• 1 disciplina é lecionada por apenas 1 professor; */
-- Criar a tabela chamada Professor para conter os dados: idProfessor, nome
-- (tamanho 50), sobrenome (tamanho 30), especialidade1 (tamanho 40),
-- especialidade2 (tamanho 40), sendo que idProfessor é a chave primária da tabela.
create table professor(
idProfessor int primary key auto_increment,
nome varchar(50),
sobrenome varchar(30),
especialidade1 varchar(30),
especialidade2 varchar(40)
);



-- Inserir pelo menos uns 6 professores.
insert into professor(nome, sobrenome, especialidade1,especialidade2) values
('Marcelo', 'Rosin', 'Banco de dados', 'Sistemas Operacionais'),
('Fernando', 'Brandão', 'Projeto Inovação', 'Socio Emocional'),
('Marcio', 'marcin', 'Sistema operacionais', 'Tecnico Informatica'),
('reginaldo', 'Rossi', 'Algoritmo', 'Sistemas operacionais'),
('Matheus', 'rubens', 'Arquitetura Computacional', 'Calculo'),
('Ednaldo', 'Pereira', 'Banco de dados', 'Socio emocional');


/*Criar a tabela chamada Disciplina para conter os dados: idDisc, nomeDisc
(tamanho 45), sendo que idDisc é a chave primária da tabela. */
create table Disciplina(
idDisc int primary key auto_increment,
nomeDisc varchar(45)
);

/*Inserir pelo menos 3 disciplinas. */
insert into Disciplina(nomeDisc) values
('Arquitetura Computacional'),
('Calculo'),
('Socio emocional');


-- Escreva e execute os comandos para:
-- • Configurar a chave estrangeira na tabela conforme sua modelagem (Pode
-- fazer no comando CREATE TABLE);
alter table Disciplina add column idProfessorfk int;
alter table Disciplina add constraint disciplinaIDprofessorfk foreign key (idProfessorfk) references professor(idProfessor);

-- • Exibir os professores e suas respectivas disciplinas;
select
 prof.nome as nome_professor,
 prof.sobrenome as sobrenome_professor,
 disc.nomeDisc
 from 
 professor prof
 inner join
 Disciplina disc on prof.idProfessor = disc.idDisc;
 
 DESC Disciplina;
 
-- • Exibir apenas o nome da disciplina e o nome do respectivo professor;
select
prof.nome as nome_professor,
disc.nomeDisc as nome_disciplina
from
professor prof
join
Disciplina disc on prof.idProfessor = disc.idDisc;

/*• Exibir os dados dos professores, suas respectivas disciplinas de um
determinado sobrenome;*/
select
prof.*,
disc.nomeDisc
from professor prof
join Disciplina disc on prof.idProfessor = disc.idDisc
where sobrenome = 'rosin';

/*• Exibir apenas a especialidade1 e o nome da disciplina, de um determinado
professor, ordenado de forma crescente pela especialidade1;*/
select
prof.especialidade1 as nome_especialidade,
disc.nomeDisc as nome_disciplina
from professor prof
join Disciplina disc on prof.idProfessor = disc.idDisc
order by especialidade1 asc;


-- EXERCICIO 2
--  2. No MySQL Workbench, utilizando o banco de dados ‘sprint2’:
use sprint2;

/*Criar a tabela chamada Curso para conter os dados: idCurso, nome (tamanho 50),
sigla (tamanho 3), coordenador, sendo que idCurso é a chave primária da tabela. */
create table Curso(
idCurso int,
nome varchar(50),
sigle varchar(3),
coordenador varchar(40),
primary key (idCurso)
 );

-- Inserir dados na tabela, procure inserir pelo menos 3 cursos.
insert into Curso(nome, sigla, coordenador)values
('Analise e desenvolvimento de sistemas', 'ADS', 'Vera'),
('Ciência da computação', 'CCO', 'Cintia'),
('Sistema da informação', 'SIS', 'Fernando');
alter table Curso modify column idCurso int auto_increment ; -- facilitando a vida com auto_increment
alter table Curso rename column sigle to sigla; -- declarei o nome errado, então corrigi aqui professor

/*Crie uma regra de negócio com uma nova tabela a sua escolha. Relacione a
tabela que você criou com a tabela curso e insira ou atualize os dados; */
create table Aluno(
idAluno int primary key auto_increment,
nome varchar (20),
sobrenome varchar(50),
idade int,
fkCurso int,
constraint idCurso_Alunofk foreign key(fkCurso) references Curso(idCurso)
);

insert into Aluno(nome, sobrenome, idade, fkCurso)values
('willian', 'batista', 18, 1),
('joão', 'pedro', 22, 2),
('lucas', 'hideu', 20, 3);

-- Execute os comandos para:
-- a) Crie a Modelagem Lógica;
-- Um aluno pode estar em apenas um curso,
-- Um Curso pode estar em muitos alunos


-- b) Faça um JOIN entre as duas tabelas;
select 
Alu.nome as nome_aluno,
Alu.sobrenome as sobrenome_aluno,
Alu.idade as idade_aluno,
Cur.nome
from Aluno Alu
inner join Curso as Cur on Cur.idCurso = Alu.fkCurso;
-- c) Faça um JOIN com WHERE entre as duas tabelas;
select
Alu.nome as nome_aluno,
Cur.nome as nome_curso
from Aluno Alu
inner join Curso as Cur on Cur.idCurso = Alu.fkCurso
where sigla = 'ads';


-- d) Crie um campo com a restrição (constraint) de CHECK
alter table Aluno add constraint idadeCHK check (idade >= 17);
update Aluno
set idade = 16
where idAluno = 4;
select * from Aluno; -- testando checker


-- EXERCICIO 3

/* 3. Fazer a modelagem conceitual (DER) de um sistema para um pet shop cadastrar
os pets e seus donos (clientes). 
- Cada pet pertence somente a um cliente.
- Cada cliente pode ter mais de um pet cadastrado.
- Sobre cada pet, o sistema guarda um identificador que é inicializado com 101 e
incrementado de forma automática. Esse identificador é a chave primária que
identifica um pet de forma única. Além do identificador, o sistema guarda o tipo
do animal (se é cachorro, gato, etc), o nome, a raça e a data de nascimento do pet.
- Sobre cada cliente, o sistema guarda também um identificador que identifica de
forma única cada cliente. Esse identificador começa a partir de 1 e é incrementado
de forma automática pelo sistema. Além do código, o sistema guarda o nome, o
telefone fixo, o telefone celular e o endereço de cada cliente. */

-- Criar um banco de dados Pet no MySQL, selecionar esse banco de dados e
-- executar as instruções relacionadas a seguir.
create database Petshop;
use Petshop;
-- Criar as tabelas equivalentes à modelagem.
-- tabela para o cliente


create table Cliente(
idCliente int primary key auto_increment,
nomeCliente varchar(50),
telFixo varchar(12),
telCelular varchar(13),
endereco varchar(100)
)auto_increment = 1;


-- tabela do pet
create table Pet(
idPet int primary key auto_increment,
tipo varchar(20),
nome varchar(50),
raca varchar(30),
dtnasc date,
fk_idCliente int,
constraint Pet_idClientefk foreign key (fk_idCliente) references Cliente(idCliente)
)auto_increment = 101; 

/* - Inserir dados nas tabelas, de forma que exista mais de um tipo de animal
diferente, e que exista algum cliente com mais de um pet cadastrado. Procure
inserir pelo menos 2 clientes diferentes que tenham o mesmo sobrenome. */
insert into Cliente(nomeCliente, telFixo, telCelular,endereco)values
('neymar junior', '551199998888', '5511999498888','oliveirinha'),
('vinicius junior', '551199998888', '5511324238888','camargo');


insert into Pet(tipo, nome, raca, dtnasc, fk_idCliente)values
('cachorro', 'silver', 'vira-lata', '2022-03-29', 1),
('gato', 'roger', 'soneca', '2010-02-22', 1),
('gato', 'fafa', 'nilo', '2012-05-23', 2);

-- Exibir todos os dados de cada tabela criada, separadamente.
select
Cl.*,
P.*
from Cliente Cl
inner join Pet as P on P.fk_idcliente = Cl.idCliente;

/*- Fazer os acertos da chave estrangeira, caso não tenha feito no momento da
criação. */

-- Altere o tamanho da coluna nome do cliente.
alter table Cliente modify column nomeCliente varchar(40);
-- Exibir os dados de todos os pets que são de um determinado tipo (por exemplo: cachorro).
select * from Pet where tipo = 'gato';
-- Exibir apenas os nomes e as datas de nascimento dos pets.
select nome, dtnasc from Pet;
-- Exibir os dados dos pets ordenados em ordem crescente pelo nome.
select * from Pet order by nome asc;

-- Exibir os dados dos clientes ordenados em ordem decrescente pelo bairro.
select * from Cliente order by endereco desc;
-- Exibir os dados dos pets cujo nome comece com uma determinada letra.
select * from Pet where nome like 's%';

-- Exibir os dados dos clientes que têm o mesmo sobrenome.
select * from Cliente where nome like '%junior%';

-- Alterar o telefone de um determinado cliente.
update Cliente
set telFixo = '551122224444'
where idCliente = 1;
-- Exibir os dados dos clientes para verificar se alterou.
select * from Cliente;

-- Exibir os dados dos pets e dos seus respectivos donos.

select
Pet.tipo as tipo,
Pet.nome as nome_pet,
Pet.raca as raça_pet,
Pet.dtnasc as data_nascimentoPet,
Cliente.nomeCliente
from Pet
inner join Cliente on Pet.fk_idCliente = Cliente.idCliente;



-- Exibir os dados dos pets e dos seus respectivos donos, mas somente de um
-- determinado cliente.
select
Pet.tipo as tipo,
Pet.nome as nome_pet,
Pet.raca as raça_pet,
Pet.dtnasc as data_nascimentoPet,
Cliente.nomeCliente
from Cliente
inner join Pet on Pet.fk_idCliente = Cliente.idCliente
where nomeCliente = 'neymar junior';


-- Excluir algum pet.
delete from Pet where idPet = 102;
-- Exibir os dados dos pets para verificar se excluiu.
select * from Pet;

-- Excluir as tabelas.
drop table Pet;
drop table Cliente;


-- EXERCICIO 5

/* 5. Fazer a modelagem conceitual (DER) de um sistema para armazenar os gastos
individuais das pessoas de sua família. */
create database gastosFamilia;
use gastosFamilia;
-- Crie uma entidade Pessoa, com atributos idPessoa, nome, data de nascimento,
-- profissão.
create table Pessoa(
idPessoa int auto_increment primary key,
nome varchar(30),
dtNasc date,
profissao varchar(40)
);

/*Crie uma outra entidade Gasto, com atributos idGasto, data, valor, descrição.
Depois de desenhado o DER, implemente no MySQL as tabelas equivalentes ao
modelo que você criou e: */
create table Gasto(
idGasto int primary key auto_increment,
dtGasto date,
valor decimal(10,3),
descricao varchar(50),
fkidPessoa int,
constraint Gasto_idPessoafk foreign key (fkidPessoa) references Pessoa(idPessoa)
);


-- • Insira dados nas tabelas.
insert into Pessoa(nome, dtNasc, profissao)values
('fausto', '2000-09-03', 'carpinteiro'),
('silvio', '1978-01-28', 'pedreiro'),
('santos', '1987-06-06', 'vendedor');

insert into Gasto(dtGasto, valor, descricao)values
('2025-03-03', 40.000, 'carro'),
('2022-06-15', 400.000, 'casa'),
('2021-01-11', 30.000, 'moto');

-- • Exiba os dados de cada tabela individualmente.
select 
Pessoa.*,
Gasto.*
from Pessoa
inner join Gasto on Gasto.fkidPessoa = Pessoa.idPessoa;

-- Exiba somente os dados de cada tabela, mas filtrando por algum dado
-- da tabela (por exemplo, as pessoas de alguma profissão, etc).
select
Pessoa.nome as nome_pessoa,
Pessoa.profissao as profissão,
Gasto.valor,
Gasto.descricao
from Pessoa
inner join Gasto on Gasto.fkidPessoa = Pessoa.idPessoa
where profissao = 'carpinteiro';


-- Exiba os dados das pessoas e dos seus gastos correspondentes.
select
Pessoa.nome as nome_pessoa,
Pessoa.dtNasc as data_nascimento,
Pessoa.profissao as profissão,
Gasto.descricao as descrição_Gasto,
Gasto.valor as valor_gasto,
Gasto.dtGasto as data_gasto
from Pessoa
inner join Gasto on Gasto.fkidPessoa = Pessoa.idPessoa;


-- • Exiba os dados de uma determinada pessoa e dos seus gastos
-- correspondentes.
select
Pessoa.nome as nome_pessoa,
Pessoa.dtNasc as data_nascimento,
Pessoa.profissao as profissão,
Gasto.descricao as descrição_Gasto,
Gasto.valor as valor_gasto,
Gasto.dtGasto as data_gasto
from Pessoa
inner join Gasto on Gasto.fkidPessoa = Pessoa.idPessoa
where nome = 'silvio';

-- • Atualize valores já inseridos na tabela.
update Gasto
set valor = 15000
where idGasto = 1;

update Gasto
set descricao = 'barco'
where idGasto = 1;

update Gasto
set descricao = 'avião'
where idGasto = 2;

update Pessoa
set nome = 'jorge'
where idPessoa = 1;

-- • Exclua um ou mais registros de alguma tabela.
delete from Gasto where idGasto = 1;
delete from Gasto where descricao = 'avião';
delete from Pessoa where nome = 'fausto';
select * from Gasto;


