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
    @wr = current_user.user_words.find_by word_id:@word.id
    if @wr then
      #保护times为空的初始数据，release之后可以考虑移除
      @wr.times ||= 1
      @wr.times = @wr.times + 1 
      @wr.save
    else
      puts "创建"
      @wr = current_user.user_words.create(user_id:current_user.id, word_id:@word.id, times: 1)
    end
  end
end
