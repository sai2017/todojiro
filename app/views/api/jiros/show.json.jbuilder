json.set! :jiro do
  json.extract! @jiro, :id, :name, :is_done, :created_at, :updated_at
end