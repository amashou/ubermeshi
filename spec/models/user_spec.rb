require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it "有効なFactoryBotを持つこと" do
    expect(user).to be_valid
  end

  describe "バリデーションのテスト" do

    context "nameカラム" do

      it "無名でないこと" do
        user.name = ''
        user.valid?
        expect(user).to_not be_valid
      end

      it "無名の場合はエラーを返すこと" do
        user.name = ''
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "16文字以上でないこと" do
        user.name = 'a' * 16
        user.valid?
        expect(user).to_not be_valid
      end

      it "16文字以上だとエラーを返すこと" do
        user.name = 'a' * 16
        user.valid?
        expect(user.errors[:name]).to include('は15文字以内で入力してください')
      end

      it "15文字いないであること" do
        user.name = 'a' * 15
        user.valid?
        expect(user).to be_valid
      end

    end

    context "emailカラム" do

      it "空欄でないこと" do
        user.email = ''  
        user.valid?
        expect(user).to_not be_valid
      end

      it "空欄だとエラーを返すこと" do
        user.email = ''
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end

      it "メールアドレスとしてフォーマットが正しいこと" do
        user.email = "test@example"
        user.valid?
        expect(user).to_not be_valid
      end

      it "メールアドレスとしてフォーマットが正しくなければエラーを返すこと" do
        user.email = "test@example"
        user.valid?
        expect(user.errors[:email]).to include('は有効ではありません')
      end

      it "256文字以上でないこと" do
        user.email = "a" * 244 + '@example.com'
        user.valid?
        expect(user).to_not be_valid
      end

      it "２５５文字以下であること" do
        user.email = "a" * 243 + '@example.com'
        user.valid?
        expect(user).to be_valid
      end

      it "２５6文字以上だとエラーを返すこと" do
        user.email = "a" * 244 + '@example.com'
        user.valid?
        expect(user.errors[:email]).to include('は255文字以内で入力してください')
      end

      it "一意であること" do
        user.email = "test@example.com"
        user.save
        user2 = FactoryBot.build(:user, name: "test2_user", email: "test@example.com")
        user2.valid?
        expect(user2).to_not be_valid
      end

      it "一意でないとエラーを返すこと" do
        user.email = "test@example.com"
        user.save
        user2 = FactoryBot.build(:user, name: "test2_user", email: "test@example.com")
        user2.valid?
        expect(user2.errors[:email]).to include('はすでに存在します')
      end

    end

    context "passwordカラム" do
      
      it "空欄でないこと" do
        user.password = ''
        user.valid?
        expect(user).to_not be_valid
      end

      it "空欄であればエラーを返すこと" do
        user.password = ''
        user.valid?
        expect(user.errors[:password]).to include('を入力してください')
      end

      it "６文字であれば有効であること" do
        user.password = user.password_confirmation = 'a' * 6
        user.valid?
        expect(user).to be_valid
      end

      it "15文字であれば有効であること" do
        user.password = user.password_confirmation = 'a' * 15
        user.valid?
        expect(user).to be_valid
      end

      it "5文字以下であれば無効であること" do
        user.password = user.password_confirmation = 'a' * 5
        user.valid?
        expect(user).to_not be_valid
      end

      it "16文字以上であれば無効であること" do
        user.password = user.password_confirmation = 'a' * 16
        user.valid?
        expect(user).to_not be_valid
      end

      it "5文字以下であればエラーを返すこと" do
        user.password = user.password_confirmation = 'a' * 5
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上で入力してください')
      end

      it "16文字以上であればエラーを返すこと" do
        user.password = user.password_confirmation = 'a' * 16
        user.valid?
        expect(user.errors[:password]).to include('は15文字以内で入力してください')
      end

      it "パスワードが不一致でないこと" do
        user.password = 'a' * 10
        user.password_confirmation = 'b' * 10
        user.valid?
        expect(user).to_not be_valid
      end

      it "パスワードが不一致の時エラーを返すこと" do
        user.password = 'a' * 10
        user.password_confirmation = 'b' * 10
        user.valid?
        expect(user.errors[:password_confirmation]).to include('とPasswordの入力が一致しません')
      end

    end
    
    context "profile_commentカラム" do

      it "150以下であれば有効であること" do
        user.profile_comment = 'a' * 150
        user.valid?
        expect(user).to be_valid
      end

      it "１５０文字を超えると無効であること" do
        user.profile_comment = 'a' * 151
        user.valid?
        expect(user).to_not be_valid
      end

      it "１５０文字を超えるとエラーを返すこと" do
        user.profile_comment = 'a' * 151
        user.valid?
        expect(user.errors[:profile_comment]).to include('は150文字以内で入力してください')
      end

    end
    
    context "status" do
    end

    context "address" do
    end

  end

  describe "アソシエーションのテスト" do
    
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Postクラスとのアソシエーション" do
      let(:target) { :post }

      # it "Postモデルはhas_manyであること" do
      #   expect(association.macro).to eq :has_many
      # end

    end

  end

end
