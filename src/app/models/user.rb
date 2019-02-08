# frozen_string_literal: true

class User < ApplicationRecord

  def get_by_geotarget
    self.map{ |el| el.attributes.merge(id: el.id, name: el.name, surname: el.surname, gender: el.gender ? "Male" : "Female").slice(:id, :name, :surname, :gender)  }
  end
end
