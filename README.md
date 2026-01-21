# RH Chatbot - Automação n8n, Evolution API & Gestão de Chamados

Este projeto é uma solução completa de backend para RH, permitindo que colaboradores consultem informações (Férias, Holerite) e abram chamados (Benefícios, Onboarding) via WhatsApp. O sistema utiliza uma estrutura hierárquica de menus e armazena interações em um banco relacional para análise de dados (BI).

## 🚀 Tecnologias

* **n8n**: Orquestrador de workflows e lógica de estados.
* **PostgreSQL**: Banco de dados para dados de funcionários e gestão de tickets.
* **Evolution API (v2)**: Gateway para integração profissional com WhatsApp.
* **Docker & Docker Compose**: Gerenciamento de infraestrutura em containers.

---

## 📂 Estrutura do Projeto

├── init-db/
│   └── init.sql              # Script de criação automática das tabelas e bancos
├── workflows/
│   └── workflow_rh.json      # Fluxo lógico hierárquico exportado do n8n
├── docker-compose.yml        # Orquestrador de serviços
├── .env.example              # Modelo de variáveis de ambiente
└── README.md                 # Documentação técnica

---

## 🛠️ Como Instalar e Rodar

### 1. Preparação
Clone o repositório e configure as variáveis:

git clone https://github.com/seu-usuario/rh-chatbot.git
cd rh-chatbot
cp .env.example .env

### 2. Subir Infraestrutura
Execute o comando para iniciar o banco de dados, o n8n e a API:

docker-compose up -d

*O script em `./init-db/init.sql` criará automaticamente o banco `rh_database` e a tabela de `chamados`.*

### 3. Pareamento
Acompanhe os logs para escanear o QR Code do WhatsApp:

docker logs -f evolution-api

---

## 🛡️ Arquitetura e Funcionalidades

### 1. Fluxo Hierárquico
O bot utiliza List Messages e Button IDs para guiar o usuário:
* Nível 1: Menu Principal (Férias, Holerite, Benefícios, Suporte).
* Nível 2: Submenus específicos (ex: Benefícios -> VR, VT ou Plano de Saúde).
* Nível 3: Ações (Consulta de saldo ou Abertura de chamado).

### 2. Sistema de Chamados (Ticketing)
Para questões complexas (ex: valor errado de benefício), o bot coleta o relato do usuário e registra na tabela chamados:
* Categorização Automática: O sistema identifica a origem do problema pelo menu navegado.
* Status em Tempo Real: Os chamados nascem com status Aberto e podem ser geridos via SQL.

### 3. Inteligência de Dados (BI)
A estrutura do banco de dados foi desenhada para integração direta com Power BI ou Metabase, permitindo analisar:
* Volume de chamados por categoria.
* Tempo médio de resolução do RH.
* Identificação de problemas sistêmicos.

---

## 📊 Estrutura do Banco de Dados

CREATE TABLE funcionarios (
    cpf VARCHAR(11) PRIMARY KEY,
    nome TEXT,
    saldo_ferias INT,
    link_holerite TEXT
);

CREATE TABLE chamados (
    id SERIAL PRIMARY KEY,
    funcionario_cpf VARCHAR(11) REFERENCES funcionarios(cpf),
    categoria VARCHAR(50),
    subcategoria VARCHAR(50),
    descricao TEXT,
    status VARCHAR(20) DEFAULT 'Aberto',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);