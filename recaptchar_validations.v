module recaptcha

/// is_valid reports whether Cloudflare accepted the token.
pub fn (rcap RecaptchaResponse) is_valid() bool {
	return rcap.success
}

/// is_action reports whether the response action exactly matches `action`.
pub fn (rcap RecaptchaResponse) is_action(action string) bool {
	return rcap.action == action
}
