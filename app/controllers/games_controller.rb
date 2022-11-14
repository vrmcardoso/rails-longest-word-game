require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    @word = params[:playerInput]
    @input = @word.downcase.split("")
    @letters = params[:letters].downcase.split
    grid = params[:letters].downcase.split
    @score = 0
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response_serialized = URI.open(@url).read
    @response = JSON.parse(response_serialized)
    if @response["found"]
      @input.each do |char|
        if grid.include?(char)
          @score += 1
          grid.delete(char)
        end
        if @score < @word.length
          @score = 0
        end
      end
    else
      @score = -1
    end
  end
end
