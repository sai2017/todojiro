json.set! :jiros do
  json.array! @jiros do |jiro|
    json.extract! jiro, :id, :name, :is_done, :created_at, :updated_at
  end
end