require 'rails_helper'

describe User, type: :model do

  let(:user){ FactoryGirl.create(:user) }

  it "requires a password" do
    expect(user.password).to match /\A(?=.*?[a-zA-Z])(?=.*?[0-9])[\w-]{8,}\z/
  end

  it { is_expected.to allow_values('ajf67892dN', '45J8ffds', '123eF2sf').for(:password) }
  it { is_expected.not_to allow_values('1234', '#$@ff eee', '634)(&^%$#@!').for(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least 8 }

  it 'validates password error message' do
    expect{FactoryGirl.create(:user, password: '1234', password_confirmation: '1234')}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
