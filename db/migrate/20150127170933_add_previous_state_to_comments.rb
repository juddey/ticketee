class AddPreviousStateToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :previous_state, index: true
    add_foreign_key :comments, :previous_states
  end
end
