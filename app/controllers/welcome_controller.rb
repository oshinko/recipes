class WelcomeController < ApplicationController
  def index
  end
  def pick
    @picked = Article.order(Arel.sql('RANDOM()')).first
  end
end
