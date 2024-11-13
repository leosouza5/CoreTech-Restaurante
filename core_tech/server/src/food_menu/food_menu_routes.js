import { Router } from "express";
import { recuperaTodosCardapios, recuperaCardapioPorId, adicionaCardapio, recuperaProdutosDoCardapio, adicionaProdutoAoCardapio, excluiProdutoDoCardapio, alteraProduto, alteraCardapio, excluiCardapio, atualizaCardapioPrincipal, recuperaProdutosDoCardapioPrincipal } from "./controller.js";

export const foodMenuRouter = Router()

foodMenuRouter.get('/cardapios', recuperaTodosCardapios)

foodMenuRouter.get('/cardapio/:id', recuperaCardapioPorId)
foodMenuRouter.get('/principal/cardapio', recuperaProdutosDoCardapioPrincipal)

foodMenuRouter.get('/cardapio/produtos/:id', recuperaProdutosDoCardapio)

foodMenuRouter.post('/cardapio', adicionaCardapio)

foodMenuRouter.post('/cardapio/produto', adicionaProdutoAoCardapio)

foodMenuRouter.delete('/cardapio/:id', excluiCardapio)
foodMenuRouter.delete('/cardapio/produto/:id', excluiProdutoDoCardapio)

foodMenuRouter.patch('/cardapio/produto/:id', alteraProduto)

foodMenuRouter.patch('/cardapio/:id', alteraCardapio)

foodMenuRouter.put('/cardapio/:id', atualizaCardapioPrincipal)