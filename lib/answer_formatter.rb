class AnswerFormatter
  def initialize(quantity, resource, answer)
    @quantity = quantity
    @resource = resource
    @answer = answer
  end

  def to_s
    "#{@quantity}#{@resource ? ' ' + @resource : '' } is #{@answer.to_i}#{@resource ? ' Credits' : ''}"
  end

  def self.alert_for_invalid
    "I have no idea what you are talking about"
  end
end
