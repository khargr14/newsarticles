users = [
    {name: 'Bob', lastname: 'The builder', email: 'bobbybuilds@gmail.com',password:'building123'},
    {name: 'Jany', lastname: 'Of Arc', email: 'janyarc@gmail.com',password:'23potatoes'}
  ]
  
  users.each do |singleUser|
    User.create(singleUser)
  end
  
  
  
  newsarticles = [
    {title: 'Green Rain in China', text: 'China experienced green rain in 4 provinces Monday 23rd of Sept. Local Authorities were alarmed, but it ended after 20 minutes.',author:'janyarc@gmail.com'},
    {title: 'Politics abolished', text: 'Politics have been officially abolished be the US senate. The decision was made due to the people pushing for a new system and world order. ',author: 'bobbybuilds@gmail.com'}
  ]
  
  newsarticles.each do |newsarticle|
    Newsarticle.create(newsarticle)
  end