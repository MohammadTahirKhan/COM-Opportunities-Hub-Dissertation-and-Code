
require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  describe 'default from address' do
    it 'uses the correct default from address' do
      expect(ApplicationMailer.default[:from]).to eq('no-reply@sheffield.ac.uk')
    end
  end

end
