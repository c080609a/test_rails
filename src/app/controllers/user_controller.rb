# frozen_string_literal: true

class UserController < ApplicationController
  def index
  end

  def show
  end

  def get_by_geotarget
    redis_conn = Redis.new(url: "redis://redis:6379/15")
    arr_ids = redis_conn.georadius(
      "test_rails",
      params[:lat],
      params[:lo],
      params[:rad],
      params[:met]
    )

    result = Array.new
    arr_ids.each do |el|
      u = User.find(el)
      geopos = redis_conn.geopos("test_rails", el)
      result.push(
        id: el,
        name: u.name,
        email: u.email,
        surname: u.surname,
        geopos: {
          latitude: geopos[0][0],
          longitude: geopos[0][1]
        }
      )
    end

    render json: result
  end
end
