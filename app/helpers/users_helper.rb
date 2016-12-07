module UsersHelper
  def gravatar_for user, options = {size: Settings.avatar_default_size}
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = option[:size]
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
