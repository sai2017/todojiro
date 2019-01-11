class Api::JirosController < ApplicationController

def index
  @jiros = Jiro.order('updated_at DESC')
end

def create
  @jiro = Jiro.new(jiro_params)
  if jiro.save
    render :show, status: :created
  else
    render json: @jiro.errors, status: :unprocessable_entity
  end
end

def update
  @jiro = Jiro.find(params[:id])
  if @jiro.update(jiro_params)
    render :show, status: :ok
  else
    render json: @jiro.errors, status: :unprocessable_entity
  end
end

private

  def jiro_params
    params.require(:jiro).permit(:name, :is_done)
  end
end