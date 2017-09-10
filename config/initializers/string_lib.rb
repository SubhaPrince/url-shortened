class String
  # This method generates shorten URL
  # Corresponding shorten URL
  def encode_url
    # It is based on using MD5 hashing of incoming string.
    # converting it to MD5 hash and taking the first 7 chars.
    Digest::MD5.hexdigest(self).slice(0..6)
  end
end
