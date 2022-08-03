require 'rails_helper'

RSpec.describe "Articles", type: :system do

  describe '記事投稿' do
    let(:user) { FactoryBot.create(:user) }

    context '記事が投稿できるとき' do
      it 'ログインしたユーザーは記事を投稿できること' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        expect(page).to have_content('投稿する')
        click_link('投稿する')
        expect(current_path).to eq(new_article_path)
        image_file = Rails.root.join('public/images/default_icon.png')
        attach_file('article[image]', image_file)
        fill_in 'article_title', with: 'テストタイトル'
        select 'クラシック', from: 'ジャンル' 
        select 'アフガニスタン', from: '国'
        fill_in 'article_text', with: 'テスト本文'
        expect{ find('input[name="commit"]').click }.to change{ Article.count }.by(1)
        expect(current_path).to eq(root_path)
        expect(page).to have_selector("img[src$='default_icon.png']")
        expect(page).to have_content('記事を作成しました')
      end
    end

    context '記事が投稿できないとき' do
      it 'ログインしていないと投稿ページへ移動できない' do
        visit root_path
        expect(page).to have_no_content('投稿する')
      end
    end
    
  end

  describe '記事編集と削除' do
    let!(:article) { FactoryBot.create(:article) }
    let(:user) { article.user }
    let(:not_created_user) { FactoryBot.create(:user) }

    context '記事が編集できるとき' do
      it 'ユーザーがログインしており、かつ記事を投稿したユーザーだと編集できること' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        click_link 'テストタイトル', href: article_path(article)
        expect(current_path).to eq(article_path(article))
        expect(page).to have_content('編集')
        click_link('編集')
        expect(current_path).to eq(edit_article_path(article))
        fill_in 'article_title', with: '編集済み'
        find('input[name="commit"]').click
        expect(current_path).to eq(article_path(article))
        expect(page).to have_content('更新しました')
        expect(page).to have_content('編集済み')
      end
    end

    context '記事が編集できないとき' do
      it 'ユーザーがログインしていても投稿者本人でなければ編集リンクが表示されないこと' do
        visit new_user_session_path
        fill_in 'user_email', with: not_created_user.email
        fill_in 'user_password', with: not_created_user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        click_link('テストタイトル')
        expect(current_path).to eq(article_path(article))
        expect(page).to have_no_content('編集')
      end
    end
    
    context '記事が削除できるとき' do
      it 'ユーザーがログインしており、かつ記事を投稿したユーザー自身だと削除できること' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        click_link('テストタイトル')
        expect(current_path).to eq(article_path(article))
        expect(page).to have_content('削除')
        page.accept_confirm('本当に削除しますか？') do
          click_on('削除')
        end
        expect(current_path).to eq(root_path)
        expect(page).to have_content('記事を削除しました')
      end
    end

    context '記事が削除できないとき' do
      it 'ユーザーがログインしていても投稿者本人でなければ削除リンクが表示されないこと' do
        visit new_user_session_path
        fill_in 'user_email', with: not_created_user.email
        fill_in 'user_password', with: not_created_user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        click_link('テストタイトル')
        expect(current_path).to eq(article_path(article))
        expect(page).to have_no_content('削除')
      end
    end
  end
end
