const express = require('express');
const postRoutes = require('./routes/postRoutes');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const registerRoutes = require('./routes/registerRoutes');
const loginRoutes = require('./routes/loginRoutes'); // Add this line
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

// Use Routes
app.use('/api', registerRoutes);
app.use('/api', loginRoutes); // Add this line
app.use('/api', postRoutes);


const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
