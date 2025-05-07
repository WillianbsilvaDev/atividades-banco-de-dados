create database empresa;
use empresa;

create table funcionario(
idFuncionario int auto_increment primary key,
nome varchar(45),
sobrenome varchar(45),
emailPessoal varchar(45),
emailServico varchar(45),
fk_chefe int
);
alter table funcionario modify column fk_chefe int null;
alter table funcionario add column fk_chefe int, add constraint funcionario_chefeFK foreign key (fk_chefe) references funcionario(idFuncionario);
describe funcionario;

insert into funcionario(nome, sobrenome, emailPessoal, emailServico, fk_chefe)values
('marcelo', 'rosin', 'rosin.marcelo@gmail.com', 'rosin.marcelo@sptech.school', null),
('fernando', 'brando', 'brando.fernando@gmail.com', 'brando.fernando@sptech.school', 1),
('cunha', 'mateus', 'mateus.cunha@gmail.com', 'cunha.mateus@sptech.school', 1),
('pedre', 'iro', 'pedreiro@gmail.com', 'pedreiro@sptech.school', 1),
('marcio', 'freitas', 'marcio.freitas@gmail.com', 'marcio.freitas@sptech.school', 1);


create table dependente(
idDependente int auto_increment,
fkidFuncionario int,
nome varchar(45),
parentesco varchar(45),
constraint fkdependente_idfuncionarioFK foreign key (fkidFuncionario) references funcionario(idFuncionario),
primary key (idDependente,fkidFuncionario)
);

insert into dependente(fkidFuncionario, nome , parentesco)values
(1, 'marcio' , 'filho'),
(2, 'marcelo' , 'filho'),
(3, 'pedre' , 'filho');

select 
func.nome as nome_funcionario,
func.sobrenome as sobrenome_funcionario,
func.emailPessoal as email_funcionario,
func.emailServico as email_funcionario,
depen.nome as nome_dependente,
depen.parentesco as parentesco
from funcionario as func
inner join dependente as depen on depen.fkidFuncionario = func.idFuncionario;

select 
func.nome as nome_funcionario,
func1.nome as nome_chefe
from funcionario as func
inner join funcionario as func1 on func1.fk_chefe = func.idFuncionario;

truncate table funcionario;

select 
func.*