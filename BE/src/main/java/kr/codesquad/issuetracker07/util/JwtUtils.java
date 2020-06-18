package kr.codesquad.issuetracker07.util;

import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;

public class JwtUtils {

    public static boolean isValidJwtToken(String decodedJwtTokenString, String jwtSecretKey) {
        try {
            Jwts.parser()
                .setSigningKey(jwtSecretKey.getBytes())
                .parseClaimsJws(decodedJwtTokenString)
                .getBody();
            return true;
        } catch (JwtException e) {
            return false;
        }
    }
}
