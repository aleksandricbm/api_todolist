require 'rails_helper'

describe Project, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :tasks }

end
