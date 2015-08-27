class Measure

  attr_accessor :foreign_measures

  def initialize
    @foreign_measures = {}
  end

  def roman_measures
    {
      "I" => 1,
      "V" => 5,
      "X" => 10,
      "L" => 50,
      "C" => 100,
      "D" => 500,
      "M" => 1000
    }
  end

  # expects a regexp match which will provide foregin measure name
  # on index 1 and its equivalent roman measure on index 2
  def feed_foreign_measures(input_line)
    @foreign_measures[input_line[1]] = input_line[2]
  end

  # finds the roman representation of a foreign measure
  # format: measure measure measure, space separated
  def get_roman_representation_of(input_measures)
    input_measures.split(" ").map {|input_measure| convert_foreign_to_roman(input_measure) }.join("")
  end

  # checks if a roman number is valid or not
  def is_valid_roman?(number)
    return false if number.match(/(IIII|XXXX|CCCC|MMMM)+/)
    return false if number.match(/(VV|LL|DD)+/)
    numarr = number.split("")
    response = true
    numarr.each_with_index do |num, id|
      response = case num
        when "I"
          return false if numarr[id+1] and roman_measures[numarr[id+1]] > 10
          true
        when "V"
          return false if numarr[id+1] and roman_measures[numarr[id+1]] > 5
          true
        when "X"
          return false if numarr[id+1] and roman_measures[numarr[id+1]] > 100
          true
        when "L"
          return false if numarr[id+1] and roman_measures[numarr[id+1]] > 50
          true
        when "C"
          true
        when "D"
          return false if numarr[id+1] and roman_measures[numarr[id+1]] > 500
          true
        when "M"
          true
        else
          return false
        end
    end
    response
  end

  # convert roman number to digital
  # make sure the passed number is a roman before use
  def roman_to_digital(roman_number)
    total = 0
    roman_arr = roman_number.split("")
    roman_arr.each_with_index do |num, id|
      if roman_arr[id+1] and roman_measures[num] < roman_measures[roman_arr[id+1]]
        total -= roman_measures[num]
      else
        total += roman_measures[num]
      end
    end
    total
  end

  private
  
  # accepts a foreign measure unit and returns a roman value
  def convert_foreign_to_roman(measure)
    @foreign_measures[measure]
  end
end
