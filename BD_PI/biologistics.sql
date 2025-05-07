CREATE DATABASE Biologistics;
USE Biologistics;
/* regra de negocio para sucesso 

Transportadora -- tabela forte

Endereço deve ter uma transportadora

veiculo deve ser associado ao endereço

sensor precisa estar junto ao lote na mesma embalagem seguindo as normas para aquele medicamento ou vacina 

leitura de sensor deve receber dados em tempo real*/


CREATE TABLE Transportadora (
    transportadora_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    senha varchar(100),
    data_cadastro DATE,
    ativo BOOLEAN DEFAULT TRUE,
    constraint chk_senha_especial check (senha regexp '[!@#$%^&*(),.?":{}|<>]'),
    constraint chk_senha_min check (length(senha) >=8),
    constraint chk_email_special check (email like '%@%')
);

update Transportadora 
set senha = 'Segur@1234'
where transportadora_id = transportadora_id <= 5 ;

CREATE TABLE Endereco (
    endereco_id INT PRIMARY KEY AUTO_INCREMENT,
    transportadora_id INT NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    pais VARCHAR(30) DEFAULT 'Brasil',
    FOREIGN KEY (transportadora_id) REFERENCES Transportadora(transportadora_id)
);

CREATE TABLE Veiculo (
    veiculo_id INT PRIMARY KEY AUTO_INCREMENT,
    transportadora_id INT NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    ano INT,
    tipo_veiculo VARCHAR(50) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (transportadora_id) REFERENCES Transportadora(transportadora_id)
);

CREATE TABLE Sensor (
    sensor_id INT PRIMARY KEY AUTO_INCREMENT,
    veiculo_id INT NOT NULL,
    faixa_min DECIMAL(5,2),
    faixa_max DECIMAL(5,2),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculo(veiculo_id)
);



CREATE TABLE LeiturasSensor (
    leitura_id INT PRIMARY KEY AUTO_INCREMENT,
    sensor_id INT NOT NULL,
    valor DECIMAL(5,2) NOT NULL,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (sensor_id) REFERENCES Sensor(sensor_id)
);

CREATE TABLE Medicamento (
    medicamento_id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_anvisa VARCHAR(20) NOT NULL UNIQUE,
    nome_comercial VARCHAR(80) NOT NULL,
    principio_ativo VARCHAR(80) NOT NULL,
    fabricante VARCHAR(60) NOT NULL,
    tolerancia_exposicao INT NOT NULL,
    
    -- Classificação
    categoria VARCHAR(50) NOT NULL,
    classe_termica VARCHAR(50) NOT NULL,
    
    -- Controle de validade
    tempo_armazenamento INT, -- duração em meses
    requer_protocolo_avaria BOOLEAN DEFAULT TRUE,
    
    -- Status
    ativo BOOLEAN DEFAULT TRUE,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_categoria (categoria),
    INDEX idx_classe_termica (classe_termica)
);

CREATE TABLE LoteMedicamento (
    lote_id INT PRIMARY KEY AUTO_INCREMENT,
    medicamento_id INT NOT NULL,
    numero_lote VARCHAR(50) NOT NULL,
    data_fabricacao DATE NOT NULL,
    data_validade DATE NOT NULL,
    quantidade_inicial INT NOT NULL,
    quantidade_disponivel INT NOT NULL,
    local_armazenamento VARCHAR(100),
    statusMedicamento VARCHAR(50),
    FOREIGN KEY (medicamento_id) REFERENCES Medicamento(medicamento_id),
    UNIQUE KEY (medicamento_id, numero_lote)
);
select * from Transportadora;
/*INSERTS DAS TABELAS ACIMA A SEGUIR*/
-- Inserindo dados na tabela Transportadora
INSERT INTO Transportadora (nome, cnpj, telefone, email, data_cadastro, ativo,) VALUES
('BioTrans Logística', '12.345.678/0001-01', '(11) 98765-4321', 'contato@biotrans.com.br', '2023-01-15', TRUE),
('FarmaExpress', '23.456.789/0001-02', '(21) 99876-5432', 'faleconosco@farmaexpress.com', '2023-02-20', TRUE),
('MediLog Transportes', '34.567.890/0001-03', '(31) 98765-1234', 'medilog@medilog.com.br', '2023-03-10', TRUE),
('VitaCargo', '45.678.901/0001-04', '(41) 91234-5678', 'sac@vitacargo.com', '2023-04-05', TRUE),
('PharmaDelivery', '56.789.012/0001-05', '(51) 98765-6789', 'contato@pharmadelivery.com.br', '2023-05-12', FALSE);

-- Inserindo dados na tabela Endereco
INSERT INTO Endereco (transportadora_id, logradouro, numero, complemento, bairro, cidade, estado, cep, pais) VALUES
(1, 'Avenida das Nações Unidas', '12345', 'Sala 501', 'Brooklin', 'São Paulo', 'SP', '04578-000', 'Brasil'),
(2, 'Rua do Ouvidor', '60', '4º andar', 'Centro', 'Rio de Janeiro', 'RJ', '20040-030', 'Brasil'),
(3, 'Avenida Afonso Pena', '4000', 'Bloco B', 'Mangabeiras', 'Belo Horizonte', 'MG', '30130-009', 'Brasil'),
(4, 'Rua XV de Novembro', '555', NULL, 'Centro', 'Curitiba', 'PR', '80020-310', 'Brasil'),
(5, 'Avenida Borges de Medeiros', '1500', 'Conjunto 302', 'Praia de Belas', 'Porto Alegre', 'RS', '90110-150', 'Brasil');

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (transportadora_id, placa, modelo, ano, tipo_veiculo, ativo) VALUES
(1, 'ABC1D23', 'Mercedes-Benz Sprinter', 2022, 'Furgão refrigerado', TRUE),
(1, 'DEF4G56', 'Volkswagen Delivery', 2021, 'Caminhão baú', TRUE),
(2, 'GHI7J89', 'Ford Transit', 2023, 'Van refrigerada', TRUE),
(3, 'JKL0M12', 'Iveco Daily', 2020, 'Caminhão isotérmico', FALSE),
(4, 'MNO3P45', 'Fiat Ducato', 2022, 'Furgão climatizado', TRUE),
(5, 'PQR6S78', 'Renault Master', 2021, 'Van térmica', TRUE);

-- Inserindo dados na tabela Sensor
INSERT INTO Sensor (veiculo_id, faixa_min, faixa_max, ativo) VALUES
(1, 2.00, 8.00, TRUE),
(1, -20.00, -10.00, TRUE),
(2, 15.00, 25.00, TRUE),
(3, 2.00, 8.00, FALSE),
(4, -15.00, -5.00, TRUE),
(5, 18.00, 22.00, TRUE);

-- Inserindo dados na tabela LeiturasSensor
INSERT INTO LeiturasSensor (sensor_id, valor, data_hora) VALUES
(1, 5.25, '2023-11-01 08:30:00'),
(1, 6.10, '2023-11-01 10:15:00'),
(2, -15.50, '2023-11-01 09:45:00'),
(3, 20.75, '2023-11-02 14:20:00'),
(4, 5.80, '2023-11-02 16:10:00'),
(5, -10.25, '2023-11-03 11:30:00'),
(6, 20.00, '2023-11-03 13:45:00');

-- Inserindo dados na tabela Medicamento
INSERT INTO Medicamento (codigo_anvisa, nome_comercial, principio_ativo, fabricante, tolerancia_exposicao, categoria, classe_termica, tempo_armazenamento, requer_protocolo_avaria, ativo) VALUES
('12345678901', 'Vacina ViraZap', 'Anticorpos monoclonais', 'BioTech Labs', 30, 'Biológico', 'Termolábil', 6, TRUE, TRUE),
('23456789012', 'Insulina Humana', 'Insulina humana recombinante', 'MedFarma S.A.', 45, 'Hormônio', 'Refrigerado', 12, TRUE, TRUE),
('34567890123', 'Antibiótico Z', 'Azitromicina di-hidratada', 'PharmaGlobal', 60, 'Antibiótico', 'Ambiente controlado', 24, FALSE, TRUE),
('45678901234', 'Analgésico Forte', 'Dipirona sódica', 'Química Brasil', 120, 'Analgésico', 'Temperatura ambiente', 36, FALSE, TRUE),
('56789012345', 'Vacina GripeX', 'Vírus influenza inativado', 'Vaccine Tech', 15, 'Biológico', 'Ultra congelado', 18, TRUE, TRUE),
('67890123456', 'Antitérmico Junior', 'Paracetamol', 'ChildPharma', 90, 'Pediatria', 'Ambiente controlado', 24, FALSE, FALSE);

-- Inserindo dados na tabela LoteMedicamento
INSERT INTO LoteMedicamento (medicamento_id, numero_lote, data_fabricacao, data_validade, quantidade_inicial, quantidade_disponivel, local_armazenamento, statusMedicamento) VALUES
(1, 'LOTE202301A', '2023-01-15', '2023-07-15', 1000, 350, 'Câmara fria A12', 'Disponível'),
(1, 'LOTE202302B', '2023-02-20', '2023-08-20', 800, 800, 'Câmara fria B05', 'Disponível'),
(2, 'LOTE202303C', '2023-03-10', '2024-03-10', 1500, 620, 'Geladeira G03', 'Disponível'),
(3, 'LOTE202212A', '2022-12-05', '2024-12-05', 2000, 150, 'Prateleira P15', 'Quarentena'),
(4, 'LOTE202305D', '2023-05-18', '2026-05-18', 3000, 2500, 'Armário A22', 'Disponível'),
(5, 'LOTE202211X', '2022-11-30', '2024-05-30', 500, 0, 'Freezer F01', 'Vencido'),
(6, 'LOTE202304Y', '2023-04-22', '2025-04-22', 1200, 1200, 'Prateleira P08', 'Disponível');


select 
	case 
		when faixa_max  > 6 then Concat('Alerta crítico de segurança aos medicamentos! O Id ',sensor_id,' está detectando temperatura acima do suportado')
	
		when faixa_min < 2 then Concat('Alerta crítico de segurança aos medicamentos! O Id ',sensor_id,' está detectando temperatura abaixo do suportado')
	
		else concat('Nível de temperatura adequado no(s) sensor(es) ', sensor_id ) 
	
	end as situação
from Sensor;

