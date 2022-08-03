require 'rails_helper'

RSpec.describe Article, type: :model do
  
  describe '記事投稿機能' do
    before do
      @article = FactoryBot.build(:article)
    end

    context '記事投稿が成功するとき' do
      it 'title、genre_is、country_id、text、imageが入力されていれば投稿できる' do
        expect(@article).to be_valid
      end
    end

    context '記事投稿が失敗しエラーを返すとき' do
      subject { @article.errors.full_messages }
      it 'titleが存在しないと投稿できない' do
        @article.title = ''
        @article.valid?
        is_expected.to include("タイトルを入力してください")
      end
      it 'titleが1文字以下だと投稿できない' do
        @article.title = 'T'
        @article.valid?
        is_expected.to include("タイトルは2文字以上で入力してください")
      end
      it 'titleが41文字以上だと投稿できない' do
        @article.title = Faker::Lorem.characters(number: 41)
        @article.valid?
        is_expected.to include("タイトルは40文字以内で入力してください")
      end
      it 'imageが存在しないと投稿できない' do
        @article.image = nil
        @article.valid?
        is_expected.to include("画像を入力してください")
      end
      it 'genre_idが選択されていないと投稿できない' do
        @article.genre_id = 1
        @article.valid?
        is_expected.to include("ジャンルを選択して下さい")
      end
      it 'country_idが選択されていないと投稿できない' do
        @article.country_id = 1
        @article.valid?
        is_expected.to include("国を選択して下さい")
      end
      it 'textが入力されていないと投稿できない' do
        @article.text = ''
        @article.valid?
        is_expected.to include("本文を入力してください")
      end
      it 'textが1001文字以上だと投稿できない' do
        @article.text = Faker::Lorem.characters(number: 1001)
        @article.valid?
        is_expected.to include("本文は1000文字以内で入力してください")
      end
    end

    describe '記事が削除されたとき' do
      before do
        @article = FactoryBot.create(:article)
        @user = FactoryBot.create(:user)
      end

      it '記事に紐づくコメントも削除される' do
        2.times { FactoryBot.create(:comment, user: @user, article: @article)}
        expect { @article.destroy }.to change{ Comment.count }.by(-2)
      end
    end

  end
end
