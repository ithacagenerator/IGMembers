class CreateJoinTableInterestsMembers < ActiveRecord::Migration
  def change
    create_join_table :interests, :members do |t|
      # t.index [:interest_id, :member_id]
      # t.index [:member_id, :interest_id]
    end
  end
end
