require 'rails_helper'

RSpec.describe Comment, type: :model do
	let(:comment) { FactoryBot.build(:comment) }

  it "factory_botが有効であること" do
		expect(comment).to be_valid
	end

  describe "バリデーションのテスト" do
			
		context "contentカラム" do
			
			it "空欄であれば無効であること" do
				comment.content = ''
				comment.valid?
				expect(comment).to_not be_valid
			end

			it "空欄であればエラーを返すこと" do
				comment.content = ''
				comment.valid?
				expect(comment.errors[:content]).to include('を入力してください')
			end

			it "140文字を超えたら無効であること" do
				comment.content = 'a' * 141
				comment.valid?
				expect(comment).to_not be_valid
			end

			it "140文字を超えたらエラーを返すこと" do
				comment.content = 'a' * 141
				comment.valid?
				expect(comment.errors[:content]).to include('は140文字以内で入力してください')
			end

			it "140文字は有効であること" do
				comment.content = 'a' * 140
				comment.valid?
				expect(comment).to be_valid
			end
		end

		context "user_idカラム" do
			it "空欄であれば無効であること" do
				comment.user_id = ''
				comment.valid?
				expect(comment).to_not be_valid
			end
		end

		context "post_idカラム" do
			it "空欄であれば無効であること" do
				comment.post_id = ''
				comment.valid?
				expect(comment).to_not be_valid
			end
		end
  end
end
