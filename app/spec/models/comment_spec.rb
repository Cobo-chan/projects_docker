require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿機能' do

    context 'コメントが投稿できるとき' do
      it 'commentが存在するなら投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが投稿できずエラーを返すとき' do
      subject{ @comment.errors.full_messages }
      it 'commentが存在しないと投稿できない' do
        @comment.comment = ''
        @comment.valid?
        is_expected.to include("コメントを入力してください")
      end
      it 'commentが101文字以上だと投稿できない' do
        @comment.comment = Faker::Lorem.characters(number: 101)
        @comment.valid?
        is_expected.to include("コメントは100文字以内で入力してください")
      end
    end

  end
end
