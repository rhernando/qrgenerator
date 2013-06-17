class AddNameToCodigo < ActiveRecord::Migration
  def change
    add_column :codigos, :filename, :string
  end
end
