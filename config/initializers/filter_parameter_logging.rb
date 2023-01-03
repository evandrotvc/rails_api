# frozen_string_literal: true

# Be sure to restart your server when you modify this file.
# notations and behaviors.
Rails.application.config.filter_parameters += %i[
  passw secret token _key crypt salt certificate otp ssn
]
