class Main
  CHARSET = {
    "(" => ")",
  }.freeze

  def self.run(input)
    length = input.length
    openers = []
    closers = []
    chars = input.split("")
    chars.each_with_index do |char, index|
      if CHARSET.keys.include?(char)
        openers << [char, index]
      elsif CHARSET.values.include?(char)
        closers << [char, index]
      end
    end

    if openers.length == closers.length
      return "This is valid"
    end
    output = "#{input}\n"
    pointer = " " * length + "\n"
    openers.each_with_index do |(char, i), index|
      if closers.fetch(index, [])[0] != CHARSET[char]
        pointer[i] = "^"
      end
    end
    output += pointer
    puts output
    output
  end
end
