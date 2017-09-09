class Base36

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
    base36 = "0123456789abcdefghijklmnopqrstuvwxyz"
    ring = ENCODER[base36]
    base = base36.length
    result = []
    until value == 0
      result << ring[ value % base ]
      value /= base
    end
    result.reverse.join
  end

end
