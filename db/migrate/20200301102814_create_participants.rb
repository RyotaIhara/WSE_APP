class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :event, foreign_key: true                               #参加企画
      t.references :user, foreign_key: true                                #参加者名
      t.boolean :participated_flg, null: false, default: false             #イベント参加済フラグ
      t.boolean :delete_flg, null: false, default: false                   #イベント不参加フラグ

      t.timestamps
    end
  end
end
