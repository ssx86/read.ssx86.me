class NewsController < ApplicationController
  before_action :authenticate_user!
  def index
    @all_news = News.paginate(:page => params[:page], :per_page => 25).order("date desc")
    @count = News.count
  end

  def show
    puts "正在查看新闻"
    @news = News.find(params[:id])
    #
    # 单词列表
    @word_list = @news.words.where.not(id: current_user.user_words.where("times > ?", 3).pluck(:word_id))

    puts "一共有多少个单词#{@word_list.count}"

    gon.rabl :as => "words"
  end

end
