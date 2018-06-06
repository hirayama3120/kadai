class User < ApplicationRecord
  def do_inactive(id, attributes)
    if id.is_a?(Array)
      id.map.with_index { |one_id, idx| do_inactive(one_id, attributes[idx]) }
    else
      object = find(id)
      object.do_inactive(attributes)
      object
    end
  end
end
