class RemovePrefecturesToAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :prefectures, :string
  end
end
