create table Categorias (
	id_categoria serial primary key,
	nome_categoria varchar(100) unique,
	tipo varchar(50) not null
);

create table Transacoes (
	id serial primary key,
	data date not null,
	valor decimal(10, 2) not null,
	id_categoria int not null,
	constraint fk_transacao_categoria foreign key (id_categoria) references Categorias(id_categoria) on delete restrict
);

create table Metas (
	id serial primary key,
	mes date not null,
	id_categoria int not null,
	valor_meta decimal(10, 2) not null,
	constraint fk_transacao_categoria foreign key (id_categoria) references Categorias(id_categoria) on delete cascade
);