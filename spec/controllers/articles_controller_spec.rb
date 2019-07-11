require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
describe "#new" do
    it "should display index page" do
        get :new 
        expect(response).to render_template :new 
    end

    it "should create @article" do 
        get :new
        expect(assigns(:article)).to(be_a_new(Article))
    end
end

describe "#create" do
    context "with valid parameters" do
        it "should create a new article in database" do 
            expect {
            post :create, params: {article: FactoryBot.attributes_for(:article)}
            }.to change(Article, :count).by(1)
        end
        it "redirects to new article" do 
            post :create, params: {article: FactoryBot.attributes_for(:article)}
            expect(response).to redirect_to article_path(Article.last)
        end    
    end

    context "with invalid parameters" do
        it "should not create a new article in database" do 
            expect {
            post :create, params: {article: FactoryBot.attributes_for(:invalid_article)}
            }.to_not change(Article, :count)
        end
        it "renders new template" do
            post :create, params: {article: FactoryBot.attributes_for(:invalid_article)}
            expect(response).to render_template :new
        end
    end
end

describe "#show" do 
    it "assigns article to @article" do
        article = FactoryBot.create(:article)
        get :show, params: {id: article.id }
        expect(assigns(:article)).to eq(article)
    end
    it "renders show view" do
        article = FactoryBot.create(:article)
        get :show, params: {id: article.id}
        expect(response).to render_template :show  
    end
end

describe "#index" do 
    it "assigns @articles to all created articles (sorted_by created_at)" do  #rename
        article_1 = FactoryBot.create(:article)
        article_2 = FactoryBot.create(:article)
        get :index
        expect(assigns(:articles)).to eq([article_1, article_2]) # :articles should be the same in index method
    end

    it "renders index template" do 
    get :index 
    expect(response).to render_template :index
    end
end

describe "#destroy" do
    it "destroys articles in the database" do
        article = FactoryBot.create(:article)
        delete :destroy, params: {id: article.id }
        expect(Article.find_by(id: article.id)).to be(nil)
    end
    it "redirects to index" do 
        article = FactoryBot.create(:article)
        delete :destroy, params: {id: article.id }
        expect(response).to redirect_to(articles_path)
    end
end

describe "#update" do
    before  do 
        @article = FactoryBot.create(:article)
    end   
    context "valid attributes" do
        it "updates the news article record with new attributes" do
            new_title = "#{@article.title} Plus Changes!"
            patch :update, params: {id: @article.id, article: {title: new_title}}
            expect(@article.reload.title).to eq(new_title)
        end
        # it "updates articles in the database" do 
        #     article = 
        #     put :update, params: {article: FactoryBot.attributes_for(:article)}
        #     assigns(:article).should eq(@article) 
        # end    
        it "redirect to the news article show page" do
            new_title = "#{@article.title} plus changes!"
            patch :update, params: {id: @article.id, article: {title: new_title}}
            expect(response).to redirect_to(@article)
        end
        # it "redirects to the updated contact" do
        #     put :update, params: {article: FactoryBot.attributes_for(:article)}
        #     response.should redirect_to articles_path
        # end
    end
      

    describe "#edit" do
        it "renders the edit template" do
            article = FactoryBot.create(:article)
            get :edit, params: { id: article.id }
            expect(response).to render_template :edit
        end

        it "sets an instance variable based on the article id that is passed" do
            article = FactoryBot.create(:article)
            get :edit, params: { id: article.id }
            expect(assigns(:article)).to eq(article)
        end
    end

end 

end
