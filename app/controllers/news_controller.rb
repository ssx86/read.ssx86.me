class NewsController < ApplicationController
  def index
    @all_news = News.all
    if @all_news.size == 0 then
      getTodayNews()
    end
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

  def getTodayNews
    p 'getting today news'
    url = 'http://rss.cnn.com/rss/edition.rss'
    doc = Nokogiri::HTML(open(url)) 

    doc.xpath('//item').each do |item| 
      p item.children
      news = News.new
      news.title = item.at_xpath('title').content
      news.url = item.at_xpath('guid').content
      news.desc = item.at_xpath('description').content
      news.channel = 'edition'
      p news
      news.save
    end 
  end
end
