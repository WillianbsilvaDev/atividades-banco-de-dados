-- 2. No MySQL Workbench, utilizando o banco de dados ‘sprint2’:
use sprint2;

-- • Criar a tabela chamada Musica para conter os dados: idMusica, titulo (tamanho 40),
-- artista (tamanho 40), genero (tamanho 40), sendo que idMusica é a chave primária da
-- tabela.
create table Musica(
idMusica int primary key,
titulo varchar(40),
artista varchar(40),
genero varchar(40)
);



-- • Inserir dados na tabela, procurando colocar um gênero de música que tenha mais de
-- uma música, e um artista, que tenha mais de uma música cadastrada. Procure inserir
-- pelo menos umas 3 músicas.
insert into Musica(idMusica, titulo, artista, genero)values
(1, 'coração frio', 'mc ig', 'funk'),
(2, 'dinheiro e poder', 'mc ph', 'funk'),
(3, 'aprendi a maltratar', 'tarcisio do acordeon', 'forro');
-- • Criar a tabela chamada Album para conter os dados: idAlbum, nome, tipo (digital ou
-- físico) e dtLancamento (DATE).
create table Album(
idAlbum int,
nome varchar (50),
tipo varchar(10),
dtLancamento date,
constraint Album_tipoCHK check (tipo in('digital','fisico'))
); 

-- • Inserir pelo menos 2 albuns;
insert into Album(idAlbum, nome, tipo, dtLancamento) values
(1, 'meu nome não é igor', 'digital', '2022-02-28'),
(2, 'a nata', 'fisico', '2010-07-24');

-- • Fazer a modelagem lógica e implementar o modelo físico conforme a regra de
-- negócio:
-- • 1 album pode ter 1 ou muitas músicas;
-- • 1 música é de 1 e somente 1 album;
-- Execute os comandos para:
-- a) Exibir todos os dados das tabelas separadamente;
select * from Album;
select * from Musica;	
-- b) Criar a chave estrangeira na tabela de acordo com a regra de negócio;
alter table Album modify idAlbum int primary key;
alter table Musica add column fkAlbum int, add constraint AlbumMusicaFK foreign key(fkAlbum) references Album(idAlbum);
-- c) Atualizar os álbuns de cada música;
update Musica
set fkAlbum = 1
where idMusica in (1,2);
update Musica
set fkAlbum = 2
where idMusica = 3;
select * from Musica;

-- d) Exibir as músicas e seus respectivos álbuns;
select 

Mus.titulo as titulo_musica,
Mus.artista,
Mus.genero,
Al.nome as nome_album
from 
Musica Mus
join
 Album Al on Mus.fkAlbum = Al.idAlbum;

-- e) Exibir somente o título da música e o nome do seu respectivo álbum;
select 
mus.titulo as titulo_musica,
alb.nome as nome_album
from
Musica mus
join
Album alb on mus.fkAlbum = alb
.idAlbum;

-- f) Exibir os dados das músicas e seu respectivo álbum, de um determinado tipo.
select
mus.titulo as titulo_musica,
mus.artista,
mus.genero,
al.nome as nome_album
from
Musica mus
join
Album al on mus.fkAlbum = Al.idAlbum
where tipo = 'fisico';