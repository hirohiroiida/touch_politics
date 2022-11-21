require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  let(:user) { create(:user) }
  describe 'ログイン機能' do
    context '入力情報に誤りがある場合' do
      it 'エラーメッセージが画面上に表示されること' do
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: 'wrong@example.com'
          fill_in 'パスワード', with: '12345678'
          click_on 'ログイン'
        end
        expect(page).to have_content 'ログインに失敗しました'
      end
    end

    context '入力情報が正しい場合' do
      it 'ログインができること' do
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: '12345678'
          click_on 'ログイン'
        end
        expect(page).to have_content 'ログインしました'
      end
    end
  end
end