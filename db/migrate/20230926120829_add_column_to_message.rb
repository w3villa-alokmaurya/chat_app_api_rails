class AddColumnToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :sender_id, :integer
    add_column :messages, :reciever_id, :integer
  end
end
