class ArticlesController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]
  def index
    @articles = Article.all
    @twitter_users = TwitterUser.all 
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), success: '投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), success: '投稿を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy!
    redirect_to articles_path, success: '投稿を削除しました', status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
