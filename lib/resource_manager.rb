class ResourceManager
  attr_accessor :resources

  def initialize(measure)
    @measure = measure
    @resources = {}
  end

  # adds resource to resources and its equivalent
  # value for one measure
  def add_resource(resource)
    roman_measures = @measure.get_roman_representation_of(resource[1])
    total_credits = resource[5].to_i
    if @measure.is_valid_roman?(roman_measures)
      @resources[resource[4]] = find_value_for_one_measure(roman_measures, total_credits)
    end
  end

  # takes total measures of a resource and its total credit value
  # returns value for one measure of the supplied resource in digital form
  def find_value_for_one_measure(total_measures, total_credits)
    total_credits.to_f / @measure.roman_to_digital(total_measures)
  end

  # finds the credits for the amount of measure entered
  def find_value_for(resource, quantity)
    quantity * resources[resource]
  end
end
