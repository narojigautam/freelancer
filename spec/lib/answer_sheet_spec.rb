require 'spec_helper'

describe AnswerSheet do
	let(:measure) { Measure.new }
	let(:resource_mgr) { ResourceManager.new(measure) }
	let(:answer_sheet) { AnswerSheet.new(measure, resource_mgr, AnswerFormatter) }

  describe "#answer_for" do
		it "formats and returns value of a roman number" do
			measure.feed_foreign_measures(["test", "gautam", "I"])
			measure.feed_foreign_measures(["test", "naroji", "V"])
			expect(answer_sheet.answer_for("gautam naroji")).to eq "gautam naroji is 4"
		end

		it "formats and returns credits value of a resource" do
			measure.feed_foreign_measures(["test", "gautam", "I"])
			measure.feed_foreign_measures(["test", "naroji", "V"])
			resource_mgr.add_resource(["test", "gautam", "test", "test", "gold", 12])
			expect(answer_sheet.answer_for("gautam naroji", "gold")).to eq "gautam naroji gold is 48 Credits"
		end
  end
end
