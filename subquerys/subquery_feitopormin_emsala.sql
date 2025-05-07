create database sistema;
use sistema;

create table cliente(
id int auto_increment,
primary key(id),
nome varchar(100),
endereco varchar(100),
cep char(9),
numEnd varchar(45),
genero char(1),
salario decimal(10,2)
);
create table pedido(
id int auto_increment,
primary key(id),
data_pedido date,
fkcliente int,
constraint pedido_fkcliente foreign key (fkcliente) references cliente(id)
)auto_increment =1000;

create table produto(
id int auto_increment,
primary key(id),
nome varchar(100),
preco_unitario decimal(10,2)
);

create table pedido_item(
fkpedido int,
fkproduto int,
quantidade decimal(10,3),
valor_unitario decimal(10,2),
primary key(fkpedido,fkproduto),
constraint pedidoItem_fkpedido foreign key (fkpedido) references pedido(id),
constraint pedidoItem_fkproduto foreign key (fkproduto) references produto(id)
);

INSERT INTO cliente (nome) VALUES
		('Empresa ABC LTDA'),
		('Companhia XYZ S.A.'),
		('Serviços de Tecnologia EFG Ltda.'),
		('Comércio de Alimentos GHI Ltda.'),
		('Transportadora JKL S.A.'),
		('Consultoria MNO LTDA'),
		('Fabricação de Produtos PQR S.A.'),
		('Agropecuária STU LTDA'),
		('Indústria de Cosméticos VWX S.A.'),
		('Construtora YZ Ltda.');
        
INSERT INTO produto (nome, preco_unitario) VALUES
	('Tênis de Skate', 129.99),
	('Camiseta Estampada', 49.99),
	('Boné de Marca', 39.99),
	('Celular Gamer', 999.99),
	('Fone de Ouvido Bluetooth', 79.99),
	('Mochila Escolar com Estampa', 69.99),
	('Skate Completo', 149.99),
	('Calça Jeans Rasgada', 79.99),
	('Sneakers de Marca', 89.99),
	('Pulseira Inteligente', 59.99);     
  
INSERT INTO pedido (data_pedido, fkcliente) VALUES
	('2024-04-01', 1),
	('2024-04-02', 2),
	('2024-04-03', 3),
	('2024-04-04', 4),
	('2024-04-05', 5),
	('2024-04-06', 6);    

INSERT INTO pedido_item (fkpedido, fkproduto, quantidade, valor_unitario) VALUES
		(1000, 1, 2, 129.99), 
		(1000, 2, 1, 49.99),  
		(1001, 4, 1, 999.99), 
		(1001, 5, 1, 79.99),  
		(1002, 7, 1, 149.99),
		(1002, 8, 1, 79.99),
		(1003, 9, 1, 89.99),
		(1003, 10, 1, 59.99),
		(1004, 2, 2, 49.99),
		(1004, 6, 1, 69.99),
		(1005, 1, 1, 129.99),
		(1005, 4, 1, 999.99);
  
-- funções matematicas

update cliente set genero = 'm', salario = 100.99
	where id = 1;

update cliente set genero = 'm', salario = 79.99
	where id = 2;
 
update cliente set genero = 'f', salario = 99.99
	where id = 3;
    
update cliente set genero = 'f', salario = 9.99
	where id = 4;

select fkproduto,
nome,
valor_unitario
from pedido_item pi
inner join produto pr on pr.id = pi.fkproduto
where valor_unitario = (select max(valor_unitario) from pedido_item);
-- feito por min
select  valor_unitario from pedido_item;

select fkpedido, AVG(valor_unitario*0.35*quantidade) valor_medio
from pedido_item pi
inner join produto pr on pr.id = pi.fkproduto
group by fkpedido;

select 
fkpedido, AVG(valor_unitario*0.35*quantidade) valor_medio,
round(AVG(valor_unitario*0.35*quantidade),1) valor_arredondado1,
round(truncate(AVG(valor_unitario*0.35*quantidade),1),3) valor_truncado1
from pedido_item pi
inner join produto pr on pr.id = pi.fkproduto
group by fkpedido;

-- nome do cliente, numero do pedido, valor total do pedido,
-- valor médio do pedido, qtde itens comprados no pedido

select
c.nome as cliente,
ped.id as pedido,
sum(pi.valor_unitario*pi.quantidade) as valor_total,
avg(pi.quantidade*pi.valor_unitario) as valor_medio,
count(pi.fkpedido) as quantidade
from cliente as c
inner join pedido as ped on ped.fkcliente = c.id
inner join pedido_item as pi on pi.fkpedido = ped.id
where pi.valor_unitario > 60
group by cliente,pedido;


select *
from pedido_item;

select avg(preco_unitario) from produto;

select
c.nome as cliente,
ped.id as pedido,
sum(pi.valor_unitario*pi.quantidade) as valor_total,
avg(pi.quantidade*pi.valor_unitario) as valor_medio,
count(pi.fkpedido) as quantidade
from cliente as c
inner join pedido as ped on ped.fkcliente = c.id
inner join pedido_item as pi on pi.fkpedido = ped.id
where pi.valor_unitario > 60
group by cli.nome,pi.id;

update produto 
set preco_unitario = 200
where id = 4;

update produto 
set preco_unitario = 160
where id = 8;

update produto 
set preco_unitario = 80
where id = 2;

update produto 
set preco_unitario = 85
where id = 3;

update pedido_item pei
inner join produto pro on pro.id = pei.fkproduto
set pei.valor_unitario = pro.preco_unitario;

/* nome do cliente, numero pedido, valor total_pedido
valor medido pedido, qtde itens comprados no produto,
**cujo valor médio do pedido esteja acima da
média de todos os pedidos
 */
 select
c.nome as cliente,
ped.id as pedido,
sum(pi.valor_unitario*pi.quantidade) as valor_total,
avg(pi.quantidade*pi.valor_unitario) as valor_medio,
count(pi.fkpedido) as qtde_itens_comprador
from cliente as c
inner join pedido ped on ped.fkcliente = c.id
inner join pedido_item pi on pi.fkpedido = ped.id
group by c.nome, ped.id
having valor_medio > (select avg(pi.quantidade*pi.valor_unitario) as x from pedido_item pi);

select avg(pi.quantidade*pi.valor_unitario) as x from pedido_item pi;
