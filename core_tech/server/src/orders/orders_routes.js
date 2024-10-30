import { Router } from "express";
import { recuperaPedidos, } from "./controller.js";

export const ordersRouter = Router()

ordersRouter.get('/orders', recuperaPedidos)
