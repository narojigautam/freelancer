class AnswerSheet

	def initialize(measure, resource_mgr, formatter)
		@measure = measure
		@resource_mgr = resource_mgr
		@formatter = formatter
	end

	def answer_for(quantity, resource = nil)
		roman_qty = @measure.get_roman_representation_of(quantity)
		digital_qty = @measure.roman_to_digital(roman_qty)
		answer = resource ? @resource_mgr.find_value_for(resource.strip, digital_qty) : digital_qty
		formatted_answer = @formatter.new(quantity.strip, resource, answer)
		formatted_answer.to_s
	end

	def invalid_input_answer
		@formatter.alert_for_invalid
	end
end
