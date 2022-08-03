require 'rails_helper'

RSpec.describe "Comments", type: :system do
  
  describe 'コメント投稿機能' do
    let(:user) { FactoryBot.create(:user) }
    let!(:article) { FactoryBot.create(:article) }

    context 'コメントが投稿できるとき' do
      it 'ユーザーがログインしているとコメントが送信できる' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        click_link 'テストタイトル', href: article_path(article)
        expect(current_path).to eq(article_path(article))
        fill_in 'comment_comment', with: 'テスト'
        click_on 'コメント送信'
        expect(current_path).to eq(article_path(article))
        expect(page).to have_content('コメントを投稿しました')
      end
    end

    context 'コメントが投稿できないとき' do
      it 'ユーザーがログインしていないとコメントは送信できない' do
        visit root_path
        click_link 'テストタイトル', href: article_path(article)
        expect(current_path).to eq(article_path(article))
        expect(page).to have_content('※ログインユーザーのみコメント可能です')
      end
    end

  end

  describe 'コメント削除機能' do
    let(:article) { FactoryBot.create(:article) }
    let(:article_user) { article.user }
    let(:comment) { FactoryBot.create(:comment, article: article) }
    let(:comment_user) { comment.user }

    context 'コメントを削除できるとき' do
      it 'ログインしておりコメントを投稿したユーザーだと削除できる' do
        visit new_user_session_path
        fill_in 'user_email', with: comment_user.email
        fill_in 'user_password', with: comment_user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        click_link 'テストタイトル', href: article_path(article)
        expect(current_path).to eq(article_path(article))
        expect(page).to have_link '削除', href: article_comment_path(article, comment)
        page.accept_confirm('本当に削除しますか？') do
          click_link '削除', href: article_comment_path(article, comment)
        end
        expect(current_path).to eq(article_path(comment.article))
        expect(page).to have_content('コメントを削除しました')
      end

      it 'ログインしており記事を投稿したユーザーだと他のユーザーのコメントも削除できる' do
        visit new_user_session_path
        fill_in 'user_email', with: article_user.email
        fill_in 'user_password', with: article_user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        click_link 'テストタイトル', href: article_path(article)
        expect(current_path).to eq(article_path(article))
        expect(page).to have_link '削除', href: article_comment_path(article, comment)
        page.accept_confirm("管理者としてコメントの削除を行います\nよろしいですか？") do
          click_link '削除', href: article_comment_path(article, comment)
        end
        expect(current_path).to eq(article_path(comment.article))
        expect(page).to have_content('コメントを削除しました')
      end
    end
  end

end
