require 'spec_helper'

describe Ardm::Property::Class do
  before do
    Object.send(:remove_const, :Foo) if defined?(Foo)
    Object.send(:remove_const, :Bar) if defined?(Bar)

    class ::Foo; end
    class ::Bar; end
  end

  let(:name)          { :type }
  let(:type)          { described_class }
  let(:options)       { {} }
  let(:value)         { Foo }
  let(:other_value)   { Bar }
  let(:invalid_value) { 1 }
  let(:model) { Blog::Article }
  let(:property) { type.new(model, name, options) }

  it_should_behave_like 'A semipublic Property'

  describe '#typecast' do
    it 'returns same value if a class' do
      expect(property.typecast(model)).to equal(model)
    end

    it 'returns the class if found' do
      expect(property.typecast(model.name)).to eql(model)
    end

    it 'does not typecast non-class values' do
      expect(property.typecast('NoClass')).to eql('NoClass')
    end
  end
end
