# spec/models/application_record_spec.rb
require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'abstract class' do
    it 'is an abstract class' do
      expect(ApplicationRecord.abstract_class).to be_truthy
    end
  end
end
