class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.string :status, default: "Backlog"
      t.belongs_to :board, index: true

      t.timestamps null: false
    end
  end
end
