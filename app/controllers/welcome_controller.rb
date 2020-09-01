class WelcomeController < ApplicationController
  def index
  end
  def pick
    @picked = Recipe.order(Arel.sql('RANDOM()')).first
  end
end
