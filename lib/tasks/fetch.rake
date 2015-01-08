namespace :fetch do

  task :cnn => :environment do 
    puts "[#{Time.now}] start..."

    rss_urls = {
      'Top Stories'     => 'http://rss.cnn.com/rss/edition.rss',
      'World'           => 'http://rss.cnn.com/rss/edition_world.rss',
      'Africa'          => 'http://rss.cnn.com/rss/edition_africa.rss',
      'Americas'        => 'http://rss.cnn.com/rss/edition_americas.rss',
      'Asia'            => 'http://rss.cnn.com/rss/edition_asia.rss',
      'Europe'          => 'http://rss.cnn.com/rss/edition_europe.rss',
      'MiddleEast'      => 'http://rss.cnn.com/rss/edition_meast.rss',
      'U.S'             => 'http://rss.cnn.com/rss/edition_us.rss',
#      'Money'           => 'http://rss.cnn.com/rss/money_news_international.rss',
      'Technology'      => 'http://rss.cnn.com/rss/edition_technology.rss',
      'Science&Space'   => 'http://rss.cnn.com/rss/edition_space.rss',
      'Entertainment'   => 'http://rss.cnn.com/rss/edition_entertainment.rss',
      'WorldSport'      => 'http://rss.cnn.com/rss/edition_sport.rss',
      'Football'        => 'http://rss.cnn.com/rss/edition_football.rss',
      'Golf'            => 'http://rss.cnn.com/rss/edition_golf.rss',
      'Motorsport'      => 'http://rss.cnn.com/rss/edition_motorsport.rss',
#      'Tennis'          => 'http://rss.cnn.com/rss/edition_tennis.rss',
#      'Travel'          => 'http://travel.cnn.com/rss.xml',
#      'Video'           => 'http://rss.cnn.com/rss/cnn_freevideo.rss',
#      'MostRecent'      => 'http://rss.cnn.com/rss/cnn_latest.rss',
#      'ConnectTheWorld' => 'http://rss.cnn.com/rss/edition_connecttheworld.rss',
#      'WorldSport'      => 'http://rss.cnn.com/rss/edition_worldsportblog.rss'
    }
    rss_urls.each do |k, v|
      getTodayNews k, v
    end
    puts "[#{Time.now}] end..."
    puts "[#{Time.now}] count of news: #{News.count}"
  end

  def getTodayNews( channel, url )
    puts "fetching channel: [#{channel}]..."

    def getdate(url)
      ret = /\d{4}\/\d{2}\/\d{2}/.match(url)
      if ret then
        return ret.to_s
      else
        return Time.now.strftime("%Y/%m/%d") 
      end
    end

    doc = Nokogiri::HTML(open(url)) 

    #f = File.new("/home/zhangss/read.ssx86.me/log/#{channel}", "w")
    #f.puts doc.to_xml
    #f.close

    doc.xpath('//item').each do |item| 
      news = News.new
      news.title = item.at_xpath('title').content
      news.url = item.at_xpath('guid').content
      news.date = getdate(news.url)
      news.desc = item.at_xpath('description').content.gsub(/<img.*\/>/, "")
      news.channel = channel


      #保存成功说明是新文章，否则是之前抓过的
      if news.save then
        getContent(news)
      else
      end
    end 
  end


  def getContent(news)
    puts "fetching news content: #{news.title}..."
    url = news.url
    doc = Nokogiri::HTML(open(url)) 

    content = ""
    doc.xpath('//div[@class="cnn_strycntntlft"]/p').each do |item|
      content = content + '||' + item.content 
    end

    doc.xpath('//div[@class="l-container"]/p').each do |item|
      content = content + '||' + item.content 
    end
    doc.xpath('//div[@id="cnnTxtCmpnt"]/p').each do |item|
      content = content + '||' + item.content 
    end

    news.content = content.gsub(/<img.*\/>/, "")
    news.save

    getWords(news, news.content)
  end

  def getWords(news, content)
    words = content.scan(/[a-zA-Z][a-zA-Z-]+/)

    return if not words 

    puts "current news has #{words.count} words"

    new_word_count = 0

    words.each do |w|
      word = Word.find_by word:w.downcase
      #新单词？
      if word == nil then
        puts "new word: #{w.downcase}"
        word ||= Word.new
        word.word = w.downcase
        new_word_count = new_word_count + 1 
      end
      word.news.push(news)

      word.save
    end
    
    puts "new words: #{new_word_count}"

  end

end



