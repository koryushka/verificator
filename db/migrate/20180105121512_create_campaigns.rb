class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.integer :job_id
      t.integer :status
      t.string :external_reference, index: { unique: true }
      t.string :ad_description

      t.timestamps
    end
  end
end
