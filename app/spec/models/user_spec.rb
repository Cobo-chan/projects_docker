require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録が成功するとき' do
      it 'image,nickname,email,password,password_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが20文字以下で登録できる' do
        @user.nickname = Faker::Lorem.characters(number: 20)
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = '1q1q1q'
        @user.password_confirmation = '1q1q1q'
        expect(@user).to be_valid
      end
      it 'passwordが英数字混合であれば登録できる' do
        @user.password = '1q2w3e'
        @user.password_confirmation = '1q2w3e'
        expect(@user).to be_valid
      end
      it 'introducitonが存在しなくても登録できる' do
        @user.introduction = ''
        expect(@user).to be_valid
      end
    end

    context '新規登録が失敗しエラーを返すとき' do
      subject { @user.errors.full_messages }
      it 'imageが存在しないと登録できない' do
        @user.image = nil
        @user.valid?
        is_expected.to include("画像を入力してください")
      end
      it 'nicknameが存在しないと登録できない' do
        @user.nickname = ''
        @user.valid?
        is_expected.to include("ニックネームを入力してください")
      end
      it 'nicknameが21文字以上だと登録できない' do
        @user.nickname = Faker::Lorem.characters(number: 21)
        @user.valid?
        is_expected.to include("ニックネームは20文字以内で入力してください")
      end
      it 'emailが存在しないと登録できない' do
        @user.email = ''
        @user.valid?
        is_expected.to include("Eメールを入力してください")
      end
      it 'emailがすでに存在すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'emailに@が入っていないと登録できない' do
        @user.email = 'test_test.mail'
        @user.valid?
        is_expected.to include("Eメールは不正な値です")
      end
      it 'passwordが存在しないと登録できない' do
        @user.password = ''
        @user.valid?
        is_expected.to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = '1q1q1'
        @user.valid?
        is_expected.to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordが半角英数字混同でないと登録できない' do
        @user.password = '111111'
        @user.valid?
        is_expected.to include("パスワードには英数字を含めて設定してください")
      end
      it 'passwordが存在してもpassword_confirmationが存在しないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        is_expected.to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end

  end
end
