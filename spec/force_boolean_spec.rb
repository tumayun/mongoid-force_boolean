require File.join(File.dirname(__FILE__), 'spec_helper')

describe Mongoid::ForceBoolean do

class TestA
  include Mongoid::Document
  include Mongoid::ForceBoolean

  field :published, type: Boolean
  field :title,     type: String
  field :body,      type: String
end

  class TestB
    include Mongoid::Document
    include Mongoid::ForceBoolean

    field :title,     type: String
    field :body,      type: String
  end

  class TestC
  end

  context 'included Mongoid::Document' do
    it 'TestA.has_boolean_field? should be true' do
      TestA.should be_has_boolean_field
    end

    it 'TestA.boolean_fields should eq ["published"]' do
      TestA.boolean_fields.sort.should == ["published"]
    end

    context 'TestA#force_boolean' do

      it 'boolean field value is "0" should will become false' do
        a = TestA.new(published: "0")
        a.published.should == "0"
        a.force_boolean
        a.published.should == false
      end

      it 'boolean field value is "1" should will become true' do
        a = TestA.new(published: "1")
        a.published.should == "1"
        a.force_boolean
        a.published.should == true
      end

      it 'boolean field value is false' do
        a = TestA.new(published: false)
        a.published.should == false
        a.force_boolean
        a.published.should == false
      end

      it 'boolean field value is true' do
        a = TestA.new(published: true)
        a.published.should == true
        a.force_boolean
        a.published.should == true
      end

      it 'boolean field value is nil' do
        a = TestA.new
        a.published.should be_nil
        a.force_boolean
        a.published.should be_nil
      end

      it 'boolean field value is other values' do
        a = TestA.new(published: 100)
        a.published.should == 100
        a.force_boolean
        a.errors[:published].should == ["must be boolean"]
      end
    end

    it 'TestB.has_boolean_field? should be false' do
      TestB.should_not be_has_boolean_field
    end

    it 'TestB.boolean_fields should be empty' do
      TestB.boolean_fields.sort.should be_empty
    end
  end

  context 'no included Mongoid::Document' do
    it 'should raise Mongoid::ForceBoolean::NotMongoidDocumentError' do
      -> { TestC.send(:include, Mongoid::ForceBoolean) }.
        should raise_error(Mongoid::ForceBoolean::NotMongoidDocumentError, "The TestC class is not Mongoid::Document.")
    end
  end
end
