import { Router } from "express";
import { createPedido, editarPedido, finalizaPedido, recuperaPedidoCompleto, recuperaPedidos, recuperaProdutosDoPedido, } from "./controller.js";

export const ordersRouter = Router()

ordersRouter.get('/orders', recuperaPedidos)
ordersRouter.get('/orders/pedidoCompleto/:id', recuperaPedidoCompleto)
ordersRouter.get('/order/pedido/:id', recuperaProdutosDoPedido)
ordersRouter.put('/order/:id', editarPedido)
ordersRouter.post('/order', createPedido)
ordersRouter.patch('/order/:id', finalizaPedido)
