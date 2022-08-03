class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]


  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to article_path(@comment.article), notice: "コメントを投稿しました"
    else
      @Comment
      @article = Article.find(params[:article_id])
      @comments = @article.comments.includes(:user)
      render template: "articles/show"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to article_path(comment.article), notice: "コメントを削除しました"
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
    .merge(
      user_id: current_user.id,
      article_id: params[:article_id])
  end
end
