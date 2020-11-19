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

  describe 'to_s' do
    it 'should output 1 month rent period infomation' do
      leasing = Leasing.new('20200101, 20200331, 1000, 1')
      expect(leasing.to_s).to eq("
        leasing periods:\n
        1.\n
        range: 2020-01-01 ~ 2020-01-31\n
        rent: 1000\n
        payment_date: 2020-01-01\n
        2.\n
        range: 2020-02-01 ~ 2020-02-29\n
        rent: 1000\n
        payment_date: 2020-01-15\n
        3.\n
        range: 2020-03-01 ~ 2020-03-31\n
        rent: 1000\n
        payment_date: 2020-02-15\n
      ")
    end

    it 'should output 2 month rent period infomation' do
      leasing = Leasing.new('20200101, 20200630, 1000, 2')
      expect(leasing.to_s).to eq("
        leasing periods:\n
        1.\n
        range: 2020-01-01 ~ 2020-02-29\n
        rent: 2000\n
        payment_date: 2020-01-01\n
        2.\n
        range: 2020-03-01 ~ 2020-04-30\n
        rent: 2000\n
        payment_date: 2020-02-15\n
        3.\n
        range: 2020-05-01 ~ 2020-06-30\n
        rent: 2000\n
        payment_date: 2020-04-15\n
      ")
    end

    it 'should output rent according to days if month is not a whole' do
      leasing = Leasing.new('202001015, 20200315, 930, 1')
      expect(leasing.to_s).to eq("
        leasing periods:\n
        1.\n
        range: 2020-01-15 ~ 2020-01-31\n
        rent: 510\n
        payment_date: 2020-01-15\n
        2.\n
        range: 2020-02-01 ~ 2020-02-29\n
        rent: 930\n
        payment_date: 2020-01-15\n
        3.\n
        range: 2020-03-01 ~ 2020-03-15\n
        rent: 450\n
        payment_date: 2020-02-15\n
      ")
    end

    it 'should output the first day of leasing if payment date is out of range' do
      leasing = Leasing.new('202001016, 20200315, 930, 1')
      expect(leasing.to_s).to eq("
        leasing periods:\n
        1.\n
        range: 2020-01-16 ~ 2020-01-31\n
        rent: 480\n
        payment_date: 2020-01-16\n
        2.\n
        range: 2020-02-01 ~ 2020-02-29\n
        rent: 930\n
        payment_date: 2020-01-16\n
        3.\n
        range: 2020-03-01 ~ 2020-03-15\n
        rent: 450\n
        payment_date: 2020-02-15\n
      ")
    end
  end
end
