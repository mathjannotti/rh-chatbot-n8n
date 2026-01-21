-- O banco evolution_db já é criado pelo .env/Compose
CREATE DATABASE rh_database;

-- Conecta no banco de RH
\c rh_database;

CREATE TABLE IF NOT EXISTS funcionarios (
    cpf VARCHAR(11) PRIMARY KEY,
    nome TEXT NOT NULL,
    saldo_ferias INT DEFAULT 0,
    cargo VARCHAR(50)
);

-- Inserindo seus dados de teste
INSERT INTO funcionarios (cpf, nome, saldo_ferias, cargo) 
VALUES ('12345678901', 'Matheus de Souza Jannotti de Oliveira', 22, 'Developer Intern')
ON CONFLICT DO NOTHING;