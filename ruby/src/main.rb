class Main
  CHARSET = {
    "{" => "}",
    "(" => ")",
    "[" => "]",
  }.freeze

  class << self
    def assess(input)
      length = input.length
      openers = []
      closers = []
      chars = input.split("")
      chars.each_with_index do |char, index|
        if CHARSET.keys.include?(char)
          openers << [char, index]
        elsif CHARSET.values.include?(char)
          closers.unshift([char, index])
        end
      end

      error = nil

      if openers.length > closers.length
        error = find_mismatch(openers, closers)
        message = "Unclosed #{error[:character]} at index #{error[:index]}"
      elsif closers.length > openers.length
        error = find_mismatch(closers, openers)
        message = "Unopened #{error[:character]} at index #{error[:index]}"
      else
        message = "This is valid"
      end
      message
    end

    def run(input)
      puts assess(input)
    end

    private

    def find_mismatch(first_array, second_array)
      error = nil
      first_array.each_with_index do |(char, i), index|
        expected = CHARSET.keys.include?(char) ? CHARSET[char] : CHARSET.invert[char]
        if second_array.fetch(index, [])[0] != expected
          error = {character: char, index: i}
          break
        end
      end
      error
    end
  end
end
