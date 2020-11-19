require_relative '../leasing'
require 'date'

RSpec.describe Leasing do
  describe 'initialize' do
    it 'should create a object of leasing' do
      expect(Leasing.new(''))
    end

    it 'should create a leasing with error if argument num is not 4' do
      leasing = Leasing.new('')
      expect(leasing.errors.first.message).to eq('Argument number not correct.')
    end

    it 'should create a leasing with error if date cannot be parse' do
      leasing = Leasing.new('typo, typo, typo, typo')
      expect(leasing.errors.first.message).to eq('Start date is not valid.')
    end

    it 'should create a leasing with error if end date smaller than start date' do
      leasing = Leasing.new('20200805, 20200305, typo, typo')
      expect(leasing.errors.first.message)
        .to eq('Start date should be smaller than end_date.')
    end

    it 'should set start_date, end_date, rent, payment_period correctly' do
      leasing = Leasing.new('20200101, 20201231, 1000, 3')
      expect(leasing.errors).to be_empty
      expect(leasing.start_date).to eq(Date.parse('20200101'))
      expect(leasing.end_date).to eq(Date.parse('20201231'))
      expect(leasing.rent).to eq(1000)
      expect(leasing.payment_period).to eq(3)
    end
  end
end
