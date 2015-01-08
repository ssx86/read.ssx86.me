#collection Word.joins('left outer join user_words on words.id = user_words.word_id').where("user_id = #{current_user.id} and user_words.times = 1").limit(50)

collection @word_list[0..9]

attributes :id => :i, :word => :w, :means => :m

