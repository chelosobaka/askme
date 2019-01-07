class AddAuthorIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :author_id, :integer
    add_index :questions, :author_id
  end
end
