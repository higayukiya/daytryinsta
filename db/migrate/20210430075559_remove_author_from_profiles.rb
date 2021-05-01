class RemoveAuthorFromProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :nickname, :string
  end
end
