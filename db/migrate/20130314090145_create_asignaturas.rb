class CreateAsignaturas < ActiveRecord::Migration
  def change
    create_table :asignaturas do |t|
      t.integer :curso
      t.string :nombre
      t.string :titulo

      t.timestamps
    end
  end
end
