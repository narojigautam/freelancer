require 'spec_helper'

describe Measure do
	let(:measure) { Measure.new }

	describe "#is_valid_roman?" do
		it "returns true if number has consecuitive repeating character upto count of 3" do
			expect(measure.is_valid_roman?("MMMDCCCLXXXVIII")).to be true
	  end

		it "returns true if number has correct subtraction order" do
			expect(measure.is_valid_roman?("MCCCIXIII")).to be true
			expect(measure.is_valid_roman?("MMDCXCXII")).to be true
			expect(measure.is_valid_roman?("MMCDLVIII")).to be true
	  end

		it "returns true if number has correct use of V L and D" do
			expect(measure.is_valid_roman?("MMDLVIII")).to be true
	  end

		it "returns false if provided number is rubbish" do
			expect(measure.is_valid_roman?("GAUTAM")).to be false
	  end

		it "returns false if provided number has repeating chars upto 4" do
			expect(measure.is_valid_roman?("XXXXXIIII")).to be false
	  end

		it "returns false if provided number tries to do an invalid subtraction" do
			expect(measure.is_valid_roman?("MMXVXXXIII")).to be false
	  end

		it "returns false if provided number has repeating V L or D" do
			expect(measure.is_valid_roman?("MCCCVVII")).to be false
			expect(measure.is_valid_roman?("MMDDCCXIIII")).to be false
	  end
	end

	describe "#roman_to_digital" do
		it "returns the digital representation of a roman number" do
			expect(measure.roman_to_digital("IX")).to eq 9
			expect(measure.roman_to_digital("LXXXIX")).to eq 89
			expect(measure.roman_to_digital("MCDVI")).to eq 1406
		end
	end

	describe "#feed_foreign_measures" do
		it "stores foreign measure units" do
			measure.feed_foreign_measures(["test", "snarf", "I"])
			expect(measure.foreign_measures['snarf']).to eq "I"
		end
	end

	describe "#get_roman_representation_of" do
		it "takes foreign representation and returns its roman value" do
			measure.feed_foreign_measures(["test", "snarf", "IV"])
			expect(measure.get_roman_representation_of("snarf")).to eq "IV"
		end
	end
end