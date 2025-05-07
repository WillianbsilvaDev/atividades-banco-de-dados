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
id int primary key,
nome varchar(30),
descricao varchar(40)
);
create table aluno(
ra int primary key,
nome varchar(45),
telefone varchar(15),
fkprojeto int,
alunoRepre int unique,
constraint alunoprojetofk foreign key(fkprojeto) references projeto(id),
constraint alunoreprefk foreign key (alunoRepre) references aluno(ra)
);


create table acompanhante(
id int primary key,
nome varchar(45),
tipoRelacao varchar(45),
fkaluno int,
constraint tipoRelacaofk foreign key(fkaluno) references aluno(ra)
);

-- Inserir dados nas tabelas.
insert into projeto(id,nome,descricao)values
(1,'visitaEmpresas','Contrato Estágio'),
(2,'BGS','feira de jogos'),
(3,'sptech','show de talentos');

insert into aluno(ra,nome,telefone,alunoRepre,fkprojeto)values
(2242,'silvio','+551199656193',null,1),
(2243,'franklyn','+551199152393',2242,2),
(2244,'lispector','+551196751593',2243,3),
(2245,'lispector','+551196751593',2244,3);

insert into acompanhante(id,nome,tipoRelacao,fkaluno)values
(1,'ruben dias','pai',2242),
(2,'republico luz','tio',2243),
(3,'fario limo','irmão',2244);
-- Exibir todos os dados de cada tabela criada, separadamente.
select * from projeto;
select * from aluno;
select * from acompanhante;
-- Fazer os acertos da chave estrangeira, caso não tenha feito no momento
-- da criação. está feito!			
-- Exibir os dados dos alunos e dos projetos correspondentes.
select
projeto.id,
projeto.nome,
projeto.descricao,
aluno.ra,
aluno.nome,
aluno.telefone
from projeto
inner join aluno on aluno.fkprojeto = projeto.id;
-- Exibir os dados dos alunos e dos seus acompanhantes.
select
aluno.ra,
aluno.nome,
aluno.telefone,
acompanhante.nome,
acompanhante.tipoRelacao
from aluno
inner join acompanhante on acompanhante.fkaluno = aluno.ra;

-- Exibir os dados dos alunos e dos seus representantes.
select
al.ra,
al.nome,
al.telefone,
al1.alunoRepre as idRepresentante,
al1.nome as nomeRepresentante
from aluno as al
inner join aluno as al1 on al1.alunoRepre = al.ra;
-- Exibir os dados dos alunos e dos projetos correspondentes, mas somente
-- de um determinado projeto (indicar o nome do projeto na consulta).
select 
aluno.nome,
aluno.ra,
aluno.telefone,
projeto.nome,
projeto.descricao
from projeto
inner join aluno on aluno.fkprojeto = projeto.id
where projeto.nome = 'BGS';
-- Exibir os dados dos alunos, dos projetos correspondentes e dos seus
-- acompanhantes.
-- exemplo abaixo com inner
select 
aluno.ra,
aluno.nome,
aluno.telefone,
projeto.nome,
projeto.descricao,
acompanhante.nome,
acompanhante.tipoRelacao
from projeto
inner join aluno on aluno.fkprojeto = projeto.id
inner join acompanhante on acompanhante.fkaluno = aluno.ra;

-- exemplo abaixo com left
select 
aluno.ra,
aluno.nome,
aluno.telefone,
projeto.nome,
projeto.descricao,
acompanhante.nome,
acompanhante.tipoRelacao
from projeto
left join aluno on aluno.fkprojeto = projeto.id
left join acompanhante on acompanhante.fkaluno = aluno.ra;

--
/*2. Fazer a modelagem lógica de um sistema para cadastrar as campanhas de
doações que surgiram devido ao Covid-19 e os organizadores dessas
campanhas */
-- Cada organizador organiza mais de uma campanha de doação.
-- Cada campanha de doação é organizada por apenas um organizador.
-- Sobre cada organizador, o sistema guarda um identificador, que identifica de
-- forma única cada organizador. Esse identificador começa com o valor 30 e é
-- inserido de forma automática. Além desse identificador, o sistema guarda o
-- nome, o endereço (composto pelo nome da rua e bairro) e o e-mail do organizador.
/* Sobre cada campanha de doação, o sistema guarda um identificador, que
identifica de forma única cada campanha. Esse identificador começa com o valor
500 e é inserido de forma automática. O sistema também guarda a categoria da
doação (ex: alimento ou produto de higiene, ou máscaras de proteção, etc), a
instituição para a qual será feita a doação (pode haver até 2 instituições) e a data
final da campanha.
- Um organizador mais experiente orienta outros organizadores novatos. Cada
organizador novato é orientado apenas por um organizador mais experiente.
Escrever os comandos do MySQL para: */
-- a) Criar um banco de dados chamado Campanha.
create database campanha;
-- b) Selecionar esse banco de dados.
use campanha;
-- c) Criar as tabelas correspondentes à sua modelagem.
create table organizador(
id int primary key auto_increment,
nome varchar(45),
email varchar(45),
bairro varchar(45),
rua varchar(45),
organizadorExp int null,
constraint fkorganizadorExp foreign key (organizadorExp) references organizador(id)
)auto_increment = 30;

create table campanha(
id int primary key auto_increment,
categoriaDoacao varchar(45),
dtfinal date,
instituicao1 varchar(45) not null,
instituicao2 varchar(45) null,
idOrganizador int,
constraint idOrganizadorfk foreign key(idOrganizador) references organizador(id)
)auto_increment = 500;

/* d) Inserir dados nas tabelas, de forma que exista mais de uma campanha para
algum organizador, e mais de um organizador novato sendo orientado por algum
organizador mais experiente. */
insert into organizador(nome,email,bairro,rua,organizadorExp)values
('ruben dias','pedrisilver@gmail.com','vilo maro','piraibinha do norte',null),
('charmander silva','rrosr@gmail.com','jardim heleno','parnaiba do sul',30),
('jorg isou','segundafeira@gmail.com','itainho paulisto','central lestinho si',30);

insert into campanha(categoriaDoacao,dtfinal,instituicao1,instituicao2,idOrganizador)values
('higiene','2026-07-06','soltamarican',null,30),
('alimento','2025-05-10','silve','sobrau',31),
('livro','2027-06-12','shildren',null,32),
('roupa','2025-04-11','choldas','mander',32);

-- e) Exibir todos os dados de cada tabela criada, separadamente.
select * from organizador;
select * from campanha;
-- f) Fazer os acertos da chave estrangeira, caso não tenha feito no momento da
-- criação das tabelas. feito
-- g) Exibir os dados dos organizadores e os dados de suas respectivas
-- campanhas.
select
organizador.nome,
organizador.email,
organizador.rua,
organizador.bairro,
campanha.categoriaDoacao,
campanha.dtfinal,
campanha.instituicao1,
campanha.instituicao2
from organizador
inner join campanha on campanha.idOrganizador = organizador.id;

-- h) Exibir os dados de um determinado organizador (informar o nome do
-- organizador na consulta) e os dados de suas respectivas campanhas.
select
organizador.nome,
organizador.email,
organizador.rua,
organizador.bairro,
campanha.categoriaDoacao,
campanha.dtfinal,
campanha.instituicao1,
campanha.instituicao2
from organizador
inner join campanha on campanha.idOrganizador = organizador.id
where nome = 'ruben dias';

-- i) Exibir os dados dos organizadores novatos e os dados dos respectivos
-- organizadores orientadores.
select
org.nome,
org.email,
org.rua,
org.bairro,
orgExp.nome,
orgExp.email,
orgExp.rua,
orgExp.bairro
from organizador as org 
inner join organizador as orgExp on orgExp.organizadorExp = org.id;

/*j) Exibir os dados dos organizadores novatos e os dados dos respectivos
organizadores orientadores, porém somente de um determinado organizador
orientador (informar o nome do organizador orientador na consulta). */
select
org.nome,
org.email,
org.rua,
org.bairro,
orgExp.nome,
orgExp.email,
orgExp.rua,
orgExp.bairro
from organizador as org 
inner join organizador as orgExp on orgExp.organizadorExp = org.id
where orgExp.nome = 'jorg isou';
/* l) Exibir os dados dos organizadores novatos, os dados das respectivas
campanhas organizadas e os dados dos respectivos organizadores
orientadores. */
select
org.nome,
org.email,
org.rua,
org.bairro,
orgExp.nome,
orgExp.email,
orgExp.rua,
orgExp.bairro,
campanha.categoriaDoacao,
campanha.dtfinal,
campanha.instituicao1,
campanha.instituicao2
from organizador as org
left join organizador as orgExp on orgExp.organizadorExp = org.id
left join campanha on campanha.idOrganizador = org.id;
/*m) Exibir os dados de um organizador novato (informar o seu nome na consulta),
os dados das respectivas campanhas em que trabalha e os dados do seu
organizador orientador.*/
select
org.nome,
org.email,
org.rua,
org.bairro,
orgExp.nome,
orgExp.email,
orgExp.rua,
orgExp.bairro,
campanha.categoriaDoacao,
campanha.dtfinal,
campanha.instituicao1,
campanha.instituicao2
from organizador as org
left join organizador as orgExp on orgExp.organizadorExp = org.id
left join campanha on campanha.idOrganizador = org.id
where org.nome = 'charmander silva';