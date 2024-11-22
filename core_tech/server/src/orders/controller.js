import { pool } from '../db/db.js'

export const recuperaPedidos = (req, res) => {

  pool.query("SELECT * from tb_pedido WHERE metodo_pagamento IS NULL", (error, result) => {
    if (error) {
      return res.status(200).json({ error: "Erro ao consultar pedidos." });
    }

    if (result.rowCount === 0) {
      return res.status(200).json({ error: "Nenhum pedido encontrado." });
    }

    res.status(200).json(result.rows)

  })
}

export const recuperaPedidosFechados = (req, res) => {
  const { data } = req.query;
  console.log(req.query)
  if (!data) {
    return res.status(200).json({ error: "A data é obrigatória." });
  }

  pool.query(
    `SELECT * FROM tb_pedido 
     WHERE metodo_pagamento IS NOT NULL 
     AND data_pedido::date = $1::date`,
    [data],
    (error, result) => {
      if (error) {
        console.log(error.message)
        return res.status(200).json({ error: "Erro ao consultar pedidos." });
      }

      if (result.rowCount === 0) {
        return res.status(200).json({ error: "Nenhum pedido nessa data." });
      }

      res.status(200).json(result.rows);
    }
  );
};

export const recuperaProdutosDoPedido = (req, res) => {
  const id = parseInt(req.params.id)

  pool.query("select p.id,p.nome,p.descricao,p.valor,rl.quantidade,pd.mesa from tb_produto p  INNER JOIN rl_pedido_produto rl on rl.id_produto = p.id INNER JOIN tb_pedido pd ON pd.id = rl.id_pedido where pd.id = $1", [id], (error, result) => {
    if (error) {
      return res.status(200).json({ error: "Erro ao consultar pedidos." });
    }

    if (result.rowCount === 0) {
      return res.status(200).json({ error: "Nenhum pedido encontrado." });
    }

    res.status(200).json(result.rows)

  })
}

export const recuperaPedidoCompleto = (req, res) => {
  const id = parseInt(req.params.id)

  pool.query("SELECT p.id, p.valor_total, p.mesa, p.data_pedido, p.metodo_pagamento, (SELECT json_agg(json_build_object('id', pr.id, 'nome', pr.nome, 'descricao', pr.descricao, 'valor', pr.valor, 'quantidade', rl.quantidade)) FROM tb_produto pr INNER JOIN rl_pedido_produto rl ON rl.id_produto = pr.id WHERE rl.id_pedido = p.id) AS produtos FROM tb_pedido p WHERE p.id = $1", [id], (error, result) => {
    if (error) {
      return res.status(200).json({ error: "Erro ao consultar pedido." });
    }

    if (result.rowCount === 0) {
      return res.status(200).json({ error: "Nenhum pedido encontrado." });
    }

    res.status(200).json(result.rows)

  })
}


export const createPedido = async (req, res) => {
  const { mesa, valor_total, produtos } = req.body;

  try {
    await pool.query('BEGIN');

    const pedidoResult = await pool.query(
      "INSERT INTO tb_pedido(valor_total, mesa) VALUES($1, $2) RETURNING id",
      [valor_total, mesa]
    );
    const idPedido = pedidoResult.rows[0].id;

    for (const produto of produtos) {
      console.log(produto)
      await pool.query(
        "INSERT INTO rl_pedido_produto(id_pedido, id_produto,quantidade) VALUES($1, $2, $3)",
        [idPedido, produto.id, produto.quantidade]
      );
    }

    await pool.query('COMMIT');
    res.status(200).json({ sucesso: "Pedido cadastrado com sucesso!" });

  } catch (error) {
    await pool.query('ROLLBACK');
    console.log(error.message);
    res.status(200).json({ error: "Erro ao cadastrar pedido." });
  }
};

export const editarPedido = async (req, res) => {
  const { id } = req.params;
  const { mesa, valor_total, produtos } = req.body;

  try {
    await pool.query('BEGIN');

    await pool.query(
      "UPDATE tb_pedido SET valor_total = $1, mesa = $2 WHERE id = $3",
      [valor_total, mesa, id]
    );

    await pool.query(
      "DELETE FROM rl_pedido_produto WHERE id_pedido = $1",
      [id]
    );

    for (const produto of produtos) {
      console.log(produto)
      await pool.query(
        "INSERT INTO rl_pedido_produto(id_pedido, id_produto,quantidade) VALUES($1, $2, $3)",
        [id, produto.id, produto.quantidade]
      );
    }

    await pool.query('COMMIT');
    res.status(200).json({ sucesso: "Pedido atualizado com sucesso!" });

  } catch (error) {
    await pool.query('ROLLBACK');
    console.log(error.message);
    res.status(200).json({ error: "Erro ao atualizar pedido." });
  }
};

export const finalizaPedido = async (req, res) => {
  const { id } = req.params;
  const { metodo_pagamento } = req.body;

  try {
    await pool.query('BEGIN');

    await pool.query(
      "UPDATE tb_pedido SET metodo_pagamento = $1 WHERE id = $2",
      [metodo_pagamento, id]
    );

    await pool.query('COMMIT');
    res.status(200).json({ sucesso: "Pedido finalizado com sucesso!" });

  } catch (error) {
    await pool.query('ROLLBACK');
    console.log(error.message);
    res.status(500).json({ error: "Erro ao finalizar pedido." });
  }
};


