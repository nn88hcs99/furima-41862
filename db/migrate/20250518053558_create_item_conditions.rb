class CreateItemConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :item_conditions do |t|

      t.timestamps
    end
  end
end
