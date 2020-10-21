class NewsTable < ActiveRecord::Migration
  def change
    create_table :newsarticles do |t|
      t.string :title
      t.string :text
      t.string :author
    end
  end
end