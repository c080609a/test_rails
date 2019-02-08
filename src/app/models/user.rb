# frozen_string_literal: true

class User < ApplicationRecord

  def self.get_show(id, geopos)
    {
      age: 12,
      geopos: {
        latitude: geopos[0][0],
        longitude: geopos[0][1]
      }
    }
  end
  def self.get_by_geotarget(ids)
    find(ids).map{ |el| el.attributes.merge(id: el.id, name: el.name, surname: el.surname, gender: el.gender ? "Male" : "Female").slice(:id, :name, :surname, :gender)  }
  end
end
