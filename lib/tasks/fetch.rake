namespace :fetch do

  task :cnn => :environment do 
    puts "[#{Time.now}] start..."
    getTodayNews
    puts "[#{Time.now}] end..."
    puts "[#{Time.now}] count of news: #{News.count}"
  end

  def getTodayNews

    def getdate(url)
      ret = /\d{4}\/\d{2}\/\d{2}/.match(url)
      if ret then
        return ret.to_s
      else
        return Time.now.strftime("%Y/%m/%d") 
      end
    end

    url = 'http://rss.cnn.com/rss/edition.rss'
    doc = Nokogiri::HTML(open(url)) 

    doc.xpath('//item').each do |item| 
      news = News.new
      news.title = item.at_xpath('title').content
      news.url = item.at_xpath('guid').content
      news.date = getdate(news.url)
      news.desc = item.at_xpath('description').content
      news.channel = 'edition'
      news.save
    end 
  end

end
