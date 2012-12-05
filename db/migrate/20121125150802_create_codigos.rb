class CreateCodigos < ActiveRecord::Migration
  def change
    create_table :codigos do |t|

      t.timestamps
    end
  end
end
