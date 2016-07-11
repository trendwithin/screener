class BriefingsEarning < ActiveRecord::Base

  private
    def self.earnings
      where("earnings > ?", 0)
    end

    def self.expectation
      where("expectation > ?", 0)
    end

    def self.surprise(query)
      where("((earnings - expectation) / expectation) * 100 >= ?", "#{query}")
    end
end
