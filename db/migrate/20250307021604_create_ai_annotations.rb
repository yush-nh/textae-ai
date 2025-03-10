class CreateAiAnnotations < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_annotations do |t|
      t.string :uuid, null: false
      t.text :content

      t.timestamps
    end
  end
end
