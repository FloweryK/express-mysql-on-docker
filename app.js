/* library */
const express = require('express')
const logger = require('morgan')

/* app */
const app = express()
const port = 3000

/* mysql */
const mysql = require('mysql')
const connection = mysql.createConnection({
	"host": process.env.MYSQL_HOST,
	"user": process.env.MYSQL_USER,
	"password": process.env.MYSQL_PASSWORD
})

/* middleware */
app.use(logger('dev'))

app.get('/', (req, res) => res.status(200).send('hello docker world!'))

app.get('/test', (req, res) => {
	connection.query("show databases", (err, rows) => {
		if (err) {
			res.status(400).send(err)
		} else {
			res.status(200).send(rows)
		}
	})
})

/* listening */
app.listen(port, () => console.log(`server is listening at localhost:${port}`))