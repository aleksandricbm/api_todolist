require 'rails_helper'

describe Comment, type: :model do
  it { is_expected.to belong_to :task }

  it 'file_size check' do
    expect{FactoryGirl.create(:comment, :include_long_file)}.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: File long')
  end
end
