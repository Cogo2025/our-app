const jwt = require('jsonwebtoken');

const verifyToken = (req, res, next) => {
  const token = req.header('Authorization')?.split(' ')[1]; // Assuming token is passed as "Bearer token"

  if (!token) {
    return res.status(401).json({ error: 'Access denied, no token provided' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded; // Attach the decoded user data to the request object
    next(); // Continue to the next middleware or route handler
  } catch (error) {
    res.status(400).json({ error: 'Invalid or expired token' });
  }
};

module.exports = verifyToken;
