require 'rails_helper'

describe Task, type: :model do
  it { is_expected.to belong_to :project }
  it { is_expected.to have_many :comments }

  let(:task) { FactoryGirl.create(:task) }
  before { task }

  it 'set_completed check' do
    expect(task.set_completed).to be true
  end

  it 'set_deadline check' do
    date = DateTime.now
    task.set_deadline(date)
    expect(task.deadline).to eq date
  end

  it 'increase_comments_qty check' do
    task.increase_comments_qty
    expect(task.comments_qty).to eq 1
  end

  it 'decrease_comments_qty check' do
    task.comments_qty = 1
    task.decrease_comments_qty
    expect(task.comments_qty).to eq 0
  end
end
