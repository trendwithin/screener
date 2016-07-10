class Zack < ActiveRecord::Base

  private
    def self.remove_text
      where.not("surprise = ?", "NA")
    end

    def self.surprise(query)
      where("cast(surprise as money) >= ?" , "#{query}")
    end

    def self.reported
      where("cast(reported as float) >= 0")
    end
end
