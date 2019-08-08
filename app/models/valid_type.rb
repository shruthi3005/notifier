class ValidType < EntityStatus
  default_scope {unscoped.where(typed: true)}

  VALID_TYPES.keys.each do |s|
    scope s, ->{ where(entity_type: VALID_TYPES[s]) }
  end
end
