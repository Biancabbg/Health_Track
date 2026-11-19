CREATE DATABASE health_track;
USE health_track;

CREATE TABLE Perfil 
(
codigo INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(200)
);
 
 
CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf CHAR(11) UNIQUE,
email VARCHAR(100) UNIQUE NOT NULL,
senha VARCHAR(255) NOT NULL,
telefone VARCHAR(20),
data_nascimento DATE,
endereco VARCHAR(200),
ativo BOOLEAN DEFAULT TRUE,
perfil_id INT NOT NULL, 
CONSTRAINT perfil_usuarios_fk FOREIGN KEY (perfil_id) REFERENCES Perfil(codigo)
);

CREATE TABLE dependente
(
id_dependente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf CHAR(11) UNIQUE,
email VARCHAR(100) UNIQUE NOT NULL,
senha VARCHAR(255) NOT NULL,
telefone VARCHAR(20),
data_nascimento DATE,
endereco VARCHAR(200),
ativo BOOLEAN DEFAULT TRUE,
usuario_id INT NOT NULL ,
CONSTRAINT usuario_dependente_fk FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
 
);
 
CREATE TABLE Responsavel 
(
id_responsavel INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf CHAR(11) UNIQUE,
email VARCHAR(100) UNIQUE NOT NULL,
senha VARCHAR(255) NOT NULL,
telefone VARCHAR(20),
data_nascimento DATE,
endereco VARCHAR(200),
ativo BOOLEAN DEFAULT TRUE, 
dependente_id INT NOT NULL, 
usuario_id INT NOT NULL,
CONSTRAINT dependente_responsavel_fk FOREIGN KEY (dependente_id) REFERENCES dependente(id_dependente),
CONSTRAINT usuario_responsavel_fk FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
);

CREATE TABLE medicamento 
(
id_medicamento INT AUTO_INCREMENT PRIMARY KEY, 
nome VARCHAR (200), 
dosagem VARCHAR (200), 
hora TIME, 
atividade TEXT,
ativo  BOOLEAN DEFAULT TRUE,
dependente_id INT NOT NULL, 
CONSTRAINT dependente_medicamento_fk FOREIGN KEY (dependente_id) REFERENCES dependente(id_dependente)
);
 

CREATE TABLE Contato_emergencia
(
id_contato INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR (200),
numero DECIMAL(11),
ativo BOOLEAN DEFAULT TRUE,
dependente_id INT NOT NULL,
CONSTRAINT dependente_contato_fk FOREIGN KEY (dependente_id) REFERENCES dependente (id_dependente)  
);
 
CREATE TABLE Compromisso
( 
id_compromisso INT AUTO_INCREMENT PRIMARY KEY, 
titulo VARCHAR (200),
data_hora TIMESTAMP, 
descricao TEXT,
fim TIMESTAMP NULL, 
ativo  BOOLEAN DEFAULT TRUE,
dependente_id INT NOT NULL, 
CONSTRAINT dependente_compromisso_fk FOREIGN KEY (dependente_id) REFERENCES dependente (id_dependente) 
);
#Temos apenas 3 tipos de usuarios 
#A tabela de reponsavel não foi preechida por usuario comum pois ele não tem um reponsavel 

INSERT INTO Perfil (nome) VALUES
('Responsável'),
('Dependente'),
('Comum');

INSERT INTO usuarios (nome, cpf, email, senha, telefone, data_nascimento, endereco, perfil_id) VALUES
('Carlos Souza', '12345678901', 'carlos@health.com', 'senha123', '11999998888', '1980-05-10', 'Rua das Flores, 100', 1),
('Mariana Lima', '23456789012', 'mariana@health.com', 'senha123', '11988887777', '1985-06-20', 'Av. Brasil, 200',1),
('Pedro Silva', '34567890123', 'pedro@health.com', 'senha123', '11977776666', '1990-07-30', 'Rua Azul, 300', 2),
('Ana Costa', '45678901234', 'ana@health.com', 'senha123', '11966665555', '1995-08-15', 'Rua Verde, 400', 3),
('João Oliveira', '56789012345', 'joao@health.com', 'senha123', '11955554444', '1975-09-25', 'Rua Amarela, 500', 3);

INSERT INTO dependente (nome, cpf, email, senha, telefone, data_nascimento, endereco, usuario_id) VALUES
('Lucas Almeida', '11122233344', 'lucas@exemplo.com', '123', '11900001111', '2010-04-12', 'Rua A, 11', 1),
('Beatriz Ramos', '22233344455', 'bia@exemplo.com', '123', '11900002222', '1954-06-21', 'Rua B, 22', 2),
('Miguel Santos', '33344455566', 'miguel@exemplo.com', '123', '11900003333', '1945-09-03', 'Rua C, 33', 3),
('Laura Costa', '44455566677', 'laura@exemplo.com', '123', '11900004444', '1948-12-14', 'Rua D, 44', 4),
('Gabriel Martins', '55566677788', 'gabriel@exemplo.com', '123', '11900005555', '1970-02-25', 'Rua E, 55', 5);

 
INSERT INTO Responsavel (nome, cpf, email, senha, telefone, data_nascimento, endereco, dependente_id, usuario_id) VALUES
('Fernanda Almeida', '99988877766', 'fernanda@exemplo.com', 'senha', '11911112222', '1982-03-15', 'Rua A, 11', 1, 1),
('Rodrigo Ramos', '88877766655', 'rodrigo@exemplo.com', 'senha', '11922223333', '1984-05-20', 'Rua B, 22', 2, 2),
('Juliana Santos', '77766655544', 'juliana@exemplo.com', 'senha', '11933334444', '1980-07-10', 'Rua C, 33', 3, 3);
 

INSERT INTO medicamento (nome, dosagem, hora, atividade, dependente_id) VALUES
('Paracetamol', '500mg', '08:00:00', 'Tomar após o café', 1),
('Amoxicilina', '250mg', '12:00:00', 'Tomar após o almoço', 2),
('Ibuprofeno', '200mg', '18:00:00', 'Tomar após o jantar', 3),
('Loratadina', '10mg', '09:00:00', 'Tomar antes de sair', 4),
('Omeprazol', '20mg', '07:30:00', 'Tomar em jejum', 5);

INSERT INTO Contato_emergencia (nome, numero, dependente_id) VALUES
('Avó Maria', 11987654321, 1),
('Filha Joana', 11976543210, 2),
('Filho Paulo', 11965432109, 3),
('Nora Clara', 11954321098, 4),
('Vizinho José', 11943210987, 5);

INSERT INTO Compromisso (titulo, data_hora, descricao, dependente_id, fim) VALUES
('Consulta Pediátrica', '2025-11-02 10:00:00', 'Consulta de rotina com pediatra', 1, '2025-11-02 10:30:00'),
('Vacina Gripe', '2025-11-05 09:00:00', 'Aplicação da vacina da gripe', 2, '2025-11-05 09:15:00'),
('Retorno Médico', '2025-11-10 14:00:00', 'Revisão do tratamento', 3, '2025-11-10 14:30:00'),
('Consulta Odonto', '2025-11-12 11:00:00', 'Limpeza e revisão dentária', 4, '2025-11-12 11:45:00'),
('Exame de Sangue', '2025-11-15 08:00:00', 'Coleta de sangue para exames', 5, '2025-11-15 08:20:00');

#1- Relatorios de medicamentos dos dependentes com dosagem e hora de tomar os remédios

CREATE VIEW medicamentos_dos_dependentes (dependente, medicamento, dosagem, hora) AS
SELECT dependente.nome, medicamento.nome, medicamento.dosagem, medicamento.hora 
FROM dependente, medicamento
WHERE dependente.id_dependente = medicamento.dependente_id
ORDER BY dependente.nome asc;
select * from medicamentos_dos_dependentes;

#2- Compromissos dos dependentes com suas datas e descrições
CREATE VIEW compromisso_dependente (dependente, compromisso, data_hora, descricao) AS
SELECT dependente.nome, compromisso.titulo, compromisso.data_hora, compromisso.descricao
FROM dependente, compromisso
WHERE dependente.id_dependente = compromisso.dependente_id
ORDER BY dependente.nome desc;
 
select * from compromisso_dependente;

#3- Mostra quais são os responsaveis e quais são os dependentes

 
CREATE VIEW responsaveis_dependentes (responsavel, dependente) AS
SELECT responsavel.nome, dependente.nome
FROM responsavel, dependente 
WHERE dependente.id_dependente = responsavel.dependente_id
ORDER BY dependente.nome asc;
select * from responsaveis_dependentes;

#4- Quantos usuarios existem em cada perfil

CREATE VIEW usuarios_perfil (usuarios, perfil) AS
SELECT perfil.nome, COUNT(*) 
FROM usuarios, perfil
WHERE perfil.codigo = usuarios.perfil_id 
GROUP BY perfil.nome 
ORDER BY usuarios.id_usuario;
select * from usuarios_perfil;

#5- Quais são os contatos de emergência e os numeros de telefone por dependente
CREATE VIEW Contatos_dependente (Contato_emergencia, Contato_emergencia_numero, dependente) AS 
SELECT Contato_emergencia.nome, Contato_emergencia.numero, dependente.nome
FROM Contato_emergencia, dependente 
WHERE dependente.id_dependente = Contato_emergencia.dependente_id
ORDER BY dependente.nome asc;
select * from Contatos_dependente;


#Ajuda também em buscas administrativas (mostrar todos os dependentes, quantos comuns existem)
CREATE INDEX idx_usuario_perfil ON usuarios(perfil_id);
 
 
#acelera consultas do tipo: mostrar compromissos do dependente "X”
CREATE INDEX idx_compromisso_dependente ON compromisso(dependente_id);
 
 
#acelera as consultas que envolvem dependentes e seus medicamentos
CREATE INDEX idx_medicamento_dependente ON medicamento(dependente_id);


#A implementação de um RN através de uma transação, procedure ou trigger.
#Fica a cardo da equipe escolher a implementação que melhor atenda as necessidades do projeto. 
#Equivale a um caso de uso de condução. 

#REGRA DE NEGOCIO PROCEDURE PARA VERIFICAR SE O USUARIO É MAIOR DE 18 ANOS
 

DELIMITER //

CREATE PROCEDURE inserir_responsavel(
    IN data_nascimento DATE,
    IN dependente_id INT,
    IN usuario_id INT
)
BEGIN
    IF TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) >= 18 THEN
        INSERT INTO Responsavel (
            data_nascimento,
            dependente_id,
            usuario_id
        ) VALUES (data_nascimento, dependente_id, usuario_id);

        SELECT 'Maior de idade. Inserido com sucesso' AS resultado;
    ELSE
        SELECT 'Menor de idade. Não inserido' AS resultado;
    END IF;
END//

DELIMITER ;


CALL inserir_responsavel ('2009-01-01', 1,1); #menor de idade
CALL inserir_responsavel ('2000-01-01', 1,1); #maior de idade 


#Para cada tabela, que não seja de parâmetro, implementar 1 procedure para inserir registros, 
#1 procedure para alterar registros e 1 procedure para exclusão lógica de registros


#########INSERÇÕES#########

#TABELA USUARIO 

DELIMITER //

CREATE PROCEDURE sp_inserir_usuario (
    IN p_nome VARCHAR(100),
    IN p_cpf CHAR(11),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_telefone VARCHAR(20),
    IN p_data_nascimento DATE,
    IN p_endereco VARCHAR(200),
    IN p_ativo BOOLEAN,
    IN p_perfil_id INT
)
BEGIN
    INSERT INTO usuarios (
        nome, cpf, email, senha, telefone,
        data_nascimento, endereco, ativo, perfil_id
    ) VALUES (
        p_nome, p_cpf, p_email, p_senha, p_telefone,
        p_data_nascimento, p_endereco, p_ativo, p_perfil_id
    );
END //

DELIMITER ;


CALL sp_inserir_usuario(
    'João Silva', '12345677901', 'joao@email.com',
    'senha123', '11988887777', '1990-01-01',
    'Rua Exemplo, 123', TRUE, 1
);




#TABELA DEPENDENTE 

DELIMITER //

CREATE PROCEDURE sp_inserir_dependente (
    IN p_nome VARCHAR(100),
    IN p_cpf CHAR(11),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_telefone VARCHAR(20),
    IN p_data_nascimento DATE,
    IN p_endereco VARCHAR(200),
    IN p_ativo BOOLEAN,
    IN p_usuario_id INT
)
BEGIN
    INSERT INTO dependente (
        nome, cpf, email, senha, telefone,
        data_nascimento, endereco, ativo, usuario_id
    ) VALUES (
        p_nome, p_cpf, p_email, p_senha, p_telefone,
        p_data_nascimento, p_endereco, p_ativo, p_usuario_id
    );
END //

DELIMITER ;

CALL sp_inserir_dependente(
    'Lucas Santos', '11127233344', 'lucasantos@exemplo.com',
    '123', '11990001111', '2010-04-12',
    'Rua Teste, 10', TRUE, 1
);


#TABELA RESPONSAVEL 

DELIMITER //

CREATE PROCEDURE sp_inserir_responsavel (
    IN p_nome VARCHAR(100),
    IN p_cpf CHAR(11),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_telefone VARCHAR(20),
    IN p_data_nascimento DATE,
    IN p_endereco VARCHAR(200),
    IN p_ativo BOOLEAN,
    IN p_dependente_id INT,
    IN p_usuario_id INT
)
BEGIN
    INSERT INTO Responsavel (
        nome, cpf, email, senha, telefone,
        data_nascimento, endereco, ativo, dependente_id, usuario_id
    ) VALUES (
        p_nome, p_cpf, p_email, p_senha, p_telefone,
        p_data_nascimento, p_endereco, p_ativo, p_dependente_id, p_usuario_id
    );
END //

DELIMITER ;

CALL sp_inserir_responsavel(
    'Fernanda Moraes', '99688877766', 'fernanda@teste.com',
    'senha123', '11911112222', '1982-03-15',
    'Rua A, 11', TRUE, 1, 1
);


#TABELA MEDICAMENTO 

DELIMITER //

CREATE PROCEDURE sp_inserir_medicamento (
    IN p_nome VARCHAR(200),
    IN p_dosagem VARCHAR(200),
    IN p_hora TIME,
    IN p_atividade TEXT,
	IN p_ativo BOOLEAN,
    IN p_dependente_id INT
)
BEGIN
    INSERT INTO medicamento (
        nome, dosagem, hora, atividade, ativo, dependente_id
    ) VALUES (
        p_nome, p_dosagem, p_hora, p_atividade, p_ativo, p_dependente_id
    );
END //

DELIMITER ;

CALL sp_inserir_medicamento(
    'Paracetamol', '500mg', '08:00:00',
    'Tomar após o café', TRUE, 1
);


#TABELA CONTATO_EMERGENCIA 

DELIMITER //

CREATE PROCEDURE sp_inserir_contato_emergencia (
    IN p_nome VARCHAR(200),
    IN p_numero DECIMAL(11),
     IN p_ativo BOOLEAN,
    IN p_dependente_id INT
)
BEGIN
    INSERT INTO Contato_emergencia (
        nome, numero, ativo, dependente_id
    ) VALUES (
        p_nome, p_numero, p_ativo,  p_dependente_id
    );
END //

DELIMITER ;

CALL sp_inserir_contato_emergencia(
    'Maria Silva', 11987654321, TRUE, 1
);


#TABELA COMPROMISSO 

DELIMITER //

CREATE PROCEDURE sp_inserir_compromisso (
    IN p_titulo VARCHAR(200),
    IN p_data_hora TIMESTAMP,
    IN p_descricao TEXT,
    IN p_fim TIMESTAMP,
	IN p_ativo BOOLEAN,
    IN p_dependente_id INT
)
BEGIN
    INSERT INTO Compromisso (
        titulo, data_hora, descricao, fim, ativo,  dependente_id
    ) VALUES (
        p_titulo, p_data_hora, p_descricao, p_fim, p_ativo,  p_dependente_id
    );
END //

DELIMITER ;

CALL sp_inserir_compromisso(
    'Consulta Pediátrica', '2025-11-02 10:00:00',
    'Consulta de rotina', '2025-11-02 10:30:00', TRUE, 1
);


#########ATUALIZAÇÕES#########


#TABELA USUARIO 

DELIMITER //

CREATE PROCEDURE sp_update_usuario (
    IN p_id_usuario INT,
    IN p_nome VARCHAR(100),
    IN p_cpf CHAR(11),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_telefone VARCHAR(20),
    IN p_data_nascimento DATE,
    IN p_endereco VARCHAR(200),
    IN p_ativo BOOLEAN,
    IN p_perfil_id INT
)
BEGIN
    UPDATE usuarios
    SET
        nome = p_nome,
        cpf = p_cpf,
        email = p_email,
        senha = p_senha,
        telefone = p_telefone,
        data_nascimento = p_data_nascimento,
        endereco = p_endereco,
        ativo = p_ativo,
        perfil_id = p_perfil_id
    WHERE id_usuario = p_id_usuario;
END //

DELIMITER ;

CALL sp_update_usuario(
	5,
    'Nome Atualizado', 
    '12345668901', 
    'novo@email.com',
    'senhaNova', 
    '11977776666',
    '1991-02-02',
    'Avenida Nova, 456',
    TRUE, 2
);


#TABELA DEPENDENTE 
DELIMITER //


CREATE PROCEDURE sp_update_dependente (
    IN p_id_dependente INT,
    IN p_nome VARCHAR(100),
    IN p_cpf CHAR(11),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_telefone VARCHAR(20),
    IN p_data_nascimento DATE,
    IN p_endereco VARCHAR(200),
    IN p_ativo BOOLEAN,
    IN p_usuario_id INT
)
BEGIN
    UPDATE dependente
    SET
        nome = p_nome,
        cpf = p_cpf,
        email = p_email,
        senha = p_senha,
        telefone = p_telefone,
        data_nascimento = p_data_nascimento,
        endereco = p_endereco,
        ativo = p_ativo,
        usuario_id = p_usuario_id
    WHERE id_dependente = p_id_dependente;
END //

DELIMITER ;

CALL sp_update_dependente(
    3,
    'Maria Alterada',
    '11122273344',
    'nova@exemplo.com',
    'senhaNova',
    '11900003333',
    '2010-05-10',
    'Rua Nova, 123',
    TRUE,
    1
);

#TABELA RESPONSAVEL 

DELIMITER //

CREATE PROCEDURE sp_update_responsavel (
    IN p_id_responsavel INT,
    IN p_nome VARCHAR(100),
    IN p_cpf CHAR(11),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_telefone VARCHAR(20),
    IN p_data_nascimento DATE,
    IN p_endereco VARCHAR(200),
    IN p_ativo BOOLEAN,
    IN p_dependente_id INT,
    IN p_usuario_id INT
)
BEGIN
    UPDATE Responsavel
    SET
        nome = p_nome,
        cpf = p_cpf,
        email = p_email,
        senha = p_senha,
        telefone = p_telefone,
        data_nascimento = p_data_nascimento,
        endereco = p_endereco,
        ativo = p_ativo,
        dependente_id = p_dependente_id,
        usuario_id = p_usuario_id
    WHERE id_responsavel = p_id_responsavel;
END //

DELIMITER ;

CALL sp_update_responsavel(
    2,
    'Responsável Atualizado',
    '88877766655',
    'resp@exemplo.com',
    'senhaNova',
    '11922223333',
    '1984-05-20',
    'Endereço X',
    TRUE,
    3,
    1
);


#TABELA MEDICAMENTOS 

DELIMITER //

CREATE PROCEDURE sp_update_medicamento (
    IN p_id_medicamento INT,
    IN p_nome VARCHAR(200),
    IN p_dosagem VARCHAR(200),
    IN p_hora TIME,
    IN p_atividade TEXT,
	IN p_ativo  BOOLEAN,
    IN p_dependente_id INT
)
BEGIN
    UPDATE medicamento
    SET
        nome = p_nome,
        dosagem = p_dosagem,
        hora = p_hora,
         ativo = p_ativo,
        atividade = p_atividade,
        dependente_id = p_dependente_id
    WHERE id_medicamento = p_id_medicamento;
END //

DELIMITER ;

CALL sp_update_medicamento(
    4,
    'Medicamento Atualizado',
    '20mg',
    '10:00:00',
    'Tomar depois do café', TRUE,
    2
);


#TABELA CONTATO_EMERGENCIA 

DELIMITER //

CREATE PROCEDURE sp_update_contato_emergencia (
    IN p_id_contato INT,
    IN p_nome VARCHAR(200),
    IN p_numero DECIMAL(11),
    IN p_ativo  BOOLEAN,
    IN p_dependente_id INT
)
BEGIN
    UPDATE Contato_emergencia
    SET
        nome = p_nome,
        numero = p_numero,
         ativo = p_ativo,
        dependente_id = p_dependente_id
    WHERE id_contato = p_id_contato;
END //

DELIMITER ;

CALL sp_update_contato_emergencia(
    3,
    'Contato Atualizado',
    11933334444, TRUE,
    4
);


# TABELA COMPRIMISSO 

DELIMITER //

CREATE PROCEDURE sp_update_compromisso (
    IN p_id_compromisso INT,
    IN p_titulo VARCHAR(200),
    IN p_data_hora TIMESTAMP,
    IN p_descricao TEXT,
    IN p_fim TIMESTAMP,
	IN p_ativo BOOLEAN,
    IN p_dependente_id INT
)
BEGIN
    UPDATE Compromisso
    SET
        titulo = p_titulo,
        data_hora = p_data_hora,
        descricao = p_descricao,
        fim = p_fim,
        ativo = p_ativo,
        dependente_id = p_dependente_id
    WHERE id_compromisso = p_id_compromisso;
END //

DELIMITER ;

CALL sp_update_compromisso(
    2,
    'Consulta Atualizada',
    '2025-11-05 14:00:00',
    'Descrição nova aqui',
    '2025-11-05 14:30:00', TRUE, 
    1
);



#########EXCLUSÕES#########

#TABELA USUARIO

DELIMITER //

CREATE PROCEDURE excluir_usuario (
    IN p_id_usuario INT
)
BEGIN
    UPDATE usuarios
    SET ativo = FALSE
    WHERE id_usuario = p_id_usuario;
END//

DELIMITER ;

CALL excluir_usuario(10);


#TABELA DEPENDENTE 

DELIMITER //

CREATE PROCEDURE excluir_dependente (
    IN p_id_dependente INT
)
BEGIN
    UPDATE dependente
    SET ativo = FALSE
    WHERE id_dependente = p_id_dependente;
END//

DELIMITER ;

CALL excluir_dependente(3);


#TABELA RESPONSAVEL 


DELIMITER //

CREATE PROCEDURE excluir_responsavel (
    IN p_id_responsavel INT
)
BEGIN
    UPDATE Responsavel
    SET ativo = FALSE
    WHERE id_responsavel = p_id_responsavel;
END//

DELIMITER ;

CALL excluir_responsavel(2);


#TABELA CONTATOS

DELIMITER //

CREATE PROCEDURE excluir_contato_emergencia (
    IN p_id_contato INT
)
BEGIN
    UPDATE Contato_emergencia
    SET ativo = FALSE
    WHERE id_contato = p_id_contato;
END//

DELIMITER ;

CALL excluir_contato_emergencia(4);


#TABELA MEDICAMENTO 

DELIMITER //

CREATE PROCEDURE excluir_medicamento (
    IN p_id_medicamento INT
)
BEGIN
    UPDATE medicamento
    SET ativo = FALSE
    WHERE id_medicamento = p_id_medicamento;
END//

DELIMITER ;


CALL excluir_medicamento(3);


#TABELA COMPROMISSO

DELIMITER //

CREATE PROCEDURE excluir_compromisso (
    IN p_id_compromisso INT
)
BEGIN
    UPDATE Compromisso
    SET ativo = FALSE
    WHERE id_compromisso = p_id_compromisso;
END//

DELIMITER ;

CALL excluir_compromisso(10);

