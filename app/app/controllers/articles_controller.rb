class ArticlesController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  before_action :move_to_index, only:[:edit, :update, :destroy]

  def index
    @article = Article.all.includes(:user)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(form_params)
    if @article.valid?
      @article.save
      redirect_to root_path, notice: "記事を作成しました"
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(form_params)
      redirect_to article_path(@article), notice: "記事を更新しました"
    else
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    article.image.purge
    redirect_to root_path, notice: "記事を削除しました"
  end

  private
  def form_params
    params.require(:article) 
      .permit(
      :image,
      :title,
      :genre_id,
      :country_id,
      :text)
      .merge(user_id: current_user.id)
  end

  def move_to_index
    @article = Article.find(params[:id])
    unless current_user == @article.user
      redirect_to root_path, notice: 'アクセス権限がありません'
    end
  end
end
