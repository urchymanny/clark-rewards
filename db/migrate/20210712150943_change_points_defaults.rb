class ChangePointsDefaults < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :points, :float, default: 0.0
  end
end
