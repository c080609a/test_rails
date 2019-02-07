# frozen_string_literal: true

class UserController < ApplicationController
  def index
  end

  def show
    u = User.find(params[:id])
    redis_conn = Redis.new(url: "redis://redis:6379/15")
    geopos = redis_conn.geopos("test_rails", params[:id])
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
      result.push(
        id: u.id,
        name: u.name,
        surname: u.surname,
        gender: u.gender ? "male" : "female"
      )
    end

    render json: result
  end
end
