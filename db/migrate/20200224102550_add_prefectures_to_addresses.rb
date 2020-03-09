class AddPrefecturesToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :prefectures, :integer, null: false
  end
end
