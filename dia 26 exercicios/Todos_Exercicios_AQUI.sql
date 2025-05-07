create database magazineluizao;
use magazineluizao;
create table cliente(
id int primary key auto_increment,
nome varchar(100)
);
create table produto(
id int primary key auto_increment,
nome varchar(100),
preco_unitario Decimal(10,2)
);

create table empresa(
id int primary key auto_increment,
nome varchar(45),
cnpj varchar(45),
situacao char(1),
fkempresa int,
constraint empresa_fkempresa foreign key (fkempresa) references empresa(id)
);
alter table empresa add constraint empresa_fkempresa foreign key (fkempresa) references empresa(id);

create table pedido(
fkempresa int,
data_pedido date,
numeroPedido int,
fkcliente int,
constraint pedido_empresafk foreign key(fkempresa) references empresa(id),
constraint pedido_clientefk foreign key(fkcliente) references cliente(id)
);
select * from pedido;
 alter table pedido add constraint pedido_clientefk foreign key(fkcliente) references cliente(id), add constraint pedido_empresafk foreign key(fkempresa) references empresa(id);

create table pedido_item(
fknumeroPedido int,
fkEmpresa int,
produtoid int,
quantidade decimal(10,3),
valor_unitario decimal(10,2),
constraint pedido_item_fkpedido foreign key (fkpedido) references pedido(id),
constraint pedido_item_fkproduto foreign key(fkproduto) references produto(id)
);
alter table pedido_item add constraint numeropedidofk foreign key (fknumeroPedido) references pedido(numeroPedido),
add constraint produto_idfk foreign key(produto_id) references produto(id),
add constraint empresafk foreign key (fkEmpresa) references empresa(id);
select * from pedido_item;
 
alter table pedido_item rename column fkproduto to fkEmpresa;
alter table pedido_item  add column produto_id int;
alter table empresa add constraint situacaochk check(situacao in ('A', 'I'));
select * from pedido;


