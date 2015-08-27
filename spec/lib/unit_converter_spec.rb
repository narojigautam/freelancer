require 'spec_helper'

describe UnitConverter do
	let(:input_data) { """glob is I
prok is V
pish is X
tegj is L
glob glob Silver is 34 Credits
glob prok Gold is 57800 Credits
pish pish Iron is 3910 Credits
how much is pish tegj glob glob ?
how many Credits is glob prok Silver ?
how many Credits is glob prok Gold ?
how many Credits is glob prok Iron ?
how much wood could a woodchuck chuck if a woodchuck could chuck wood ?""" }

	let(:unit_converter) { UnitConverter.new(input_data) }
	let(:expected_output) { """pish tegj glob glob is 42
glob prok Silver is 68 Credits
glob prok Gold is 57800 Credits
glob prok Iron is 782 Credits
I have no idea what you are talking about""" }

	describe "#generate_result" do
		it "generates formatted output for the provided input" do
			expect(unit_converter.generate_result).to eq(expected_output)
		end
	end

	describe "#units_mapping_regex" do
		it "matches the names of foreign measuring units" do
			match = "prok is V".match(unit_converter.units_mapping_regex)
			expect(match).to_not be nil
			expect(match[1]).to eq "prok"
			expect(match[2]).to eq "V"
		end
	end

	describe "#resource_value_regex" do
		it "returns the resouce value regular expression embedded with foreign keys" do
			expect(unit_converter.resource_value_regex(["proc","pish"])).to eq(/^(((proc|pish)\s)+)([\w]+)\sis\s([\d]+)\sCredits$/)
		end
	end

	describe "#questions_regex" do
		it "returns the resouce value regular expression embedded with foreign keys" do
			expect(unit_converter.questions_regex(["proc","pish"], ["Silver"])).to eq(/(((proc|pish)\s)+)(Silver)*\s*\?$/)
		end
	end

	describe "#any_question_regex" do
		it "matches any question" do
			expect("Who am I?".match(unit_converter.any_question_regex)).to_not be nil
		end
	end
end
