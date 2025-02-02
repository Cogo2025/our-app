const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    
    if (!token) {
      return res.status(401).json({ error: 'No token provided' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log('Decoded token:', decoded); // Debug log
    
    req.user = {
      userId: decoded.userId
    };
    
    next();
  } catch (error) {
    console.error('Auth error:', error); // Debug log
    res.status(401).json({ error: 'Invalid token' });
  }
};

module.exports = verifyToken;
