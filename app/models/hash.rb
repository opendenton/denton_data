class Hash
  def downcase_key
    keys.each do |k|
      store(k.downcase, Array === (v = delete(k)) ? v.map(&:downcase_key) : v)
    end
    self
  end
end