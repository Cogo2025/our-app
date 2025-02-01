const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
<<<<<<< HEAD
  const token = req.headers['authorization']?.split(' ')[1]; // Extract token from header
  if (!token) return res.status(403).json({ error: 'Token required' });
=======
  const authHeader = req.header("Authorization");
  console.log("Received Authorization Header:", authHeader);

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Access denied, no token provided" });
  }
>>>>>>> f7ca15abc46e4a9a01a98af93c6a6a34d550af36

  const token = authHeader.split(" ")[1]; // Extract the token
  console.log("Extracted Token:", token);

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
<<<<<<< HEAD
    req.userId = decoded.id; // Assuming the token contains the user ID
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
=======
    console.log("Decoded User:", decoded);
    req.user = decoded; // Attach decoded user data to request object
    next(); // Continue to the next middleware or route handler
  } catch (error) {
    console.error("JWT Verification Error:", error.message);
    res.status(400).json({ error: "Invalid or expired token" });
>>>>>>> f7ca15abc46e4a9a01a98af93c6a6a34d550af36
  }
};

module.exports = verifyToken;
