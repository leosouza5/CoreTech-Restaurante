import express from 'express';
import cors from 'cors';
import { foodMenuRouter } from './src/food_menu/food_menu_routes.js';
import { authRouter } from './src/auth/auth_routes.js';
import { ordersRouter } from './src/orders/orders_routes.js';



const app = express()
const port = 3000;

app.use(cors());
app.use(express.json())
app.use(foodMenuRouter)
app.use(authRouter)
app.use(ordersRouter)


app.listen(port, () => {
  console.log(`Servidor iniciado na porta ${port}`);
})