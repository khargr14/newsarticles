users = [
    {name: 'Bob', lastname: 'The builder', email: 'bobbybuilds@gmail.com',password:'building123'},
    {name: 'Jany', lastname: 'Of Arc', email: 'janyarc@gmail.com',password:'23potatoes'}
  ]
  
  users.each do |singleUser|
    User.create(singleUser)
  end
  
  
  