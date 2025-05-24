module BaseModel
  macro included
    # Common database connection for all models
    connection primary
  end
end