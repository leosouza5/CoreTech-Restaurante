import express from 'express';

import { foodMenuRouter } from './src/food_menu/food_menu_routes';

const app = express()
const port = 3000;

app.use(express.json)
app.use(foodMenuRouter)

app.listen(port, () => {
  console.log(`Servidor iniciado na porta ${port}`);
})