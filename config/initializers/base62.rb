class Base62
  ENCODER = Hash.new do |h,k|
    # Converts String to a Hash
    Hash[ k.chars.map.with_index.to_a.map(&:reverse) ]
  end
  #<summary>
  #This method generates shorten URL
  # </summary>
  # <param name="value">Epoch Token</param>
  # <returns>Corresponding shorten URL</returns>
  def self.encode( value )
    # Constructing and avoing some words which makes confused
    base62 = ([ *0..9, *'a'..'z', *'A'..'Z' ] - %w[i I 1 l 0 O 0]).join
    ring = ENCODER[base62]
    base = base62.length
    result = []
    until value == 0
      result << ring[ value % base ]
      value /= base
    end
    result.reverse.join
  end
end
