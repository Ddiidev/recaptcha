module recaptcha

import json
import net.http

const url = 'https://www.google.com/recaptcha/api/siteverify'

pub struct ParamsNew {
pub:
	token           string
	secret_key      string
	expected_action ?string
}

pub fn new(param ParamsNew) !RecaptchaResponse {
	data := 'secret=${param.secret_key}&response=${param.token}'

	resp := http.post(url, data)!
	if resp.status_code != 200 {
		return error('Falha na requisição ao Google reCAPTCHA')
	}

	result := json.decode(RecaptchaResponse, resp.body)!

	return result
}
