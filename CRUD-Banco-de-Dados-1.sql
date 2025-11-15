CREATE DATABASE crud_simples;
USE crud_simples;

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INT DEFAULT 0
);

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vendas (
    -- Chave Primária da tabela Vendas
    venda_id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Chave Estrangeira que aponta para a tabela CLIENTES
    cliente_id INT NOT NULL,
    
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    
    -- Definição da Chave Estrangeira:
    -- Garante que só podemos inserir vendas para um cliente_id que exista na tabela CLIENTES
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

INSERT INTO produtos (nome, preco, quantidade) VALUES ('Notebook', 3500.00, 10);
INSERT INTO produtos (nome, preco, quantidade) VALUES ('Mouse Sem Fio', 85.50, 50);
INSERT INTO produtos (nome, preco, quantidade) VALUES ('Teclado RGB', 139.90, 200);
INSERT INTO produtos (nome, preco, quantidade) VALUES ('Monitor AOC', 699.90, 20);

INSERT INTO clientes (nome, email, telefone) 
VALUES ('João da Silva', 'joao.silva@email.com', '9912345678');

INSERT INTO clientes (nome, email, telefone) 
VALUES ('Maria Oliveira', 'maria.oliveria@email.com', '9987654321');

INSERT INTO vendas (cliente_id, data_venda, valor_total) 
VALUES (1, '2025-11-15', 150.75);

INSERT INTO vendas (cliente_id, data_venda, valor_total) 
VALUES (2, '2025-11-14', 89.90);

INSERT INTO vendas (cliente_id, data_venda, valor_total) 
VALUES (2, '2025-11-15', 550.00);

SELECT * FROM produtos;

SELECT nome, preco FROM produtos WHERE nome = 'Notebook';

UPDATE produtos SET preco = 3200.00 WHERE nome = 'Notebook';

DELETE FROM produtos WHERE nome = 'Mouse Sem Fio';

SELECT * FROM produtos;


SELECT 
    c.nome AS Nome_do_Cliente,
    v.data_venda AS Data_da_Venda,
    v.valor_total AS Valor,
    v.venda_id
FROM 
    vendas v
JOIN 
    clientes c ON v.cliente_id = c.cliente_id
ORDER BY 
    c.nome, v.data_venda;