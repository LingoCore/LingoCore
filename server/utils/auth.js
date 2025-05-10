import jwt from "jsonwebtoken"

import { } from "./jsdoc.js"

process.loadEnvFile();

export const ACCESS_TOKEN_SECRET = process.env.ACCESS_TOKEN_SECRET
export const REFRESH_TOKEN_SECRET = process.env.REFRESH_TOKEN_SECRET

/**
 * @type {Record<TokenType, TokenGenerateConfig>}
 */
export const tokenProps = {
  "access": {
    secret: ACCESS_TOKEN_SECRET,
    time: "1d"
  },
  "refresh": {
    secret: REFRESH_TOKEN_SECRET,
    time: "7d"
  },
}

/**
 * @param {User} user 
 * @param {TokenType} type
 * @returns {String}
 */
export function generateToken(user, type) {
  return jwt.sign(
    {
      id: user.id,
      type: type,
      version: user.tokenVersion
    },
    tokenProps[type].secret,
    {
      expiresIn: tokenProps[type].time,
    }
  );
}

