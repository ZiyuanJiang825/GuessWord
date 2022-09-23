class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @check_win_or_lose = :play
    @word_with_guesses = @word.gsub(/\w/,'-')
  end

  def guess(letter)
    if letter =~ /[a-z]/
      
      #deal with same letter repeatedly
      if !(@guesses.include? letter) and !(@wrong_guesses.include? letter)
        if @word.include? letter
          @guesses += letter
          i = @word.index(letter)
          while i do
            @word_with_guesses[i]=letter
            i = @word.index(letter,i+1)
          end
          
          if @word_with_guesses.eql? word
            @check_win_or_lose = :win
          end
        else
          @wrong_guesses += letter
          if @wrong_guesses.length >= 7
            @check_win_or_lose = :lose
          end
        end
      else
        return false
      end
    elsif letter =~ /[A-Z]/
      return false
    else
      raise ArgumentError
      return false
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
