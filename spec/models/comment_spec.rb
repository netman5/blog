require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'This is Gods work', post_id: 1, user_id: 148) }
  before { subject.save }

  it 'Test comment_count method ' do
    comment = subject.comment_counters(subject.post_id)
    expect(comment).to be_truthy
  end
end
