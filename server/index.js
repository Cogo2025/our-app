const express = require('express');
const postRoutes = require('./routes/postRoutes');
const mongoose = require('mongoose');
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
const cors = require('cors');
app.use(cors());


// Connect to MongoDB
mongoose.connect('mongodb+srv://vishnuvardhan7823:Classic350$@app.nhoij.mongodb.net/registrationdata?retryWrites=true&w=majority&appName=App', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

mongoose.connection.once('open', () => {
  console.log('Connected to MongoDB');
});

// Create uploads directory if it doesn't exist
const fs = require('fs');
if (!fs.existsSync('uploads')) {
    fs.mkdirSync('uploads');
}

// Use Routes
app.use('/api', registerRoutes);
<<<<<<< HEAD
app.use('/api', loginRoutes); // Add this line
app.use('/api', postRoutes);

=======
app.use('/api', loginRoutes); 
app.use('/api',postRoutes);

// Serve static files from uploads directory
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
>>>>>>> f7ca15abc46e4a9a01a98af93c6a6a34d550af36

const PORT = 5000;
const HOST = '0.0.0.0';

app.listen(PORT, HOST, () => {
  console.log(`Server running on http://${HOST}:${PORT}`);
});
