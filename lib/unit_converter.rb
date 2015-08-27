class UnitConverter
  def initialize(input_data)
    @input_data = input_data
    @measure = Measure.new
    @resource_mgr = ResourceManager.new(@measure)
    @answer_sheet = AnswerSheet.new(@measure, @resource_mgr, AnswerFormatter)
    parse_input
  end

  # parses the provided input into required formats
  def parse_input
    @input_data.split("\n").each do |line|
      line.strip!
      next unless line
      if values = line.match(units_mapping_regex)
        @measure.feed_foreign_measures(values)
      elsif resource = line.match(resource_value_regex(@measure.foreign_measures.keys))
        @resource_mgr.add_resource(resource)
      end
    end
  end

  # prints the answers to questions provided in input
  def generate_result
    output = ""
    @input_data.split("\n").each do |line|
      line.strip!
      next unless line
      if asked_q = line.match(questions_regex(@measure.foreign_measures.keys, @resource_mgr.resources.keys))
        output += @answer_sheet.answer_for(asked_q[1], asked_q[4]) + "\n"
      elsif asked_q = line.match(any_question_regex)
        output += @answer_sheet.invalid_input_answer + "\n"
      end
    end
    output.strip
  end

  # regex to match names of foreign measure units
  def units_mapping_regex
    /^([\w]+)\sis\s([IVXLCDM])$/
  end

  # generates a regular expression needed to match resource values
  def resource_value_regex foreign_measures
    Regexp.new("^(((#{foreign_measures.join("|")})\\s)+)([\\w]+)\\sis\\s([\\d]+)\\sCredits$")
  end

  # generates a regular expression needed to match a valid questions asked
  def questions_regex foreign_measures, resources
    Regexp.new("(((#{foreign_measures.join("|")})\\s)+)(#{resources.join("|")})*\\s*\\?$")
  end

  def any_question_regex
    /^[how]+.+\?$/i
  end
end
