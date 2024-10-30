import { pool } from '../db/db.js'

export const verificaLogin = (req, res) => {
  const { nome, senha } = req.body;

  pool.query("SELECT * FROM tb_usuario WHERE nome = $1 AND senha = $2", [nome, senha], (error, result) => {
    if (error) {
      return res.status(200).json({ error: "Erro ao verificar login." });
    }

    if (result.rowCount === 0) {
      return res.status(200).json({ error: "Usuario não encontrado." });
    }

    if (result.rowCount === 1) {
      res.status(200).json({ sucesso: "Login feito com sucesso" })
    }



  })
}
export const adicionarUsuario = (req, res) => {
  const { nome, senha, tipo_usuario } = req.body;

  if (!nome || !senha || !tipo_usuario) {
    return res.status(200).json({ error: "Nome, senha e tipo de usuario são obrigatórios." });
  }

  pool.query(
    "INSERT INTO tb_usuario (nome, senha,tipo_usuario) VALUES ($1, $2, $3) ",
    [nome, senha, tipo_usuario],
    (error, result) => {
      if (error) {
        if (error.code === '23505') {
          return res.status(200).json({ error: "Já existe um usuário com esse nome." });
        }
        console.log(error.message)
        return res.status(200).json({ error: "Erro ao adicionar usuário." });
      }

      res.status(200).json({ sucesso: "Usuário cadastrado com sucesso!" });
    }
  );
};

export const atualizaUsuario = (req, res) => {
  const { id } = req.params;
  const { nome, tipo_usuario } = req.body;

  console.log(id);
  console.log(req.body);

  if (!id || !nome || !tipo_usuario) {
    return res.status(200).json({ error: "Id, nome e tipo de usuário são obrigatórios." });
  }

  pool.query(
    "UPDATE tb_usuario SET nome = $1, tipo_usuario = $2 WHERE id = $3",
    [nome, tipo_usuario, id],
    (error, result) => {
      if (error) {
        console.log(error.message)
        if (error.code === '23505') {
          return res.status(200).json({ error: "Já existe um usuário com esse nome." });
        }
        return res.status(200).json({ error: "Erro ao atualizar o usuário." });
      }

      if (result.rowCount === 0) {
        return res.status(200).json({ error: "Usuário não encontrado." });
      }

      res.status(200).json({ sucesso: "Usuário atualizado com sucesso." });
    }
  );
}
export const deletaUsuario = (req, res) => {
  const { id } = req.params;

  if (!id) {
    return res.status(200).json({ error: "ID é Obrigatório." });
  }

  pool.query(
    "DELETE FROM tb_usuario WHERE id = $1",
    [id],
    (error, result) => {
      if (error) {
        console.log(error.message)
        return res.status(200).json({ error: "Erro ao deletar o usuário." });
      }

      res.status(200).json({ sucesso: "Usuário deletado com sucesso." });
    }
  );
}

export const recuperaUsuarios = (req, res) => {

  pool.query("SELECT * FROM tb_usuario WHERE nome <> 'admin'", (error, result) => {
    if (error) {
      return res.status(200).json({ error: "Erro ao consultar usuarios." });
    }

    if (result.rowCount === 0) {
      return res.status(200).json({ error: "Nenhum usuário encontrado." });
    }

    res.status(200).json(result.rows)



  })
}
