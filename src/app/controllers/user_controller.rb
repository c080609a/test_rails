# frozen_string_literal: true

class UserController < ApplicationController
  before_action :conn_redis, only: [:show, :get_by_geotarget]

  def show
    u = User.find(params[:id])
    geopos = @redis_conn.geopos("test_rails", params[:id])
    result = {
      age: u.age,
      geopos: {
        latitude: geopos[0][0],
        longitude: geopos[0][1]
      }
    }
    render json: result
  end

  def get_by_geotarget
    arr_ids = @redis_conn.georadius(
      ENV["GEOREDIS_KEY"],
      geotarget_params[:lat],
      geotarget_params[:lo],
      geotarget_params[:rad],
      geotarget_params[:met]
    )

    result = User.find(arr_ids).map{ |el| el.attributes.merge(id: el.id, name: el.name, surname: el.surname, gender: el.gender ? "Male" : "Female").slice(:id, :name, :surname, :gender)  }

    render json: result.to_json
  end

  private
    def conn_redis
      @redis_conn = Redis.new(url: ENV["GEOREDIS"])
    end

    def geotarget_params
      params.permit(:lat, :lo, :rad, :met)
    end
end
