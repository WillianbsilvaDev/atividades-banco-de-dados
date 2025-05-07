-- BD – EXERCÍCIOS – PRÁTICA 03
-- 1. No MySQL Workbench:
-- Crie um banco de dados chamado Sprint2;
create database Sprint2;
-- Use o banco de dados Sprint2;
use Sprint2;

-- Escreva e execute os comandos para:
/*• Criar a tabela chamada Atleta para conter os dados: idAtleta (int e chave primária da
tabela), nome (varchar, tamanho 40), modalidade (varchar, tamanho 40),
qtdMedalha (int, representando a quantidade de medalhas que o atleta possui) */
create table Atleta(
idAtleta int primary key,
nome varchar(40),
modalidade varchar(40),
qtdMedalha int

);

 /*• Inserir dados na tabela, procurando colocar mais de um atleta para cada modalidade
e pelo menos 5 atletas. */
insert into Atleta(idAtleta, nome, modalidade, qtdMedalha)values
(1, 'rodrigo faro', 'futmesa', 3),
(2, 'luciano huck', 'futsal', 7),
(3, 'fausto silva', 'natação', 8),
(4, 'chaves souza', 'volei', 1),
(5, 'kaido santos', 'futebol', 6);


/* • Criar uma tabela chamada País para conter os dados: idPais (int e chave primária da
tabela), nome (varchar, tamanho 30), capital (varchar, tamanho 40); */
-- • Inserir pelo menos 4 países na tabela país.

create table Pais(
idPais int primary key,
nome varchar(30),
capital varchar(40)
);

insert into Pais(idPais, nome, capital) values
(1, 'Brasil', 'São Paulo'),
(2, 'Argentina', 'Buenos aires'),
(3, 'Alemanha', 'Munich'),
(4, 'Japão', 'Tokyo');
/* Fazer a modelagem lógica e implementar o modelo físico conforme a regra de negócio:
• 1 país tem 1 ou muitos atletas;
• 1 atleta é de 1 e somente 1 país;
Escreva e execute os comandos para:*/
--  Criar a chave estrangeira na tabela correspondente conforme modelagem;
alter table Atleta add column idPaisFK INT;
alter table Atleta add constraint Atleta_idPaisFK foreign key (idPaisFK) references Pais(idPais);


-- Atualizar o país de todos os atletas;
update Atleta 
set idPaisFK = 3
where idAtleta = 4; -- utilizei desse update para atualizar todos e select para verificar as alterações
select * from Atleta;

-- • Exibir os atletas e seu respectivo país;
SELECT 
    Atle.idAtleta,
    Atle.nome AS nome_atleta,
    Atle.modalidade,
    Atle.qtdMedalha,
    P.nome AS nome_pais,
    P.capital
FROM 
    Atleta Atle
JOIN 
    Pais P	 ON Atle.idPaisFK = P.idPais;



-- • Exibir apenas o nome do atleta e o nome do respectivo país;
select 
	Atle.nome as nome_atleta,
    P.nome as nome_pais
    from
    Atleta Atle
    join
    Pais P on Atle.idPaisFK = P.idPais
    ;
/*
• Exibir os dados dos atletas, seus respectivos países, de uma determinada capital; */
select 
Atle.*,
P.nome as nome_pais 
from 
Atleta atle
join Pais P ON Atle.idPaisFK = P.idPais
where P.capital = 'Buenos aires';


