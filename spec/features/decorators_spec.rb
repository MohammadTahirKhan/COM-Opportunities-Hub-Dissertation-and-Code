require 'rails_helper'

RSpec.describe ApplicationDecorator do
  describe '.collection_decorator_class' do
    it 'returns PaginatingDecorator' do
      expect(described_class.collection_decorator_class).to eq(PaginatingDecorator)
    end
  end

  describe '#delegate_all' do
    let(:object) { double('object') }
    let(:decorator) { described_class.decorate(object) }

    it 'delegates methods to the object' do
      allow(object).to receive(:some_method).and_return('some_value')
      expect(decorator.some_method).to eq('some_value')
    end

    it 'responds to methods defined on the object' do
      allow(object).to receive(:some_method).and_return('some_value')
      expect(decorator).to respond_to(:some_method)
    end

    it 'does not respond to methods not defined on the object' do
      expect(decorator).not_to respond_to(:undefined_method)
    end
  end
end

RSpec.describe PaginatingDecorator do
    it 'inherits from Draper::CollectionDecorator' do
      expect(described_class.superclass).to eq(Draper::CollectionDecorator)
    end
  
    it 'includes Draper::AutomaticDelegation' do
      expect(described_class).to include(Draper::AutomaticDelegation)
    end
end
