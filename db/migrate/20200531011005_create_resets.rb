class CreateResets < ActiveRecord::Migration[6.0]
  def change
    create_table :resets do |t|
      t.timestamps
    end
  end
end
