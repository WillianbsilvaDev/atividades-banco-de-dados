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
(1,2000,'1999-10-23',1),
(2,400,'2000-12-15',2),
(3,500,'2001-11-14',3),
(4,600,'2002-09-12',4),
(5,700,'2003-08-13',1),
(6,800,'2004-11-11',2),
(7,900,'2005-12-12',3),
(8,100,'2007-07-14',4);

insert into produto(id,nome,descricao,preco)values
(1, 'coca-cola','Bebida', 12.5),
(2, 'picanha','Carne', 65.5),
(3, 'maça','fruta', 4),
(4, 'guarana','Bebida', 10.25);

insert into venda_produto(fkVenda,fkProduto,quantidade,desconto)values
(1,1,30,25.6),
(2,2,30,25.35),
(3,3,30,5.50),
(4,4,30,25.35),
(5,5,30,5.50),
(6,6,30,25.6),
(7,7,30,25.35),
(8,8,30,5.50);

-- e) Exibir todos os dados de cada tabela criada, separadamente.
select * from venda;
select * from cliente;
select * from produto;
select v.*,
venda.totalVenda,
produto.nome
from venda_produto as v
inner join venda on venda.id = v.fkvenda
inner join produto on produto.id = v.fkproduto;
/*f) Fazer os acertos da chave estrangeira, caso não tenha feito no momento da criação 
das tabelas. */
-- g) Exibir os dados dos clientes e os dados de suas respectivas vendas.
select 
v.totalVenda,
v.dataVenda,
v.fkCliente,
c.nome,
c.email
from venda as v
inner join cliente as c on c.id = v.fkcliente;

-- h) Exibir os dados de um determinado cliente (informar o nome do cliente na consulta) e os dados de suas respectivas vendas.
select 
c.nome,
c.email,
v.totalVenda,
v.dataVenda,
v.fkCliente
from cliente as c
inner join venda as v on v.fkcliente = c.id
where c.nome = 'sahur';
-- i) Exibir os dados dos clientes e de suas respectivas indicações de clientes.
select 
c.nome,
c.email,
ce.nome,
ce.email
from cliente as c
inner join cliente as ce on c.id = ce.fkCliente;
/* j) Exibir os dados dos clientes indicados e os dados dos respectivos clientes 
indicadores, porém somente de um determinado cliente indicador (informar o nome 
do cliente que indicou na consulta).*/
select 
c.nome,
c.email,
ce.nome as nomeindicado,
ce.email as email_indicado
from cliente as c
inner join cliente as ce on c.id = ce.fkCliente
where c.nome = 'roberto';
/*l) Exibir os dados dos clientes, os dados dos respectivos clientes que indicaram, os 
dados das respectivas vendas e dos produtos. */
select 
c.nome as nome_cliente,
c.email as email_cliente,
ce.nome as nomeindicado,
ce.email as email_indicado,
v.totalVenda as total_venda,
v.dataVenda as data_venda,
p.nome as nome_produto,
p.descricao as descricao_produto,
p.preco as preço_produto,
ven_pro.desconto as valor_desconto,
ven_pro.quantidade as quantidadeAdicionada
from cliente as c
left join cliente as ce on c.id = ce.fkCliente
left join venda as v on c.id = v.fkCliente
left join venda_produto as ven_pro on v.id = ven_pro.fkVenda
left join produto p on p.id = ven_pro.fkProduto;
;

/*m) Exibir apenas a data da venda, o nome do produto e a quantidade do produto numa determinada venda.*/
select
v.dataVenda as data_venda,
p.nome as nome_produto,
ven_pro.quantidade as quantidadeAdicionada
from venda as v
inner join venda_produto as ven_pro on v.id = fkVenda
inner join produto as p on p.id = ven_pro.fkProduto
where v.id = 1;


/*n) Exibir apenas o nome do produto, o valor do produto e a soma da quantidade de 
produtos vendidos agrupados pelo nome do produto. */
select 
p.nome as nome_produto,
p.preco as valor_produto,
sum(ven_pro.quantidade) as quantidade_vendas
from produto p
left join venda_produto ven_pro on p.id = ven_pro.fkProduto
group by p.nome,p.preco;
/*o) Inserir dados de um novo cliente. Exibir os dados dos clientes, das respectivas 
vendas, e os clientes que não realizaram nenhuma venda. */
insert cliente(nome,email,fkCliente)values
('silva', 'lgsdsv@gmail.com', 1);
select
c.nome as nome_cliente,
c.email as email_cliente,
v.totalVenda,
v.dataVenda
from cliente as c
inner join venda v on c.id - v.fkcliente;

select
c.nome as nome_cliente,
c.email as email_cliente,
v.totalVenda,
v.dataVenda
from cliente as c
left join venda v on c.id - v.fkcliente
where v.fkCliente is null;

-- p) Exibir o valor mínimo e o valor máximo dos preços dos produtos;
select
min(preco) as menor_preco,
max(preco) as maior_preco
from produto;

-- q) Exibir a soma e a média dos preços dos produtos;
select 
sum(preco) as somando,
avg(preco) as media
from produto;
-- ) Exibir a quantidade de preços acima da média entre todos os produtos;
select count(*) as preços_acimadaMedia
from produto
where preco > (select avg(preco) from produto);
-- s) Exibir a soma dos preços distintos dos produtos;
select
sum(preco) as soma_preços_distintos_dos_produtos
from produto;
-- t) Exibir a soma dos preços dos produtos agrupado por uma determinada venda;
select
ven_pro.fkVenda,
sum(p.preco * ven_pro.quantidade)
from venda_produto as ven_pro
inner join produto as p on p.id = ven_pro.fkProduto
group by ven_pro.fkVenda;
