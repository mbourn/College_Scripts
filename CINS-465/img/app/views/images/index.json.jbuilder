json.array!(@images) do |image|
  json.extract! image, :id, :filename, :public, :user_id
  json.url image_url(image, format: :json)
end
