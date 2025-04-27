import jwt from "jsonwebtoken"
import { ACCESS_TOKEN_SECRET } from "./auth.js"

/**
 * Verifies Bearer access token and, on success, sets req.user = decoded payload.
 * Otherwise returns 401.
 */
export function authenticate(req, res, next) {
  let token = req.headers.authorization;
  if (!token || !token.startsWith("Bearer ")) {
    return res.status(401).json({ message: "No token provided" })
  }
  token = token.slice("Bearer ".length)
  try {
    const decoded = jwt.verify(token, ACCESS_TOKEN_SECRET)
    req.user = decoded
    next()
  } catch (e) {
    console.error(e)
    return res.status(401).json({ message: "Invalid or expired token" })
  }
}
