-- a) Criar um banco de dados chamado Venda.
create database Venda;
-- b) Selecionar esse banco de dados.
use Venda;
-- c) Criar as tabelas correspondentes à sua modelagem.
create table cliente(
id int auto_increment,
primary key(id),
nome varchar(45),
email varchar(45),
fkCliente int,
constraint cliente_fk foreign key (fkCliente) references cliente(id)
);

create table venda(
id int,
primary key(id),
totalVenda decimal(10,2),
dataVenda date,
fkCliente int,
constraint venda_clientefk foreign key(fkCliente) references cliente(id)
);

create table produto(
id int,
primary key(id),
nome varchar(45),
descricao varchar(45),
preco decimal(10,2)
);

create table venda_produto(
fkVenda int,
fkProduto int,
primary key(fkproduto,fkVenda),
quantidade int,
desconto decimal(10,2)
);

/*d) Inserir dados nas tabelas, de forma que exista mais de uma venda para cada 
cliente, e mais de um cliente sendo indicado por outro cliente. */
insert into cliente(nome,email,fkCliente)values
('roberto', 'caputinebalerine@gmail.com', null),
('firmo', 'bombardilowcrocodilow@gmail.com', 1),
('sahur', 'tuntunsahur@gmail.com', 2),
('petro', 'lppshort@gmail.com', null);

insert into venda(id,totalVenda,dataVenda,fkCliente)values
(1,'2000','1999-10-23',1),
(2,'400','2000-12-15',2),
(3,'500','2001-11-14',3),
(4,'600','2002-09-12',4),
(5,'700','2003-08-13',1),
(6,'800','2004-11-11',2),
(7,'900','2005-12-12',3),
(8,'100','2007-07-14',4);

insert into produto(id,nome,descricao,preco)values
(1, 'coca-cola','Bebida', 12.5),
(2, 'picanha','Carne', 65.5),
(3, 'maça','fruta', 4),
(4, 'guarana','Bebida', 10.25);

insert into venda_produto(fkVenda,fkProduto,quantidade,desconto)values
(1,4,30,25.6);
e) Exibir todos os dados de cada tabela criada, separadamente.
f) Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação 
das tabelas.
g) Exibir os dados dos clientes e os dados de suas respectivas vendas.
h) Exibir os dados de um determinado cliente (informar o nome do cliente na consulta) 
e os dados de suas respectivas vendas.
i) Exibir os dados dos clientes e de suas respectivas indicações de clientes.
j) Exibir os dados dos clientes indicados e os dados dos respectivos clientes 
indicadores, porém somente de um determinado cliente indicador (informar o nome 
do cliente que indicou na consulta).
l) Exibir os dados dos clientes, os dados dos respectivos clientes que indicaram, os 
dados das respectivas vendas e dos produtos.
m) Exibir apenas a data da venda, o nome do produto e a quantidade do produto 
numa determinada venda.
n) Exibir apenas o nome do produto, o valor do produto e a soma da quantidade de 
produtos vendidos agrupados pelo nome do produto.
o) Inserir dados de um novo cliente. Exibir os dados dos clientes, das respectivas 
vendas, e os clientes que não realizaram nenhuma venda.
p) Exibir o valor mínimo e o valor máximo dos preços dos produtos;
q) Exibir a soma e a média dos preços dos produtos;
r) Exibir a quantidade de preços acima da média entre todos os produtos;
s) Exibir a soma dos preços distintos dos produtos;
t) Exibir a soma dos preços dos produtos agrupado por uma determinada venda;