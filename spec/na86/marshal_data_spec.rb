# data_spec.rb

require 'spec_helper'

describe NA86::MarshalData do
    describe "#self.factory" do
        it "creates a new MarshalData object when data=nil" do
            md = NA86::MarshalData.factory
            md.should.kind_of? NA86::MarshalData
            md.should_not be_nil
        end

        it "creates a new MarshalData object from data" do
            md1 = NA86::MarshalData.new
            data = md1.serialize
            md2 = NA86::MarshalData.factory data
            md2.should_not be nil
            md2.should.kind_of? NA86::MarshalData
            md2.should.eql? md1
        end

        it "throws an exception when the wrong data is used" do
            o = Object.new
            data = Marshal::dump o
            expect { md = NA86::MarshalData.factory data }.to raise_error( NA86::Exceptions::NotMarshalData )
        end
    end
end
