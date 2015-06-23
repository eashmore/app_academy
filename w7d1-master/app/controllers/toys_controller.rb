class ToysController < ApplicationController
  def show
    @toy = Toy.find(params[:id])
    render 'show'
  end

  def update
    @toy = Toy.find(params[:id])
    if @toy.update(toy_params)
      render 'show'
    end
  end

  private
  def toy_params
    params.require(:toy).permit(:pokemon_id)
  end
end
