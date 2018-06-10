class User < ApplicationRecord
  def do_inactive(id, attributes)
    object = find(id)
    object.do_inactive(attributes)
    object
  end
end
