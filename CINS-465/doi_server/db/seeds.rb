# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
dois = Doi.create(
  [
    { name: 'Test1', description: 'Test1', doi: '4dc9d8bc2879f53589bb6b006312b3d8'},
    { name: 'Test2', description: 'Test2', doi: '35b68999100c9e960834d620013b7eda'},
    { name: 'Test3', description: 'Test3', doi: '591470509fc1416a71ced6c558c6e37a'},
    { name: 'Test4', description: 'Test4', doi: 'd692fc6886258809a76adcdace2c3423'}
  ]
)

urls = Url.create(
  [
    { url: 'www.google.com', doi_id: dois[0].id},
    { url: 'www.yahoo.com', doi_id: dois[0].id},
    { url: 'www.duckduckgo.com', doi_id: dois[1].id},
    { url: 'www.vimeo.com', doi_id: dois[1].id},
    { url: 'www.sourceforge.net', doi_id: dois[1].id},
    { url: 'www.google.com', doi_id: dois[2].id},
    { url: 'www.yahoo.com', doi_id: dois[2].id},
    { url: 'www.duckduckgo.com', doi_id: dois[2].id},
    { url: 'www.vimeo.com', doi_id: dois[2].id},
    { url: 'www.sourceforge.net', doi_id: dois[3].id},
    { url: 'www.google.com', doi_id: dois[3].id},
    { url: 'www.yahoo.com', doi_id: dois[3].id},
    { url: 'www.duckduckgo.com', doi_id: dois[3].id},
    { url: 'www.vimeo.com', doi_id: dois[3].id},
    { url: 'www.sourceforge.net', doi_id: dois[3].id}
  ]
)

