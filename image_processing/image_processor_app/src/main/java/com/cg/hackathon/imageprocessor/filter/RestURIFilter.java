package com.cg.hackathon.imageprocessor.filter;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class RestURIFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger(RestURIFilter.class);

	private static final String VALID_URI_REGEX = "[^a-z0-9A-Z/&.?]";

	private static final String IPAdapter_URI = "/api/imageprocessor/receiveFile";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String requestUri = httpRequest.getRequestURI();

		logger.info("The request uri is :" + requestUri);

		String[] requestURIArr = requestUri.split(IPAdapter_URI);
		String parameterValue = "";

		if (requestURIArr.length > 1) {
			parameterValue = requestURIArr[1];
			httpResponse = validateURI(httpResponse, parameterValue);
			if (httpResponse.getStatus() == HttpServletResponse.SC_BAD_REQUEST) {
				return;
			}
		}

		if (!requestUri.contains(IPAdapter_URI)) {
			httpResponse = validateURI(httpResponse, requestUri);
			if (httpResponse.getStatus() == HttpServletResponse.SC_BAD_REQUEST) {
				return;
			}
		}
		chain.doFilter(httpRequest, httpResponse);
	}

	public HttpServletResponse validateURI(HttpServletResponse httpResponse, String value) throws IOException {
		Pattern p = Pattern.compile(VALID_URI_REGEX, Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(value);
		if (m.find()) {
			logger.error("Invalid syntax " + value);
			httpResponse = getBadRequestResponse(httpResponse);
		}
		return httpResponse;
	}

	public HttpServletResponse getBadRequestResponse(HttpServletResponse httpResponse) throws IOException {
		httpResponse.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		httpResponse.getWriter().print("<html><head><title>BAD REQUEST</title></head>");
		httpResponse.getWriter().print(
				"<body><b><font color='red'>BAD REQUEST 400 </font></b> <br /> The uri should not contain special characters like [*,$,etc]</body>");
		httpResponse.getWriter().println("</html>");
		return httpResponse;
	}

	@Override
	public void destroy() {
	}

}