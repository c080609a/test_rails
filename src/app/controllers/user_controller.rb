class UserController < ApplicationController
  def index
  end

  def show
  end

  def get_by_geotarget

    render json: {"hello": "world"}
  end
end
