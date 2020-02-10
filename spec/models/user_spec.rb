require 'rails_helper'

RSpec.describe User, type: :model do
  #-------正常テスト開始--------#
  describe '正常系のテスト' do
    context '回答する' do
      it '正しく登録できること' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).to be_valid
        #登録処理
        user.save

        #登録したデータを取り出す
        user_data = User.find(1)
        #比較
        expect(user_data.name).to eq('hoshi')
        expect(user_data.full_name).to eq('星飛雄馬')
        expect(user_data.email).to eq('hoshi@email.com')
        expect(user_data.sex).to eq(1)
        expect(user_data.administrator).to eq(true)
      end

      it '最大値で登録できること' do
        @name = (0...30).map{ (65 + rand(26)).chr }.join
        @full_name = (0...30).map{ (65 + rand(26)).chr }.join
        @email = (0...40).map{ (65 + rand(26)).chr }.join + "@email.com"
        @password = [*:a..:z,*0..9].sample(29).join + "$"

        user = User.new(
          name: @name,
          full_name: @full_name,
          email: @email,
          sex: 1,
          password: @password,
          administrator: false
        )
        expect(user).to be_valid
      end
    end
  end
  #-------正常テスト終了--------#

  #-------異常系テスト開始--------#

  #-------必須入力テスト開始--------#
  describe '入力項目の有無' do
    context '必須入力であること' do
      it 'ユーザー名が必須入力であること' do
        user = User.new(
          name: "",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end

      it '氏名が必須入力であること' do
        user = User.new(
          name: "hoshi",
          full_name: "",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:full_name]).to include(I18n.t('errors.messages.blank'))
      end

      it 'メールアドレスが必須入力であること' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
      end

      it '性別が必須入力であること' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: "",
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:sex]).to include(I18n.t('errors.messages.blank'))
      end

      it 'パスワードが必須入力であること' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:password]).to include(I18n.t('errors.messages.blank'))
      end
    end
  end
  #-------必須入力テスト終了--------#

  #-------最大値テスト開始--------#
  describe '最大値チェック' do
    context '最大値を超えたものは登録できない' do
      it 'ユーザー名の最大値が30桁であること' do
        @name = (0...31).map{ (65 + rand(26)).chr }.join
        user = User.new(
          name: @name,
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:name]).not_to include(I18n.t('errors.messages.too_long'))
      end

      it '氏名の最大値が30桁であること' do
        @full_name = (0...31).map{ (65 + rand(26)).chr }.join
        user = User.new(
          name: "hoshi",
          full_name: @full_name,
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:full_name]).not_to include(I18n.t('errors.messages.too_long'))
      end

      it 'メールアドレスの最大値が50桁であること' do
        @email = (0...51).map{ (65 + rand(26)).chr }.join
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: @email,
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:email]).not_to include(I18n.t('errors.messages.too_long'))
      end

      it 'パスワードの最大値が30桁であること' do
        @password = (0...31).map{ (65 + rand(26)).chr }.join
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: @password,
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:password]).not_to include(I18n.t('errors.messages.too_long'))
      end
    end
  end
  #-------最大値テスト終了--------#

  #-------最小値テスト開始--------#
  describe '最小値チェック' do
    context '最小値を超えないものは登録できない' do
      it 'パスワードのの最小値が8桁であること' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi0",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:password]).not_to include(I18n.t('errors.messages.too_short'))
      end
    end
  end
  #-------最小値テスト終了--------#

  #-------入力フォーマットテスト開始--------#
  describe '入力フォーマットチェック' do
    context '入力フォーマットが正しくないものは登録できない' do
      it 'メールアドレスの入力フォーマット' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshismail.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
      end

      it 'パスワードの入力フォーマット(アルファベットが含まれていない)' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshismail.com",
          sex: 1,
          password: "$%%%@000",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
      end

      it 'パスワードの入力フォーマット(数字が含まれていない)' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshismail.com",
          sex: 1,
          password: "hoshi@$%",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
      end

      it 'パスワードの入力フォーマット(記号が含まれていない)' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshismail.com",
          sex: 1,
          password: "hoshi012",
          administrator: true
        )
        expect(user).not_to be_valid
        #必須入力のエラーメッセージが含まれていることを検証する
        expect(user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
      end
    end
  end
  #-------入力フォーマットテスト終了--------#

  #-------重複テスト開始--------#
  describe '重複禁止のチェック' do
    context '重複禁止項目が同じデータが既にDBに存在している場合は登録できない' do
      it '同じユーザー名は登録できない' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        user.save

        re_user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "re_hoshi@email.com",
          sex: 2,
          password: "@hoshi001",
          administrator: false
        )
        expect(re_user).not_to be_valid

        expect(re_user.errors[:name]).to include(I18n.t('errors.messages.taken'))
        expect(re_user.save).to be_falsey
        expect(User.all.size).to eq 1
      end

      it '同じメールアドレスは登録できない' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        user.save

        re_user = User.new(
          name: "re_hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 2,
          password: "@hoshi001",
          administrator: false
        )
        expect(re_user).not_to be_valid

        expect(re_user.errors[:email]).to include(I18n.t('errors.messages.taken'))
        expect(re_user.save).to be_falsey
        expect(User.all.size).to eq 1
      end

      it '異なるユーザー名。メールアドレスは登録できる' do
        user = User.new(
          name: "hoshi",
          full_name: "星飛雄馬",
          email: "hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        user.save

        re_user = User.new(
          name: "re_hoshi",
          full_name: "星飛雄馬",
          email: "re_hoshi@email.com",
          sex: 1,
          password: "@hoshi000",
          administrator: true
        )
        expect(re_user).to be_valid
        re_user.save
        expect(User.all.size).to eq 2
      end
    end
  end
  #-------重複テスト終了--------#

  #-------異常系テスト終了--------#
end
