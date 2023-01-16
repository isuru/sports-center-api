class CreateCourts < ActiveRecord::Migration[6.1]
  def change
    create_table :courts do |t|
      t.string      :name
      t.integer     :type_id
    end
  end
end
