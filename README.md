# 📚 PROJETO CRUD RELACIONAL: GESTÃO BÁSICA DE VENDAS E PRODUTOS

Projeto realizado pelos alunos: 
-Bruno Ferreira Fonseca
-Sthevan Vinicius de Araújo Martins
-Vinícius dos Anjos Almeida

Este projeto é um exercício simples de **CRUD (Create, Read, Update, Delete)** em **MySQL** para a disciplina de Banco de Dados. Ele implementa um modelo relacional básico, gerenciando informações de **clientes**, **produtos** e suas transações de **vendas**.

## 🚀 ESTRUTURA DO BANCO DE DADOS

O banco de dados, denominado `crud_simples`, é composto pelas tabelas `PRODUTOS`, `CLIENTES` e `VENDAS`.

### 1. Tabela: `PRODUTOS` (Tabela de Catálogo)

Armazena os itens disponíveis para venda.

| Campo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| **id** | `INT` | **PK**, `AUTO_INCREMENT` | Chave Primária, identificador único do produto. |
| **nome** | `VARCHAR(100)` | `NOT NULL` | Nome do produto. |
| **preco** | `DECIMAL(10, 2)` | `NOT NULL` | Preço unitário do produto. |
| **quantidade** | `INT` | `DEFAULT 0` | Estoque atual do produto. |

### 2. Tabela: `CLIENTES` (Tabela Pai)

Armazena os dados cadastrais dos indivíduos.

| Campo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| **cliente\_id** | `INT` | **PK**, `AUTO_INCREMENT` | Chave Primária, identificador único do cliente. |
| **nome** | `VARCHAR(150)` | `NOT NULL` | Nome completo do cliente. |
| **email** | `VARCHAR(150)` | `UNIQUE`, `NOT NULL` | E-mail do cliente (deve ser único). |
| **telefone** | `VARCHAR(20)` | | Telefone de contato. |
| **data\_cadastro** | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | Data e hora do cadastro. |

### 3. Tabela: `VENDAS` (Tabela Filho)

Armazena os registros de transações efetuadas.

| Campo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| **venda\_id** | `INT` | **PK**, `AUTO_INCREMENT` | Chave Primária, identificador único da venda. |
| **cliente\_id** | `INT` | **FK** | **Chave Estrangeira** que referencia `CLIENTES.cliente_id`. |
| **data\_venda** | `DATE` | `NOT NULL` | Data em que a venda foi realizada. |
| **valor\_total** | `DECIMAL(10, 2)` | `NOT NULL` | Valor total da transação. |

### Diagrama de Relacionamento

O relacionamento principal é **um-para-muitos** (1:N):
> Um Cliente (`CLIENTES`) pode realizar N Vendas (`VENDAS`).

**Observação:** A tabela `PRODUTOS` atualmente não está diretamente ligada à tabela `VENDAS`. Em um sistema real, uma tabela intermediária (`ITENS_VENDA`) faria essa ligação.

## 🔑 CÓDIGO SQL (Definição da Estrutura)

O código abaixo define as três tabelas e a relação entre Cliente e Vendas:

```sql
-- Cria e seleciona o Banco de Dados
CREATE DATABASE crud_simples;
USE crud_simples;

-- 1. Criação da Tabela PRODUTOS (Catálogo)
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INT DEFAULT 0
);

-- 2. Criação da Tabela CLIENTES
CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Criação da Tabela VENDAS
CREATE TABLE vendas (
    venda_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    
    -- Definição da Chave Estrangeira para o relacionamento Cliente-Venda
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);