# Análise de Finanças Pessoais

> **Cenário:** Este projeto simula o trabalho de uma consultora de dados contratada para analisar as finanças pessoais de um cliente. O objetivo principal é identificar padrões de gastos, acompanhar metas financeiras e gerar insights acionáveis.

---

## Ferramentas Utilizadas

* **Banco de Dados:** PostgreSQL
* **Gerenciamento do Banco:** DBeaver
* **Visualização de Dados:** Power BI.
* **Controle de Versão:** Git & GitHub

---

## Modelo do Banco de Dados

O banco de dados foi modelado utilizando três tabelas principais:

- **Categorias:** classificação das receitas e despesas.
- **Transações:** registro de todas as movimentações financeiras.
- **Metas:** orçamento mensal definido para cada categoria.

![Modelo do Banco](img/modelo_banco.png)

---

## Consultas SQL

### Gasto por categoria
![alt text](img/gasto_categoria.png)

### Saldo financeiro
![alt text](img/saldo_financeiro.png)

### Categorias que ultrapassaram a meta
![alt text](img/categorias%20x%20metas.png)

---

## Dashboard no Power BI

O projeto também conta com um dashboard interativo para acompanhar os principais indicadores financeiros e explorar os gastos por período e categoria.

### Principais indicadores

- Total de receitas.
- Total de despesas.
- Saldo financeiro.
- Percentual do orçamento utilizado.

### Visualizações

- Evolução dos gastos ao longo do tempo.
- Distribuição das despesas por categoria.
- Comparação entre metas e gastos.
- Detalhamento dos indicadores por categoria.

![Dashboard de Finanças Pessoais](powerbi/dashboard.png)

## Autora

Projeto desenvolvido como parte da minha jornada de aprendizado em Análise de Dados.