import { pool } from '../db/db.js'

export const recuperaTodosCardapios = (req, res) => {
  pool.query("SELECT * FROM tb_cardapio", (error, result) => {
    if (error) throw error;


    res.status(200).json(result.rows)
  })
}
export const recuperaCardapioPorId = (req, res) => {
  const id = parseInt(req.params.id)
  if (!id) {
    res.status(200)
  }

  pool.query("SELECT * FROM tb_cardapio WHERE id = $1", [id], (error, result) => {
    if (error) throw error;


    res.status(200).json(result.rows)
  })
}
export const adicionaCardapio = (req, res) => {
  console.log(req.body);
  const { nome } = req.body

  if (!nome) {
    return res.status(400).json({ error: "O campo 'nome' é obrigatório" });
  }

  pool.query("INSERT INTO tb_cardapio (nome) VALUES ($1)", [nome], (error, result) => {
    if (error) throw error

    res.status(200).json({ sucesso: "Cardapio cadastrado com sucesso" })
  })

}


export const alteraCardapio = (req, res) => {
  const id = parseInt(req.params.id)
  const { nome } = req.body

  if (!nome) {
    return res.status(500).json({ error: "Parametros insuficientes." });
  }

  if (!id) {
    return res.status(500).json({ error: "ID do cardápio é obrigatório." });
  }

  pool.query("UPDATE tb_cardapio SET nome = $1 WHERE id = $2", [nome, id], (error, result) => {
    if (error) {
      return res.status(500).json({ error: "Erro ao alterar cardápio." });
    }

    if (result.rowCount === 0) {
      return res.status(500).json({ error: "cardápio não encontrado." });
    }

    res.status(200).json({ sucesso: "Cardápio alterado com sucesso." });
  });
}
export const excluiCardapio = (req, res) => {
  // implementar
}

export const excluiProdutoDoCardapio = (req, res) => {
  const id = parseInt(req.params.id);

  if (!id) {
    return res.status(400).json({ error: "ID do produto é obrigatório." });
  }

  pool.query("DELETE FROM tb_produto WHERE id = $1", [id], (error, result) => {
    if (error) {
      console.log(error.message)
      return res.status(500).json({ error: "Erro ao excluir produto." });
    }

    if (result.rowCount === 0) {
      return res.status(500).json({ error: "Produto não encontrado." });
    }

    res.status(200).json({ sucesso: "Produto excluído com sucesso." });
  });
};

export const alteraProduto = (req, res) => {
  const id = parseInt(req.params.id);
  const { nome, descricao, valor } = req.body
  console.log(req.body)
  console.log(id)
  if (!nome || !descricao || !valor) {
    return res.status(500).json({ error: "Parametros insuficientes." });
  }

  if (!id) {
    return res.status(500).json({ error: "ID do produto é obrigatório." });
  }

  pool.query("UPDATE tb_produto SET nome = $1, descricao = $2, valor = $3 WHERE id = $4", [nome, descricao, valor, id], (error, result) => {
    if (error) {
      return res.status(500).json({ error: "Erro ao alterar produto." });
    }

    if (result.rowCount === 0) {
      return res.status(500).json({ error: "Produto não encontrado." });
    }

    res.status(200).json({ sucesso: "Produto alterado com sucesso." });
  });
};


export const recuperaProdutosDoCardapio = (req, res) => {
  const id = parseInt(req.params.id)
  if (!id) {
    res.status(200)
  }

  pool.query("SELECT * FROM tb_produto WHERE id_cardapio = $1", [id], (error, result) => {
    if (error) throw error;


    res.status(200).json(result.rows)
  })
}
export const adicionaProdutoAoCardapio = (req, res) => {
  console.log(req.body);
  const { nome, descricao, valor, id_cardapio } = req.body
  if (!id_cardapio || !nome || !descricao || !valor) {
    res.status(500)
  }

  pool.query("INSERT INTO tb_produto (nome,descricao,valor,id_cardapio) VALUES ($1,$2,$3,$4)", [nome, descricao, valor, id_cardapio], (error, result) => {
    if (error) {
      console.error("Erro ao cadastrar produto:", error.message); // Registra o erro no console
      return res.status(500).json({ error: "Erro ao cadastrar produto." });
    }



    res.status(200).json({ sucesso: "Produto cadastrado com sucesso" })
  })
}
