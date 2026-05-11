module recaptcha

import json
import net.http

pub struct ParamsNew {
pub:
	token           string
	secret_key      string
	expected_action ?string
}

const url = 'https://challenges.cloudflare.com/turnstile/v0/siteverify'

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
