require 'rails_helper'

describe Task, type: :model do
  it { is_expected.to belong_to :project}
end
