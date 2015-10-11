class Articles < ActiveRecord::Migration

  def change
    create_table :articles do |t|
      t.string :title
      t.string :name
      t.text :text
      t.timestamps
    end
  end

end
