package kr.codesquad.issuetracker07.interceptor;

import kr.codesquad.issuetracker07.util.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

    @Value("${JWT_SECRET_KEY}")
    private String JWT_SECRET_KEY;

    private String AUTHORIZATION = "Authorization";

    private static final String TIME = "TIME";
    private static final String URL = "URL";
    private static final String METHOD = "METHOD";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        request.setAttribute(TIME, System.currentTimeMillis());
        request.setAttribute(URL, request.getRequestURL());
        request.setAttribute(METHOD, request.getMethod());
        String givenToken = request.getHeader(AUTHORIZATION);
        log.info("{}", givenToken);
        if (request.getMethod().equals("OPTIONS")) {
            log.info("options 메서드는 통과");
            return true;
        }

        if (request.getMethod().equals("GET")) {
            log.info("get 메서드는 통과");
            return true;
        }

        if (givenToken == null) {
            log.info("There is no token");
            return false;
        }

        log.info("{}", givenToken);
        givenToken = givenToken.replace("Bearer ", "");
        if (!JwtUtils.isValidJwtToken(givenToken, JWT_SECRET_KEY)) {
            response.setStatus(401);
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
        long startTime = (long) request.getAttribute(TIME);
        log.info("{} {} {}", request.getAttribute(METHOD), request.getAttribute(URL), System.currentTimeMillis() - startTime);
    }
}
