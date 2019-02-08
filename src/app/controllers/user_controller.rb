# frozen_string_literal: true

class UserController < ApplicationController
  before_action :conn_redis, only: [:show, :get_by_geotarget]

  def show
    sp = show_params
    geopos = @redis_conn.geopos(ENV["GEOREDIS_KEY"], sp[:id])

    render json: User.get_show(sp[:id], geopos)
  end

  def get_by_geotarget
    gt = geotarget_params
    arr_ids = @redis_conn.georadius(ENV["GEOREDIS_KEY"], gt[:lat], gt[:lo], gt[:rad], gt[:met])
    render json: User.get_by_geotarget(arr_ids)
  end

  private
    def conn_redis
      @redis_conn = Redis.new(url: ENV["GEOREDIS"])
    end

    def geotarget_params
      params.permit(:lat, :lo, :rad, :met)
    end

    def show_params
      params.permit(:id)
    end
end
