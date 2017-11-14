require 'rails_helper'

RSpec.describe Ability, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:task) { FactoryGirl.create(:task, project_id: project.id) }
  let(:comment) { FactoryGirl.create(:comment, task_id: task.id) }

  it 'Project' do
    assert ability.can?(:read, project)
    assert ability.cannot?(:destroy, Project.new)
  end

  it 'Task' do
    assert ability.can?(:read, task )
    assert ability.cannot?(:read, Task.new)
  end

  it 'Comment' do
    assert ability.can?(:read, comment)
    assert ability.cannot?(:create, Comment.new)
  end
end
