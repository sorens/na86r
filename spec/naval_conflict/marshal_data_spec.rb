# data_spec.rb

require 'spec_helper'

describe NavalConflict::MarshalData do
    describe "#self.factory" do
        it "creates a new MarshalData object when data=nil" do
            md = NavalConflict::MarshalData.factory
            md.should.kind_of? NavalConflict::MarshalData
            md.should_not be_nil
        end

        it "creates a new MarshalData object from data" do
            md1 = NavalConflict::MarshalData.new
            data = md1.serialize
            md2 = NavalConflict::MarshalData.factory data
            md2.should_not be nil
            md2.should.kind_of? NavalConflict::MarshalData
            md2.should.eql? md1
        end

        it "throws an exception when the wrong data is used" do
            o = Object.new
            data = Marshal::dump o
            expect { md = NavalConflict::MarshalData.factory data }.to raise_error( NavalConflict::Exceptions::NotMarshalData )
        end
    end
end