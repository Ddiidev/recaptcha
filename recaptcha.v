module recaptcha

import json
import net.http

/// ParamsNew contains the data required to validate a Cloudflare Turnstile token.
///
/// `expected_action` is kept as part of the public contract, but validation is
/// explicit: call `RecaptchaResponse.is_action` when the application requires
/// a specific action.
pub struct ParamsNew {
pub:
	token           string
	secret_key      string
	expected_action ?string
}

const url = 'https://challenges.cloudflare.com/turnstile/v0/siteverify'

/// new validates a Turnstile token with Cloudflare Siteverify and returns the
/// decoded response.
///
/// The request sends only the secret key and client token to Cloudflare. The
/// caller is responsible for checking `is_valid` and, when needed, `is_action`
/// on the returned response.
pub fn new(param ParamsNew) !RecaptchaResponse {
	body := json.encode({
		'secret':   param.secret_key
		'response': param.token
	})

	resp := http.post_json(url, body)!
	if resp.status_code != 200 {
		return error('Falha na requisição ao Cloudlare CAPTCHA')
	}

	result := json.decode(RecaptchaResponse, resp.body)!

	return result
}
