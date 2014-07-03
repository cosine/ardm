require 'spec_helper'

try_spec do

  require './spec/fixtures/person'

  describe Ardm::Fixtures::Person do
    before do
      @resource = Ardm::Fixtures::Person.new(:name => '')
    end

    describe 'with no interests information' do
      before do
        @resource.interests = nil
      end

      describe 'when dumped and loaded again' do
        before do
          @resource.save.should be_truthy
          @resource.reload
        end

        it 'has no interests' do
          @resource.interests.should == nil
        end
      end
    end

    describe 'with no interests information' do
      before do
        @resource.interests = []
      end

      describe 'when dumped and loaded again' do
        before do
          @resource.save.should be_truthy
          @resource.reload
        end

        it 'has empty interests list' do
          @resource.interests.should == []
        end
      end
    end

    describe 'with interests information given as a Hash' do
      it 'raises ArgumentError' do
        lambda do
          @resource.interests = { :hash => 'value' }
          @resource.save
        end.should raise_error(ArgumentError, /must be a string, an array or nil/)
      end
    end

    describe 'with a few items on the interests list' do
      before do
        @input = 'fire, water, fire, a whole lot of other interesting things, ,,,'
        @resource.interests = @input
      end

      describe 'when dumped and loaded again' do
        before do
          @resource.save.should be_truthy
          @resource.reload
        end

        it 'includes "fire" in interests' do
          @resource.interests.should include('fire')
        end

        it 'includes "water" in interests' do
          @resource.interests.should include('water')
        end

        it 'includes "a whole lot of other interesting things" in interests' do
          @resource.interests.should include('a whole lot of other interesting things')
        end

        it 'has blank entries removed' do
          @resource.interests.any? { |i| Ardm::Ext.blank?(i) }.should be_falsey
        end
      end
    end
  end
end
