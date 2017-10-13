class Api::V1::PalatesController < ApplicationController
  skip_before_action :authorized, only: [:index]


  def index
    @palates = Palate.all
    render json: @palates, status: 200
  end

  def show
    @palate = Palate.find_by(id: params[:id])
    render json: @palate, status: 200
  end

  def user_palates
    @palates = Palate.where(user_id: params[:user_id].order(:timestamps))
    render json: @palates, status: 200
  end

  def create
    @palate = Palate.new(user_id: params[:user_id], data: params[:data])
    if @palate.valid?
      @palate.save
      render json: @palate, status: 201
    else
      render json: @palate.errors, status: 400
    end
  end


private

  def palate_params
    params.permit(:id, :data, :user_id)
  end

end