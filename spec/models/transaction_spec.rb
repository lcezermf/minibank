require 'spec_helper'

describe Transaction do

  context 'associations' do
    it { should belong_to :account }
  end

  context 'validations' do
    context 'presence' do
      [:quantity].each do |value|
        it { should validate_presence_of value }
      end
    end

    context 'numericality' do
      [:quantity].each do |value|
        it { should validate_numericality_of(value) }
        it { should_not allow_value(-1).for value }
      end
    end
  end

  context 'operations' do
    it 'entry?' do
      account = create :account
      transaction = create :transaction, operation: 'entry',
        account_id: account.id
      expect(transaction.entry?).to be_true
    end
    it 'deposit?' do
      account = create :account
      transaction = create :transaction, operation: 'deposit',
        account_id: account.id
      expect(transaction.deposit?).to be_true
    end
    it 'transfer?' do
      account = create :account
      account_two = create :account
      transaction = create :transaction, operation: 'transfer',
        account_id: account.id, account_destiny_id: account_two.id
      expect(transaction.transfer?).to be_true
    end
  end

  context 'account_destiny_id' do
    it 'when transaction is a deposit or a entry, account_destiny_id need be nil' do
      transaction = build :transaction, operation: 'entry', quantity: 100
      expect(transaction.account_destiny_id).to be_nil
    end
    it 'validate presence of account_destiny_id for a transfers operation' do
      user = create :user
      user_two = create :user

      account = create :account, user_id: user.id
      account_two = create :account, user_id: user_two.id

      transaction = create :transaction, operation: 'transfer', quantity: 100,
        account_destiny_id: account_two.id , account_id: account.id
      transaction.should validate_presence_of(:account_destiny_id)
    end
  end

  # context 'transfer' do
  #   context 'account_destiny_id must be a existent and valid account' do
  #     let(:user) { create :user }
  #     let(:account) { create :account, user_id: user.id }

  #     let(:user_two) { create :user }
  #     let(:account_two) { create :account, user_id: user_two.id }

  #     it 'fail for invalid account_destiny_id' do
  #       transaction = create :transaction, account_id: account.id, quantity: 100,
  #         account_destiny_id: 10, operation: 'transfer'
  #       expect(transaction).not_to be_valid
  #     end
  #   end
  # end

end