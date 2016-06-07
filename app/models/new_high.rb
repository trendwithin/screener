class NewHigh < ActiveRecord::Base
  before_validation :blank_field, on: :create

  protected
    def blank_field
      raise 'Empty Field For AllTimeHigh' if self.symbol.blank? || self.saved_on.blank?
    end
end
