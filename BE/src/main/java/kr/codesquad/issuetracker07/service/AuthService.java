package kr.codesquad.issuetracker07.service;

import kr.codesquad.issuetracker07.dto.GithubAccessToken;
import kr.codesquad.issuetracker07.domain.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Collections;

@Service
public class AuthService {

    private final String REQUEST_BASE_URL = "https://github.com/login/oauth/authorize";

    private final String EXCHANGE_TOKEN_URL = "https://github.com/login/oauth/access_token";

    private final String REQUEST_USER_INFO_URL = "https://api.github.com/user";

    @Value("${CLIENT_ID}")
    private String CLIENT_ID;

    @Value("${CLIENT_SECRET}")
    private String CLIENT_SECRET;

    public String createGithubAuthTokenUri() {
        return UriComponentsBuilder.fromHttpUrl(REQUEST_BASE_URL)
                                   .queryParam("client_id", CLIENT_ID)
                                   .build()
                                   .encode()
                                   .toString();
    }

    public String getGithubAccessToken(String code) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders httpHeaders = new HttpHeaders();
        MultiValueMap<String, String> requestBody = new LinkedMultiValueMap<>();

        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        requestBody.add("client_id", CLIENT_ID);
        requestBody.add("client_secret", CLIENT_SECRET);
        requestBody.add("code", code);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(requestBody, httpHeaders);
        GithubAccessToken githubAccessToken = restTemplate.postForObject(EXCHANGE_TOKEN_URL, request, GithubAccessToken.class);

        return githubAccessToken.getAccessToken();
    }

    public User getUserInformationFromToken(String githubAccessToken) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();

        headers.setBearerAuth(githubAccessToken);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);
        ResponseEntity<User> userInformation = restTemplate.exchange(REQUEST_USER_INFO_URL, HttpMethod.GET, request, User.class);

        return userInformation.getBody();
    }
}
