json.array!(@items) do |item|
  json.extract! item, :id, :price, :pic, :allergy, :recipe, :desc, :glut, :veg, :vegan, :kid
  json.url item_url(item, format: :json)
end
