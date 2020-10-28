require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validation content' do
    it 'ensures content presence' do
      post = Post.new(content: '').save
      expect(post).to eql(false)
    end
  end

  context 'negative validation test' do
    it 'ensures presence of user id and content' do
      User.new(name: 'Doyin', email: 'doyin@gmail.com', password: 'doyinreal', id: 1).save
      post = Post.new(content: 'First Post').save
      expect(post).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id and content' do
      User.new(name: 'Joshua', email: 'joshua@gmail.com', password: 'joshreal', id: 1).save
      post = Post.new(user_id: 1).save
      expect(post).to eq(false)
    end
  end
end
