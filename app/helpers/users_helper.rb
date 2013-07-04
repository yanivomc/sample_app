module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 100, custom_avatar: "mm" })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    avatar = options[:custom_avatar]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=#{avatar}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end