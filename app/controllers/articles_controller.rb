# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = "Article was created successfully!"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated!"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
     redirect_to articles_path
    else 
      render :index, status: :unprocessable_entity
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if @article.user != current_user
      flash[:alert] = "You can only edit or delete your own articles."
      redirect_to @article
    end
  end
end
