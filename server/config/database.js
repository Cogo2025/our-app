const mongoose = require('mongoose');

const registrationDB = mongoose.createConnection('mongodb+srv://vishnuvardhan7823:Classic350$@app.nhoij.mongodb.net/registrationdata?retryWrites=true&w=majority&appName=App', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const postDB = mongoose.createConnection('mongodb+srv://vishnuvardhan7823:Classic350$@app.nhoij.mongodb.net/Post-page?retryWrites=true&w=majority&appName=App', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

registrationDB.once('open', () => {
  console.log('Connected to Registration Database');
});

postDB.once('open', () => {
  console.log('Connected to Post Database');
});

module.exports = { registrationDB, postDB }; 