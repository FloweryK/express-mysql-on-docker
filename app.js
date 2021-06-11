/* library */
const express = require('express')
const mysql = require('mysql')
const logger = require('morgan')

/* app */
const app = express()
const app_config = require('./config/app-config')
const port = app_config.port

/* mysql */
const db_config = require('./config/db-config')
const connection = mysql.createConnection(db_config)

/* middleware */
app.use(logger('dev'))

app.get('/test', (req, res) => {
	const sql = "select * from orders"
	connection.query(sql, (err, rows) => {
		if (err) {
			console.err(err)
			res.status(400).send()
		} else {
			res.status(200).send(rows)
		}
	})
})

/* listening */
app.listen(port, () => console.log(`server is listening at localhost:${port}`))
