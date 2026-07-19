select * from transacoes;
select * from metas;
select * from categorias;

--Quantas transações existem?
select count(*) as total_transacoes from transacoes;

--Qual foi o total gasto?
select sum(t.valor) as total_gasto
from transacoes t
join categorias c on t.id_categoria = c.id_categoria
where c.tipo = 'Despesa';

--Quanto entrou de receita?
select sum(t.valor) as total_receita
from transacoes t
join categorias c on t.id_categoria = c.id_categoria
where c.tipo = 'Receita';

--Quanto saiu em despesas?
with total_gasto as (
	select sum(t.valor) as gasto
	from transacoes t
	join categorias c on t.id_categoria = c.id_categoria
	where c.tipo = 'Despesa'
),

total_receita as (
	select sum(t.valor) as receita
	from transacoes t
	join categorias c on t.id_categoria = c.id_categoria
	where c.tipo = 'Receita'
)

select receita, gasto, receita - gasto as saldo
from total_receita
cross join total_gasto;

--Quanto gastei em cada categoria? 
select c.id_categoria, sum(t.valor)
from transacoes t 
join categorias c on t.id_categoria = c.id_categoria
where c.tipo = 'Despesa'
group by c.id_categoria
order by c.id_categoria;

--Qual categoria gastou mais? 
select c.nome_categoria, sum(t.valor) as total
from transacoes t 
join categorias c on t.id_categoria = c.id_categoria
where c.tipo = 'Despesa'
group by c.nome_categoria
order by total desc
limit 1;

--Qual categoria gastou menos?
select c.nome_categoria, sum(t.valor) as total
from transacoes t 
join categorias c on t.id_categoria = c.id_categoria
where c.tipo = 'Despesa'
group by c.nome_categoria
order by total asc
limit 1;

--Quanto foi gasto em janeiro?
select to_char(t.data, 'MM') as mes, sum(t.valor) as total
from transacoes t
join categorias c on t.id_categoria = c.id_categoria 
where c.tipo = 'Despesa' and to_char(t.data, 'MM') = '01'
group by to_char(t.data, 'MM');

--Quanto foi gasto em março?
select to_char(t.data, 'MM') as mes, sum(t.valor) as total
from transacoes t
join categorias c on t.id_categoria = c.id_categoria 
where c.tipo = 'Despesa' and to_char(t.data, 'MM') = '03'
group by to_char(t.data, 'MM');

--Gastos por mês
select to_char(t.data, 'MM') as mes, sum(t.valor) as total
from transacoes t
join categorias c on t.id_categoria = c.id_categoria 
where c.tipo = 'Despesa'
group by to_char(t.data, 'MM')
order by to_char(t.data, 'MM');

--Qual mês teve o maior gasto?
select to_char(t.data, 'MM') as mes, sum(t.valor) as total
from transacoes t
join categorias c on t.id_categoria = c.id_categoria 
where c.tipo = 'Despesa'
group by to_char(t.data, 'MM')
order by sum(t.valor) desc
limit 1;

--Quanto da meta mensal foi utilizada?
with meta_mensal as (
	select to_char(mes, 'MM') as mes, sum(valor_meta) as total
	from metas 
	group by to_char(mes, 'MM')
),

gastos_mes as (
	select to_char(t.data, 'MM') as mes, sum(t.valor) as gasto
	from transacoes t
	join categorias c on t.id_categoria = c.id_categoria 
	where c.tipo = 'Despesa'
	group by to_char(t.data, 'MM')
)

select m.mes, m.total, g.gasto, m.total - g.gasto as saldo_restante
from meta_mensal m
left join gastos_mes g on m.mes = g.mes
order by mes;

--Quais categorias ultrapassaram a meta?
with meta_categoria as (
	select id_categoria, sum(valor_meta) as total
	from metas 
	group by id_categoria
),

gastos_categoria as (
	select c.id_categoria, sum(t.valor) as gasto
	from transacoes t
	join categorias c on t.id_categoria = c.id_categoria 
	where c.tipo = 'Despesa'
	group by c.id_categoria
)

select m.id_categoria, m.total, g.gasto, (m.total - g.gasto) as saldo_restante
from meta_categoria m
left join gastos_categoria g on m.id_categoria = g.id_categoria
where (m.total - g.gasto) < 0
order by m.id_categoria;

--Qual a média de gastos por mês?
select to_char(t.data, 'MM') as mes, round(avg(t.valor),1) as media
from transacoes t
join categorias c on t.id_categoria = c.id_categoria 
where c.tipo = 'Despesa'
group by to_char(t.data, 'MM')
order by to_char(t.data, 'MM');

--Qual o percentual de quanto da meta daquela categoria foi utilizado.
with meta_categoria as (
	select id_categoria, sum(valor_meta) as meta
	from metas 
	group by id_categoria
),

gastos_categoria as (
	select c.id_categoria, sum(t.valor) as gasto
	from transacoes t
	join categorias c on t.id_categoria = c.id_categoria 
	where c.tipo = 'Despesa'
	group by c.id_categoria
)

select m.id_categoria, m.meta, g.gasto, round((g.gasto / m.meta) * 100, 1) as percentual
from meta_categoria m
left join gastos_categoria g on m.id_categoria = g.id_categoria
order by m.id_categoria;