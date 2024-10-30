import pg from 'pg';

const { Pool } = pg

function printa() {
  console.log(process.env.DATABASE_PASSWORD)
}

printa()

export const pool = new Pool({
  user: process.env.DATABASE_USER,
  host: process.env.DATABASE_HOST,
  database: process.env.DATABASE_DB,
  password: process.env.DATABASE_PASSWORD,
  port: process.env.DATABASE_PORT,
})
