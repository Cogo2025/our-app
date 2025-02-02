const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const registerRoutes = require('./routes/registerRoutes');
const loginRoutes = require('./routes/loginRoutes'); 
const postRoutes = require('./routes/postRoutes');
const path = require('path');
require('dotenv').config();

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Create uploads directory if it doesn't exist
const fs = require('fs');
if (!fs.existsSync('uploads')) {
    fs.mkdirSync('uploads');
}

// Use Routes
app.use('/api', registerRoutes);
app.use('/api', loginRoutes); // Add this line
app.use('/api', postRoutes);


const PORT = 5000;
const HOST = '0.0.0.0';

app.listen(PORT, HOST, () => {
  console.log(`Server running on http://${HOST}:${PORT}`);
});
