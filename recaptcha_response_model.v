module recaptcha

@[noinit]
pub struct RecaptchaResponse {
pub mut:
	success      bool     @[omitempty]
	challenge_ts string   @[omitempty]
	hostname     string   @[omitempty]
	error_codes  []string @[json: 'error-codes'; omitempty]
	action       string   @[omitempty]
	cdata        string   @[omitempty]
}
