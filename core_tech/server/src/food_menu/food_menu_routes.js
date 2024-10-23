import { Router } from "express";
import { recuperaTodosCardapios, recuperaCardapioPorId } from "./controller";

export const foodMenuRouter = Router()

foodMenuRouter.get('/cardapios', recuperaTodosCardapios)

foodMenuRouter.get('/cardapio/:id', recuperaCardapioPorId)