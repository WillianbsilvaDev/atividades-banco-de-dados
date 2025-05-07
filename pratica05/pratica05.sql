/* 1. Fazer a modelagem lógica (DER) de um sistema para um pet shop cadastrar
os pets e seus donos (clientes).
- Cada pet pertence somente a um cliente.
- Cada cliente pode ter mais de um pet cadastrado.
- Sobre cada pet, o sistema guarda um identificador que é inicializado com 101 e
incrementado de forma automática. Esse identificador é a chave primária que
identifica um pet de forma única. Além do identificador, o sistema guarda o tipo do
animal (se é cachorro, gato, etc), o nome, a raça e a data de nascimento do pet.
- Sobre cada cliente, o sistema guarda também um identificador que identifica de
forma única cada cliente. Esse identificador começa a partir de 1 e é incrementado
de forma automática pelo sistema. Além do código, o sistema guarda o nome, o
telefone fixo, o telefone celular e o endereço de cada cliente. */
-- Criar um banco de dados Pet no MySQL, selecionar esse banco de dados e
-- executar as instruções relacionadas a seguir.
create database Pet;
use Pet;
-- Criar as tabelas equivalentes à modelagem.
create table cliente(
idCliente int primary key auto_increment,
nome varchar(30),
telFixo varchar(15),
telCelular varchar(15),
endereço varchar(50)
)auto_increment = 1;

create table pet(
idPet int primary key auto_increment,
tipoPet varchar(30),
nome varchar(50),
raçaPet varchar(30),
dtNasc date,
fkidCliente int,
constraint petidCleintefk foreign key (fkidCliente)references cliente(idCliente)
)auto_increment = 101;



-- Inserir dados nas tabelas, de forma que exista mais de um tipo de animal diferente,
-- e que exista algum cliente com mais de um pet cadastrado. Procure inserir pelo
-- menos 2 clientes diferentes que tenham o mesmo sobrenome.
insert into cliente(nome,telFixo,telCelular,endereço)values
('roberto carlos','+551129874512','+5511998751255','rua garlhado costa'),
('fernan torres','+551129845112','+5511992322255','rua tioto ra'),
('rafael carlos','+5515325435312','+5511922751255','rua fens sgi');


insert into pet(tipoPet, nome, raçaPet,dtNasc, fkidCliente)values
('cachorro', 'geraldo', 'bulldog', '2003-04-24', 1),
('gato', 'felipz', 'galan', '2010-03-25', 1),
('cachorro', 'ceni', 'pastor', '2022-11-12', 2);

-- Exibir todos os dados de cada tabela criada, separadamente.
select 
clien.*,
pet.*
from cliente as clien
inner join pet as pet on pet.fkidCliente = clien.idCliente;


-- Fazer os acertos da chave estrangeira, caso não tenha feito no momento da
-- criação.
-- Altere o tamanho da coluna nome do cliente.
alter table cliente modify column nome varchar(60);
-- Exibir os dados de todos os pets que são de um determinado tipo (por exemplo:
-- cachorro).
select * from pet where tipoPet = 'cachorro';
-- Exibir apenas os nomes e as datas de nascimento dos pets.
select nome,dtNasc from pet;
-- Exibir os dados dos pets ordenados em ordem crescente pelo nome.
select * from pet order by nome asc;
-- Exibir os dados dos clientes ordenados em ordem decrescente pelo bairro.
select * from cliente order by endereço desc;
-- Exibir os dados dos pets cujo nome comece com uma determinada letra.
select * from pet where nome like 'g%';
-- Exibir os dados dos clientes que têm o mesmo sobrenome.
select * from cliente where nome like '%carlos%';
-- Alterar o telefone de um determinado cliente.
update cliente
set telFixo = '+551199854111'
where idCliente = 1;
-- Exibir os dados dos clientes para verificar se alterou.
select telFixo from cliente where idCliente = 1;
-- Exibir os dados dos pets e dos seus respectivos donos.
select
pet.nome as nome_pet,
pet.raçaPet as raça,
pet.dtNasc as dataNascimento,
clien.nome as nome_cliente,
clien.telCelular as telefone,
clien.telFixo as celular
from pet as pet
inner join cliente as clien on pet.fkidCliente = clien.idCliente;

-- Exibir os dados dos pets e dos seus respectivos donos, mas somente de um
-- determinado cliente.
select
pet.nome as nome_pet,
pet.raçaPet as raça,
pet.dtNasc as dataNascimento,
clien.nome as nome_cliente,
clien.telCelular as telefone,
clien.telFixo as celular
from pet as pet
inner join cliente as clien on pet.fkidCliente = clien.idCliente
where clien.nome = 'roberto carlos';

-- Excluir algum pet.
delete from pet where idPet = 2;
-- Exibir os dados dos pets para verificar se excluiu.
select * from pet where idPet = 2;
-- Excluir as tabelas.
drop table pet;
drop table cliente; 

/*2. Fazer a modelagem lógica (DER) de um sistema para armazenar os gastos
individuais das pessoas de sua família.
Crie uma entidade Pessoa, com atributos idPessoa, nome, data de nascimento,
profissão.
Crie uma outra entidade Gasto, com atributos idGasto, data, valor, descrição.
Depois de desenhado o DER, implemente no MySQL as tabelas equivalentes ao
modelo que você criou e: */
create database Gasto;
use Gasto;

create table pessoa(
idPessoa int primary key auto_increment,
nome varchar(45),
dtNasc date,
profissao varchar(45)
)auto_increment = 1;

create table gasto(
idGasto int primary key auto_increment,
dataGasto date,
valor varchar(10),
descricao varchar(45),
fkidPessoa int,
constraint gastoidPessoaFK foreign key (fkidPessoa) references pessoa(idPessoa)
)auto_increment = 1;

-- • Insira dados nas tabelas.
insert into pessoa(nome,dtNasc,profissao)values
('Willian Silva','2006-08-18','estudante'),
('Yuri Alberto','2000-04-22','peixe-bagre'),
('Roger Machado','1982-10-11','pedreiro');

insert into gasto(dataGasto, valor, descricao, fkidPessoa)values
('2025-03-04', '3,50', 'bala', 1),
('2025-04-06', '4000.44', 'carro', 2),
('2025-03-04', '1500', 'TV', 3);

-- • Exiba os dados de cada tabela individualmente.
select * from pessoa;
select * from gasto;
-- • Exiba somente os dados de cada tabela, mas filtrando por algum dado da
-- tabela (por exemplo, as pessoas de alguma profissão, etc).
select * from pessoa where nome = 'willian silva';
select * from gasto where descricao = 'carro';
-- • Exiba os dados das pessoas e dos seus gastos correspondentes.
select
p.nome as nome_pessoa,
p.dtNasc as data_nascimento,
p.profissao as profissao,
g.valor as valorGasto,
g.descricao as descricaoGasto,
g.dataGasto as data_Gasto
from pessoa as p
inner join gasto as g on g.fkidPessoa = p.idPessoa;

-- • Exiba os dados de uma determinada pessoa e dos seus gastos
-- correspondentes.
select
p.nome as nome_pessoa,
p.dtNasc as data_nascimento,
p.profissao as profissao,
g.valor as valorGasto,
g.descricao as descricaoGasto,
g.dataGasto as data_Gasto
from pessoa as p
inner join gasto as g on g.fkidPessoa = p.idPessoa
where p.nome = 'willian silva'
and g.valor > '3,00';

-- • Atualize valores já inseridos na tabela.
update gasto
set valor = '4,00'
where fkidPessoa = 1;
-- • Exclua um ou mais registros de alguma tabela. 
delete from gasto where idGasto = idGasto between 1 and 3;
delete from Pessoa where idPessoa = idPessoa between 1 and 3;

/* 3. Fazer a modelagem lógica no MySQL Workbench de um sistema para cadastrar
os setores de uma empresa, os funcionários desses setores e os acompanhantes
desses funcionários para uma festa que a empresa está organizando para celebrar
o fim da pandemia. */
-- Cada setor pode ter mais de um funcionário.
-- Cada funcionário trabalha apenas em um setor.
/* Sobre cada setor, o sistema guarda um número que identifica de forma única cada
setor. Além desse identificador, o sistema guarda o nome do setor e o número do
andar do prédio em que fica o setor. */
/* Sobre cada funcionário, o sistema guarda um identificador que é a chave primária
que identifica um funcionário de forma única. Além do identificador, o sistema
guarda o nome do funcionário, seu telefone e seu salário (que deve ser maior do
que zero, ou seja, o sistema não pode aceitar valores negativos ou iguais a zero. */
/* A empresa está organizando uma festa para celebrar o final da pandemia de Covid.
Nessa festa, cada funcionário poderá trazer zero ou mais acompanhantes. Cada
acompanhante só poderá estar relacionado a um funcionário. */
/* Sobre cada acompanhante, o sistema guarda um identificador que forma uma
chave primária composta, juntamente com a identificação do funcionário que o
convidou para a festa. Além disso, o sistema guarda o nome, o tipo de relação que
o acompanhante tem com o funcionário e a data de nascimento do acompanhante. */
-- Escrever os comandos do MySQL para:
-- Criar um banco de dados chamado PraticaFuncionario.
create database PraticaFuncionario;
-- Selecionar esse banco de dados.
use PraticaFuncionario;
-- Criar as tabelas correspondentes à sua modelagem.
create table setor(
idSetor int primary key,
nome varchar(45),
numAndar int
);

create table funcionario(
idFuncionario int primary key,
nome varchar(45),
telefone varchar(15),
salario decimal(10,2),
fkidSetor int,
constraint funcionarioidSetorfk foreign key (fkidSetor) references setor(idSetor),
constraint salariochk check(salario > 0)
);

create table acompanhante(
idAcompanhante int,
nome varchar(45),
tipoRelacao varchar(20),
dtNasc date,
fkidFuncionario int,
primary key(idAcompanhante,fkidFuncionario),
constraint acompanhanteidFuncionariofk foreign key (fkidFuncionario) references funcionario(idFuncionario)
);
-- Inserir dados nas tabelas, de forma que exista mais de um funcionário em cada
-- setor cadastrado.
insert into setor(idSetor, nome, numAndar)values
(1, 'RH', 1),
(2, 'ADM', 2),
(3, 'Produção', 3),
(4, 'Marketing', 4);

insert into funcionario(idFuncionario,nome,telefone,salario,fkidSetor)values
(1,'roberto firmino','+5511997825242',200.30,1),
(2,'yuri bagre','+5511588839983',140.20,1),
(3,'igor guilherme','+5511992545523',2000.30,2),
(4,'yuri bagre','+5511588839983',140.20,3),
(5,'bagre alberto','+5511998368833',1332.20,4);

insert into acompanhante(idAcompanhante,nome,tipoRelacao,dtNasc,fkidFuncionario)values
(1, 'sing hung', 'esposa', '2000-12-23', 5),
(2, 'shin shan', 'esposa', '2012-10-23', 4),
(3, 'shuu', 'esposa', '2004-12-23', 3),
(4, 'marinata', 'esposa', '2010-12-23', 2),
(5, 'roberta firmina', 'irmã', '2000-12-23', 1);

-- Exibir todos os dados de cada tabela criada, separadamente.
select * from setor;
select * from funcionario;
select * from acompanhante;
/* Fazer os acertos da chave estrangeira, caso não tenha feito no momento da
 criação.*/


-- Exibir os dados dos setores e dos seus respectivos funcionários.
select
s.numAndar as numeroAndar,
s.nome as nome_setor,
f.nome as nome_funcionario,
f.telefone as telefone,
f.salario as salario
from setor as s
inner join funcionario as f on f.fkidSetor = s.idSetor;

-- Exibir os dados de um determinado setor (informar o nome do setor na
-- consulta) e dos seus respectivos funcionários.
select
s.numAndar as numeroAndar,
s.nome as nome_setor,
f.nome as nome_funcionario,
f.telefone as telefone,
f.salario as salario
from setor as s
inner join funcionario as f on f.fkidSetor = s.idSetor
where s.nome = 'RH' and f.nome = 'yuri bagre';

--  Exibir os dados dos funcionários e de seus acompanhantes.
select
f.nome as nome_funcionario,
f.telefone as telefone,
f.salario as salario,
a.nome as nome_acompanhante,
a.tipoRelacao as parentesco,
a.dtNasc as dataNascimento_acompanhante
from funcionario as f
inner join acompanhante as a on a.fkidFuncionario = f.idFuncionario;

-- Exibir os dados de apenas um funcionário (informar o nome do funcionário) e
-- os dados de seus acompanhantes.
select
f.nome as nome_funcionario,
f.telefone as telefone,
f.salario as salario,
a.nome as nome_acompanhante,
a.tipoRelacao as parentesco,
a.dtNasc as dataNascimento_acompanhante
from funcionario as f
inner join acompanhante as a on a.fkidFuncionario = f.idFuncionario
where f.nome = 'igor guilherme';
-- Exibir os dados dos funcionários, dos setores em que trabalham e dos seus
-- acompanhantes.
select 
f.nome as nome_funcionario,
f.telefone as telefone,
f.salario as salario,
s.numAndar as numeroAndar,
s.nome as nome_setor,
a.nome as nome_acompanhante,
a.tipoRelacao as parentesco,
a.dtNasc as dataNascimento_acompanhante
from setor as s
inner join funcionario as f on f.fkidSetor = s.idSetor
inner join acompanhante as a on a.fkidFuncionario = f.idFuncionario; 

/*4. Fazer a modelagem lógica de um sistema para cadastrar os treinadores de
nadadores, que participarão de vários campeonatos, representando o Brasil.
- Cada treinador treina mais de um nadador.
- Cada nadador tem apenas um treinador.
- Sobre cada nadador, o sistema guarda um identificador, que identifica de forma
única cada um deles. Esse identificador começa com o valor 100 e é inserido de
forma automática. Além desse identificador, o sistema guarda o nome, o estado de
origem e a data de nascimento do nadador.
- Sobre cada treinador, o sistema guarda um identificador, que identifica de forma
única cada treinador. Esse identificador começa com o valor 10 e é inserido de forma
automática. O sistema também guarda o nome do treinador, o telefone (apenas um
número de telefone) e o e-mail do treinador.
- Um treinador mais experiente orienta outros treinadores novatos. Cada treinador
novato é orientado apenas por um treinador. */
-- Escrever os comandos do MySQL para:
-- a) Criar um banco de dados chamado Treinador.
create database Treinador;
-- b) Selecionar esse banco de dados.
use Treinador;
-- c) Criar as tabelas correspondentes à sua modelagem.
create table treinador(
idTreinador int primary key auto_increment,
nome varchar(45),
telefone varchar(15) unique,
email varchar(45),
fkidtreinadorExp int unique null,
constraint idtreinadorExperientefk foreign key(fkidtreinadorExp) references treinador(idTreinador) 
)auto_increment = 10;

create table nadador (
idNadador int primary key auto_increment,
nome varchar(45),
estado varchar(45),
dtNasc date,
fkidTreinador int,
constraint nadadorfkidTreinadorfk foreign key (fkidTreinador) references treinador(idTreinador)
)auto_increment = 100;

/* d) Inserir dados nas tabelas, de forma que exista mais de um nadador para algum
 treinador, e mais de um treinador sendo orientado por algum treinador mais
 experiente. */
 insert into treinador(nome,telefone,email,fkidtreinadorExp)values
('rocher machado','+551198889883','roocher@gmail.com',null),
('silve tape','+5511964365883','rfsagr@gmail.com',null),
('tila self','+5511936495883','mehcer@gmail.com',10),
('kadu ryan','+551194597783','ig@gmail.com',11);

insert into nadador(nome,estado,dtNasc,fkidTreinador)values
('roger machado','São paulo','2000-12-22',10),
('crep oga','Rio de janeiro','2002-10-12',11),
('donald trump','Maranhão','2003-09-10',12),
('fiono silva','São paulo','2004-08-08',13);
-- e) Exibir todos os dados de cada tabela criada, separadamente.
select * from treinador;
select * from nadador;
-- f) Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação
-- das tabelas. está mais que feito!!

-- g) Exibir os dados dos treinadores e os dados de seus respectivos nadadores.
select 
t.nome as nome_treinador,
t.telefone as telefone_treinador,
t.email as email_treinador,
n.nome as nome_nadador,
n.estado as estado_nadador,
n.dtNasc as dataNascimento
from treinador as t
inner join nadador as n on n.fkidTreinador = t.idTreinador;

-- h) Exibir os dados de um determinado treinador (informar o nome do treinador na
-- consulta) e os dados de seus respectivos nadadores.
select
t.nome as nome_treinador,
t.telefone as telefone_treinador,
t.email as email_treinador,
n.nome as nome_nadador,
n.estado as estado_nadador,
n.dtNasc as dataNascimento
from treinador as t
inner join nadador as n on n.fkidTreinador = t.idTreinador
where t.nome = 'silve tape';

-- i) Exibir os dados dos treinadores e os dados dos respectivos treinadores
-- orientadores.
select
t.nome as nome_treinador,
t.telefone as telefone_treinador,
t.email as email_treinador,
tE.nome as nome_treinadorExperiente,
tE.telefone as telefone_treinadorExperiente,
tE.email as email_treinadorExperiente
from treinador as t
inner join treinador as tE on t.fkidtreinadorExp = tE.idTreinador;
-- j) Exibir os dados dos treinadores e os dados dos respectivos treinadores
-- orientadores, porém somente de um determinado treinador orientador (informar o
-- nome do treinador na consulta).
select
t.nome as nome_treinador,
t.telefone as telefone_treinador,
t.email as email_treinador,
tE.nome as nome_treinadorExperiente,
tE.telefone as telefone_treinadorExperiente,
tE.email as email_treinadorExperiente
from treinador as t
inner join treinador as tE on t.fkidtreinadorExp = tE.idTreinador
where tE.nome = 'silve tape';

-- l) Exibir os dados dos treinadores, os dados dos respectivos nadadores e os dados
-- dos respectivos treinadores orientadores.
select
t.nome as nome_treinador,
t.telefone as telefone_treinador,
t.email as email_treinador,
n.nome as nome_nadador,
n.estado as estado_nadador,
n.dtNasc as data_nascimento ,
tE.nome as nome_treinadorExperiente,
tE.telefone as telefone_treinadorExperiente,
tE.email as email_treinadorExperiente
from treinador as t
inner join treinador as tE on t.fkidtreinadorExp = tE.idTreinador
inner join nadador as n on n.fkidTreinador = t.idTreinador;

-- m) Exibir os dados de um treinador (informar o seu nome na consulta), os dados dos
-- respectivos nadadores e os dados do seu treinador orientador.
select
t.nome as nome_treinador,
t.telefone as telefone_treinador,
t.email as email_treinador,
n.nome as nome_nadador,
n.estado as estado_nadador,
n.dtNasc as data_nascimento ,
tE.nome as nome_treinadorExperiente,
tE.telefone as telefone_treinadorExperiente,
tE.email as email_treinadorExperiente
from treinador as t
inner join treinador as tE on t.fkidtreinadorExp = tE.idTreinador
inner join nadador as n on n.fkidTreinador = t.idTreinador
where t.nome = 'kadu ryan';




