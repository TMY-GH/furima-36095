class AddSolditemToAddress < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :solditem, null: false, foreign_key: true
  end
end
