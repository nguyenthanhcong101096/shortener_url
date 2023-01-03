# frozen_string_literal: true

class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.string :hash_id, null: false, index: { unique: true }
      t.string :origin_url, null: false
      t.bigint :user_id, null: false
      t.datetime :expired_time

      t.timestamps
    end
  end
end
