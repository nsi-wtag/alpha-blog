# frozen_string_literal: true

module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}"

    image_tag(gravatar_url, alt: user.username)
  end
end
