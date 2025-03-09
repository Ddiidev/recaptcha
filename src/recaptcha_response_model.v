module recaptcha

@[noinit]
pub struct RecaptchaResponse {
	success      bool
	score        f32
	action       string
	challenge_ts string
	hostname     string
	error_codes  []string
}
