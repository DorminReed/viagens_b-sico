# viagens_b-sico
# Banco de dados simples, com o contexto de lugares disponiveis em uma agência de viagem. 

CREATE DATABASE litoral;
USE litoral;

/* Não gravar mais automaticamente
Controle manual = (SET AUTOCOMMIT = 0;)
controle automatico = (SET AUTOCOMMIT = 1;)*/
SET AUTOCOMMIT = 0;

/* Para criar meu ponto de restauraçãoptimiz */
SAVEPOINT ponto1;

/* Para fins de teste, iremos cometer o seguinte erro para testarmos o savepont*/
UPDATE destino SET nome = "Pequena Ilha do Mar";

SELECT * FROM destino; /* Aqui vemos a tabela após o erro cometido*/

/*Agora para restaurar*/
ROLLBACK TO SAVEPOINT ponto1;

/*Faremos agora o incremento correto*/
UPDATE destino SET nome = "Pequena Ilha do Mar"
WHERE id = 1;

COMMIT;

/*Criando um novo SAVEPOINT*/
SAVEPOINT ponto2;

CREATE TABLE escuna (
	numero INT PRIMARY KEY KEY,
    nome VARCHAR(50),
    capitao_cpf CHAR(11)
);

CREATE TABLE vendas (
	Numero INT PRIMARY KEY AUTO_INCREMENT,
	DestindoId INT,
    Embarque DATE,
    Qtd INT,
    FOREIGN KEY (DestindoId) REFERENCES destino(id)
);


CREATE TABLE destino (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30)
);

CREATE TABLE passeio (
	id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE,
    hora_saida TIME,
    hora_chegada TIME,
    escuna_numero INT,
    destino_id INT,
    FOREIGN KEY (escuna_numero) REFERENCES escuna(numero),
    FOREIGN KEY (destino_id) REFERENCES destino(id)
);

INSERT INTO escuna VALUES
(12345, "Black Flag", "88888888899"),
(12346, "Caveira", "66666666677"),
(12347, "Brazuca", "44444444455"),
(12348, "Rosa Brilhante 1", "12345678900"),
(12349, "Tubarão Ocean", "22222222233"),
(12340, "Rosa Brilhante 2", "12345678900");

INSERT INTO vendas VALUES
(0,1,20180203,3),
(0,7,20180203,2),
(0,5,20180203,1);

INSERT INTO destino VALUES
(0, "Ilha Dourada"),
(0, "Ilha D'areia fina"),
(0, "Ilha Encantada"),
(0, "Ilha dos Ventos"),
(0, "Ilinhas"),
(0, "Ilha Torta"),
(0, "Ilha dos Sonhos"),
(0, "Ilha do sono");

ALTER TABLE destino ADD COLUMN Valor DECIMAL(5,2); /*add nova coluna */

/*add valores na nova coluna criada*/
UPDATE destino SET valor = 100 WHERE id = 1;
UPDATE destino SET valor = 120 WHERE id = 2;
UPDATE destino SET valor = 80 WHERE id = 3;
UPDATE destino SET valor = 90 WHERE id = 4;
UPDATE destino SET valor = 100 WHERE id = 5;
UPDATE destino SET valor = 150 WHERE id = 6;
UPDATE destino SET valor = 120 WHERE id = 7;
UPDATE destino SET valor = 180 WHERE id = 8;

-- Criar função --
CREATE FUNCTION fn_desc(x DECIMAL(5,2), y INT)
RETURNS DECIMAL(5,2)
RETURN ((X*y)*0.7);

CREATE PROCEDURE pro_desc (VAR_VendaNumero INT)
	SELECT
		(fn_desc(destino.valor, Vendas.Qtd)) AS "Valor com desconto",
        destino.Nome AS "Destino",
        vendas.Qtd as "Passagem",
        vendas.embarque
	FROM Vendas INNER JOIN destino
    ON vendas.DestidoId = destino.id
    WHERE vendas.Numero = var_VendaNumero;

CALL pro_desc(1);
CALL pro_desc(2);
CALL pro_desc(3);

INSERT INTO passeio VALUES
(0,20180102,080000,140000,12345,1);

SELECT * FROM passeio;

-- criação da consulta com o nome da escuna, destino, hora de saída e chegada, e data do passeio
SELECT 
	escuna.nome AS "escuna",
	destino.nome AS "Ilha",
	hora_saida, hora_chegada, data
FROM passeio INNER JOIN escuna 
	ON passeio.escuna_numero = escuna.numero
INNER JOIN destino 
	ON passeio.destino_id = destino.id
ORDER BY passeio.data;

-- CRIAÇÃO DE VIEW --
CREATE VIEW v_consulta AS 
	SELECT 
		escuna.nome AS "escuna",
		destino.nome AS "Ilha",
		hora_saida, hora_chegada, data
	FROM passeio INNER JOIN escuna 
		ON passeio.escuna_numero = escuna.numero
	INNER JOIN destino 
		ON passeio.destino_id = destino.id
	ORDER BY passeio.data;
    
-- Consultar VIEW --
SELECT * FROM v_consulta;

-- Apagar VIEW --
DROP VIEW v_consulta;
