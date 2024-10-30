CREATE TABLE tb_cardapio(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  ativo boolean NOT NULL DEFAULT false
);

CREATE TABLE tb_produto(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  descricao TEXT NOT NULL,
  valor NUMERIC(10,2) NOT NULL,
  id_cardapio INT NOT NULL,
  FOREIGN KEY (id_cardapio) REFERENCES tb_cardapio(id)
);

CREATE TABLE tb_usuario(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(60) UNIQUE NOT NULL,
  senha VARCHAR(60) NOT NULL,
  tipo_usuario CHAR(1) NOT NULL
);

INSERT INTO tb_usuario (nome, senha, tipo_usuario) VALUES ('admin', 'admin', 'A');

CREATE TABLE tb_pedido(
  id SERIAL PRIMARY KEY,
  nome_cliente VARCHAR(60) NOT NULL,
  valor_total NUMERIC(10,2) NOT NULL,
  mesa VARCHAR(3) NOT NULL,
  data_pedido TIMESTAMP DEFAULT NOW(),
  metodo_pagamento VARCHAR(39) -- Adicionando a vírgula aqui
);

CREATE TABLE rl_pedido_produto(
  id_pedido INT NOT NULL,
  id_produto INT NOT NULL,
  PRIMARY KEY(id_pedido, id_produto),
  FOREIGN KEY (id_produto) REFERENCES tb_produto(id),
  FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id)
);

INSERT INTO tb_cardapio (nome, ativo) VALUES ('Cardápio principal', true);

INSERT INTO tb_produto (nome, descricao, valor, id_cardapio) VALUES 
('Feijoada', 'Feijoada tradicional brasileira.', 35.00, 1),
('Bife à Parmegiana', 'Bife empanado com queijo e molho.', 28.50, 1),
('Salada Caesar', 'Salada fresca com molho Caesar.', 18.00, 1);

INSERT INTO tb_pedido (nome_cliente, valor_total, mesa) VALUES 
('Cliente 1', 83.50, '5');

INSERT INTO rl_pedido_produto (id_pedido, id_produto) VALUES 
(1, 1), (1, 3);
