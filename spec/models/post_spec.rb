require 'rails_helper'

RSpec.describe Post, type: :model do
    let(:post) { FactoryBot.build(:post) }

    it "ファクトリーが有効であること" do
        expect(post).to be_valid
    end

    describe "バリデーションのテスト" do
        
        context "titleカラム" do
           
            it "空欄でないこと" do
                post.title = ''
                post.valid?
                expect(post).to_not be_valid
            end
                  
            it "空欄だとエラーを返すこと" do
                post.title = ''
                post.valid?
                expect(post.errors[:title]).to include('を入力してください')
            end

            it "30文字を超えたら無効であること" do
                post.title = 'a' * 31
                post.valid?
                expect(post).to_not be_valid
            end

            it "30文字を超えたらエラーを返すこと" do
                post.title = 'a' * 31
                post.valid?
                expect(post.errors[:title]).to include('は30文字以内で入力してください')
            end

            it "30文字は有効であること" do
                post.title = 'a' * 30
                post.valid?
                expect(post).to be_valid
            end

        end

        context "descriptionカラム" do
            
            it "空欄は無効であること" do
                post.description = ''
                post.valid?
                expect(post).to_not be_valid
            end

            it "空欄はエラーを返すこと" do
                post.description = ''
                post.valid?
                expect(post.errors[:description]).to include('を入力してください')
            end

            it "１４０文字を超えたら無効であること" do
                post.description = 'a' * 141
                post.valid?
                expect(post).to_not be_valid
            end

            it "１４０文字を超えたらエラーを返すこと" do
                post.description = 'a' * 141
                post.valid?
                expect(post.errors[:description]).to include('は140文字以内で入力してください')
            end

            it "１４０文字は有効であること" do
                post.description = 'a' * 140
                post.valid?
                expect(post).to be_valid
            end

        end

        context "food_pictureカラム" do
            
            it "５MBを超えるファイルは無効である" do
            end

        end

    end

end
