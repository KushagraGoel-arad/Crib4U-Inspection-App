var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const cors = require("cors");

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(cors());
app.use(express.static(path.join(__dirname, 'crib4uinspect')));


const PORT = 8022;
const HOST = 'localhost' || '127.0.0.1';

app.listen(PORT, () => console.info("SERVER", `Flutter Server listening! [http://${HOST}:${PORT}]`));

module.exports = app;