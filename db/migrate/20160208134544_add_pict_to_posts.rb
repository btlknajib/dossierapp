class AddPictToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pict, :string
  end
end
