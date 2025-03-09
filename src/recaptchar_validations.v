module recaptcha

pub fn (rcap RecaptchaResponse) is_valid() bool {
	return rcap.success
}

pub fn (rcap RecaptchaResponse) is_action(action string) bool {
	return rcap.action == action 
}

pub fn (rcap RecaptchaResponse) is_score(score f32) bool {
	return rcap.score >= score
}
