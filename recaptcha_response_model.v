module recaptcha

/// RecaptchaResponse represents the decoded response returned by Cloudflare
/// Siteverify. Field names and JSON tags mirror the remote API response.
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
