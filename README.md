# RH Chatbot - Automação n8n & Evolution API

Este projeto consiste em um backend automatizado para RH que permite a colaboradores consultarem saldo de férias e links de contracheque via WhatsApp.

## 🚀 Tecnologias

* n8n: Orquestrador de workflows e lógica de backend.
* PostgreSQL: Banco de dados para informações de funcionários.
* Evolution API: Gateway v2 para integração com WhatsApp.
* Docker & Docker Compose: Gerenciamento de infraestrutura.

---

## 📂 Estrutura do Projeto

├── workflows/
│   └── workflow_rh.json      # Fluxo lógico exportado do n8n
├── docker-compose.yml        # Configuração dos serviços
├── .env.example              # Modelo de variáveis de ambiente
├── .gitignore                # Filtro para ignorar .env e volumes
└── README.md                 # Documentação técnica

---

## 🛠️ Como Instalar e Rodar

### 1. Preparação do Ambiente
Clone o repositório e crie o arquivo de variáveis de ambiente:

git clone https://github.com/seu-usuario/rh-chatbot.git
cd rh-chatbot
cp .env.example .env

### 2. Subir Infraestrutura
Certifique-se de que o Docker está em execução e suba os containers:

docker-compose up -d

### 3. Configuração do n8n
1. Acesse o painel em http://localhost:5678.
2. No menu lateral, vá em Workflows > Import from File.
3. Selecione o arquivo workflows/workflow_rh.json.
4. Atualize as credenciais no nó PostgreSQL para conectar ao banco evolution_db.

### 4. Pareamento com WhatsApp
Acompanhe os logs do container para escanear o QR Code:

docker logs -f evolution-api

---

## 🛡️ Resiliência e Tratamento de Dados

O workflow foi otimizado para evitar falhas comuns:

* Normalização de Strings: JavaScript para remover acentos e converter para minúsculas.
* Regex Match: Aceita variações como férias, ferias, contracheque, holerite ou pagamento.
* Referência de Nós: Uso de $node["Webhook"] para manter o acesso à mensagem original em todo o fluxo.

---

## 📊 Estrutura da Tabela SQL

O banco de dados PostgreSQL deve conter a tabela funcionarios:

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    nome TEXT,
    cpf VARCHAR(11) UNIQUE,
    saldo_ferias INT,
    link_holerite TEXT
);