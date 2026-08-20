json.array!(@items) do |item|
  json.extract! item, :id, :price, :name, :pic, :allergy, :recipe, :desc, :glut, :veg, :vegan, :menu, :kid
  json.url item_url(item, format: :json)
end
