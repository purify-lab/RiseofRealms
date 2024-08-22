// const express = require('express');
// const path = require('path');

import express from "express";
import path from "path";

const app = express();

const port = 3110;

app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});