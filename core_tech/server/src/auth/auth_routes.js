import { Router } from "express";
import { adicionarUsuario, atualizaUsuario, deletaUsuario, recuperaUsuarios, verificaLogin } from "./controller.js";

export const authRouter = Router()

authRouter.get('/auth/users', recuperaUsuarios)

authRouter.post('/auth', verificaLogin)
authRouter.post('/auth/user', adicionarUsuario)

authRouter.patch('/auth/user/:id', atualizaUsuario)

authRouter.delete('/auth/user/:id', deletaUsuario)