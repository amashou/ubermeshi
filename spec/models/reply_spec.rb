require 'rails_helper'

RSpec.describe Reply, type: :model do
    let(:reply) { FactoryBot.build(:reply) }

    it "factory_botが有効であること" do
          expect(reply).to be_valid
      end
  
    describe "バリデーションのテスト" do
              
          context "contentカラム" do
              
              it "空欄であれば無効であること" do
                  reply.content = ''
                  reply.valid?
                  expect(reply).to_not be_valid
              end
  
              it "空欄であればエラーを返すこと" do
                  reply.content = ''
                  reply.valid?
                  expect(reply.errors[:content]).to include('を入力してください')
              end
  
              it "140文字を超えたら無効であること" do
                  reply.content = 'a' * 141
                  reply.valid?
                  expect(reply).to_not be_valid
              end
  
              it "140文字を超えたらエラーを返すこと" do
                  reply.content = 'a' * 141
                  reply.valid?
                  expect(reply.errors[:content]).to include('は140文字以内で入力してください')
              end
  
              it "140文字は有効であること" do
                  reply.content = 'a' * 140
                  reply.valid?
                  expect(reply).to be_valid
              end
          end
  
          context "user_idカラム" do
              it "空欄であれば無効であること" do
                  reply.user_id = ''
                  reply.valid?
                  expect(reply).to_not be_valid
              end
          end
  
          context "comment_idカラム" do
              it "空欄であれば無効であること" do
                  reply.comment_id = ''
                  reply.valid?
                  expect(reply).to_not be_valid
              end
          end
    end
end
