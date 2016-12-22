class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_word, only: [:edit, :update, :destroy]
  before_action :load_categories
  before_action :load_category, only: :create

  def index
    if params[:category_id]
      @words = @category.words.paginate page: params[:page],
        per_page: Settings.user.per_page
    else
      @words = Word.paginate page: params[:page],
        per_page: Settings.user.per_page
      flash[:danger] = t "words_not_found"
    end
  end

  def new
    @word = Word.new
  end

  def show
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "created_success"
      redirect_to admin_words_path
    else
      flash[:danger] = t "created_not_success"
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "updated_word"
      redirect_to admin_words_path
    else
      flash[:danger] = t "not_updated_word"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "deleted_word"
    else
      flash[:danger] = t "deleted_word_fail"
    end
    redirect_to admin_words_path
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "load_word_fail"
      redirect_to admin_words_path
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "access_denied"
      redirect_to root_url
    end
  end

  def word_params
    params.require(:word).permit :content,
      :category_id, meanings_attributes: [:id, :content, :is_correct]
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "admin_load_fails_category"
      redirect_to new_admin_word_path
    end
  end

  def load_categories
    @categories = Category.all
  end
end
