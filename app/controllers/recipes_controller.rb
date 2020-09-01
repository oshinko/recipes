class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = view_context.current_user.recipes.new
  end

  def edit
    @recipe = view_context.current_user.recipes.find(params[:id])
  end

  def create
    view_context.current_user.recipes.create(recipe_params)
    redirect_to user_path(view_context.current_user)
  end

  def update
    @recipe = view_context.current_user.recipes.find(params[:id])
  
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = view_context.current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to user_path(view_context.current_user)
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :text)
    end
end
