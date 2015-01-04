class WordsController < ApplicationController
  before_action :authenticate_user!

  before_filter :current_word, :only => :show

  def index
    @words = Word.paginate(:page => params[:page], :per_page => 100).order('word asc')
  end

  def show
  end

  def current_word
    @word = Word.find(params[:id])
  end
end
