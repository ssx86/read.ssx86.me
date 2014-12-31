class NewsController < ApplicationController
  def index
    @all_news = News.paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @news = News.find(params[:id])
    if @news.content.nil? then
      getContent(@news)
    end
  end

  private

  def getContent(news)
    url = news.url
    doc = Nokogiri::HTML(open(url)) 

    content = ""
    doc.xpath('//div[@class="cnn_strycntntlft"]/p').each do |item|
      content = content + '||' + item.content 
    end
    news.content = content
    news.save
  end

end
