class String
  # the following method is based on: 
  # http://blog.macromates.com/2006/wrapping-text-with-regular-expressions/
  def wrap(col = 80)
    self.gsub(/(.{1,#{col}})(?: +|$\n?)|(.{1,#{col}})/,"\\1\\2\n") 
  end

  def wrap_with_dash(col = 80)
    self.gsub(/(.{1,#{col}})( +|$)\n?|(.{#{col-1}})-?/) do
      ($1 ? $1 : $3 + "-") + "\n"
    end
  end
end
