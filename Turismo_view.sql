CREATE DATABASE litoral;
USE litoral;

/* Não gravar mais automaticamente
Controle manual = (SET AUTOCOMMIT = 0;)
controle automatico = (SET AUTOCOMMIT = 1;)*/
SET AUTOCOMMIT = 0;

CREATE TABLE escuna (
	numero INT PRIMARY KEY KEY,
    nome VARCHAR(50),
    capitao_cpf CHAR(11)
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

INSERT INTO destino VALUES
(0, "Ilha Dourada"),
(0, "Ilha D'areia fina"),
(0, "Ilha Encantada"),
(0, "Ilha dos Ventos"),
(0, "Ilinhas"),
(0, "Ilha Torta"),
(0, "Ilha dos Sonhos"),
(0, "Ilha do sono");

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
	










