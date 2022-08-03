require 'rails_helper'

RSpec.describe "Users", type: :system do
  
  describe 'ユーザー新規登録' do
    let(:user) { FactoryBot.build(:user) }

    context '新規登録ができるとき' do
      it '正しい情報を入力すれば新規登録できトップページに遷移しフラッシュが表示される' do
        visit root_path
        expect(page).to have_content('新規登録')
        click_link('新規登録')
        image_file = Rails.root.join('public/images/default_icon.png')
        attach_file('user[image]', image_file)
        fill_in 'user_nickname', with: user.nickname
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password_confirmation
        fill_in 'user_introduction', with: user.introduction
        expect{ find('input[name="commit"]').click }.to change{ User.count }.by(1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content('アカウント登録が完了しました。')
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
      end
    end

    context '新規登録ができないとき' do
      it '間違った情報を入力すると新規登録ページへ戻されエラーメッセージが表示される' do
        visit root_path
        expect(page).to have_content('新規登録')
        click_link('新規登録')
        fill_in 'user_nickname', with: ''
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
        expect{ find('input[name="commit"]').click }.to change{ User.count }.by(0)
        expect(current_path).to eq(user_registration_path)
        expect(page).to have_content('Eメールを入力してください')
        expect(page).to have_content('パスワードを入力してください')
        expect(page).to have_content('パスワードには英数字を含めて設定してください')
        expect(page).to have_content('ニックネームを入力してください')
        expect(page).to have_content('画像を入力してください')
      end
    end
  end

  describe 'ユーザーログイン' do
    let(:user) { FactoryBot.create(:user) }

    context 'ユーザーがログインできるとき' do
      it '保存されているユーザーの情報と一致すればログインできフラッシュが表示される' do
        visit root_path
        expect(page).to have_content('ログイン')
        click_link('ログイン')
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        expect(page).to have_content('ログインしました')
      end
    end

    context 'ユーザーがログインできないとき' do
      it '保存されているユーザーの情報と一致しないとログインできずフラッシュが表示される' do
        visit root_path
        expect(page).to have_content('ログイン')
        click_link('ログイン')
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        find('input[name="commit"]').click
        expect(current_path).to eq(new_user_session_path)
        expect(page).to have_content('Eメールまたはパスワードが違います')
      end
    end
  end

end
