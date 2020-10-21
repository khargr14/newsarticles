class CreateNewsarticles < ActiveRecord::Migration
  def change
    create_table :newsarticles do |t|
      t.string :title
      t.string :text
      t.string :author
      t.string :user_id
    end
  end
end
