require_relative '../leasing'

RSpec.describe Leasing do
  describe 'initialize' do
    it 'should create a object of leasing' do
      expect(Leasing.new).to success
    end

    it 'should create a leasing with error if argument empty' do
      leasing = Leasing.new
      expect(leasing.errors.length).to eq(1)
      expect(leasing.errors.first.message).to eq('argument cannot be empty')
    end

    it 'should create a leasing with error if date cannot be parse' do
      leasing = Leasing.new('typo, typo, typo, typo')
      expect(leasing.errors.length).to eq(1)
      expect(leasing.errors.first.message).to eq('start date is not valid')
    end

    it 'should create a leasing with error if end date smaller than start date' do
      leasing = Leasing.new('20200805, 20200305, typo, typo')
      expect(leasing.errors.length).to eq(1)
      expect(leasing.errors.first.message)
        .to eq('start date should be smaller than end_date')
    end

    it 'should set start_date, end_date, rent, payment_period correctly' do
      leasing = Leasing.new('20200101, 20201231, 1000, 3')
      expect(leasing.errors).to be_empty
      expect(leasing.start_date).to eq(Date.new('20200101'))
      expect(leasing.end_date).to eq(Date.new('20201231'))
      expect(leasing.rent).to eq(1000)
      expect(leasing.payment_period).to eq(3)
    end
  end
end
