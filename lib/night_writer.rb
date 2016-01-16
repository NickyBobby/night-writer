require 'pry'

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename).chomp
  end

  def write(sentence)
    braille_file = ARGV[1]
    File.open(braille_file, "w") { |f| f.puts sentence }
  end
end

class NightWriter
  attr_reader  :alphabet, :file_reader
  attr_accessor :multi_line, :braille_conv

  def initialize
    @reader = FileReader.new
    @alphabet = {a: ["0.","..",".."], b: ["0.","0.",".."], c: ["00","..",".."],
                 d: ["00",".0",".."], e: ["0.",".0",".."], f: ["00","0.",".."],
                 g: ["00","00",".."], h: ["0.","00",".."], i: [".0","0.",".."],
                 j: [".0","00",".."], k: ["0.","..","0."], l: ["0.","0.","0."],
                 m: ["00","..","0."], n: ["00",".0","0."], o: ["0.",".0","0."],
                 p: ["00","0.","0."], q: ["00","00","0."], r: ["0.","00","0."],
                 s: [".0","0.","0."], t: [".0","00","0."], u: ["0.","..","00"],
                 v: ["0.","0.","00"], w: [".0","00",".0"], x: ["00","..","00"],
                 y: ["00",".0","00"], z: ["0.",".0","00"], shift: ["..", "..", ".0"],
                 space: ["..","..",".."], period: ["..","00",".0"], comma: ["..","0.",".."],
                 ex_point: ["..","00","0."], q_mark: ["..","0.","00"], appos: ["..","..","0."],
                 dash: ["..","..","00"]}
    @braille_conv = []
    @multi_line = ""
  end

  def encode_file_to_braille
    # I wouldn't worry about testing this method
    # unless you get everything else done
    plain = reader.read
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(input)
    # you've taken in an INPUT string
    split_input = input.split

    # send out an OUTPUT string
  end

  def letter_ab_braille
      [alphabet[:a], alphabet[:b]]
  end

  def letter_a_braille
    alphabet[:a]
  end

  def top_line_of_braille
    alphabet[:a][0]
  end

  def one_letter_to_braille(letter)
    letter.each_char do |s|
      if s == "a"
        return alphabet[:a]
      end
    end
  end

  def letter_to_braille(letter)
    cap_arr = [alphabet[:shift]]
    if letter == letter.upcase && !" ,.?!'-".include?(letter)
      cap_arr << alphabet[letter.downcase.to_sym]
      cap_arr
    elsif letter == " "
      alphabet[:space]
    elsif letter == "."
      alphabet[:period]
    elsif letter == ","
      alphabet[:comma]
    elsif letter == "!"
      alphabet[:ex_point]
    elsif letter == "?"
      alphabet[:q_mark]
    elsif letter == "'"
      alphabet[:appos]
    elsif letter == "-"
      alphabet[:dash]
    else
      alphabet[letter.to_sym]
    end
  end

  def input_string
    FileReader.new.read
  end

  def sentence_to_braille(sentence = input_string)
   @braille_conv = sentence.chars.map do |c|
      letter_to_braille(c)
    end
  end

  def take_out_nested_arrays
    new_arr = []
    n_arr = @braille_conv.map do |find|
      if find.length == 2
        new_arr << find[0]
        new_arr << find[1]
      else
        new_arr << find
      end
    end
    n_arr[0]
  end
  def top_line_braille
    top_line = []
    take_out_nested_arrays.each do |tl|
      top_line << tl[0]
    end
    top_line
  end
  def middle_line_braille
    middle_line = []
    take_out_nested_arrays.each do |ml|
      middle_line << ml[1]
    end
    middle_line
  end
  def bottom_line_braille
    bottom_line = []
    take_out_nested_arrays.each do |bl|
      bottom_line << bl[2]
    end
    bottom_line
  end
  def output_braille
    @multi_line += top_line_braille.join+"\n"
    @multi_line += middle_line_braille.join+"\n"
    @multi_line += bottom_line_braille.join
    puts @multi_line
  end
end


puts ARGV.inspect

if __FILE__ == $0
night = NightWriter.new
night.letter_to_braille("A")
night.letter_to_braille("a")
night.sentence_to_braille

p night.take_out_nested_arrays
puts "\n \n"
night.output_braille

FileReader.new.write(night.multi_line)
end
