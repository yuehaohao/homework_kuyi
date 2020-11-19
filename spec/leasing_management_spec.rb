require_relative '../leasing_management'

RSpec.describe LeasingManagement do
  it 'has a manage_leasing instance method in LeasingManagement' do
    expect(LeasingManagement.new.manage_leasing(''))
  end
end
