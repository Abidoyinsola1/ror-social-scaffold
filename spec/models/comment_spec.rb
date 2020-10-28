require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validation content' do
    it 'ensures content presence' do
      comment = Comment.new(content: '').save
      expect(comment).to eql(false)
    end
  end

  context 'positive validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Doyin', email: 'doyin@gmail.com', password: 'doyinreal', id: 1).save
      Post.new(content: 'Hi, I am here now', user_id: 1, id: 1).save
      comment = Comment.new(user_id: 1, post_id: 1, content: 'First Comment').save
      expect(comment).to eq(true)
    end
  end

  context 'negative validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Ayomide', email: 'ayomide@gmail.com', password: 'ayoreal', id: 1).save
      Post.new(content: 'Are you there?', user_id: 1, id: 1).save
      comment = Comment.new(user_id: 1, post_id: 1).save
      expect(comment).to eq(false)
    end
  end

  context 'negative validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Samuel', email: 'samuel@gmail.com', password: 'sammie', id: 1).save
      Post.new(content: 'Sammie is good', user_id: 1, id: 1).save
      comment = Comment.new(user_id: 1, content: 'First Comment').save
      expect(comment).to eq(false)
    end
  end

  context 'negative validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Brian', email: 'brian@gmail.com', password: 'brianreal', id: 1).save
      Post.new(content: 'Watch football', user_id: 1, id: 1).save
      comment = Comment.new(post_id: 1, content: 'First Comment').save
      expect(comment).to eq(false)
    end
  end
end
