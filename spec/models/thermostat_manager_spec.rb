require 'rails_helper'

RSpec.describe ThermostatManager, type: :model do
  subject(:manager) { described_class.new }

  describe 'class' do
    it 'respond_to' do
      expect(manager).to respond_to(:id)
      expect(manager).to respond_to(:mode)
      expect(manager).to respond_to(:status)
      expect(manager).to respond_to(:data)
    end
  end
end
