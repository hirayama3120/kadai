class User < ApplicationRecord
  include Swagger::UserSchema

  def nullify(user)
    del_user = user
    Rails.logger.debug user.inspect     
    del_user.DeleteFlag = 1
    del_user.save
  end
end
