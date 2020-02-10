class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :competition                                         #競技
      t.date :scheduled_date                                        #予定日
      t.string :match_team                                          #試合チーム
      t.string :place                                               #場所
      t.references :user, foreign_key: true                         #主催者
      t.integer :number_applicants                                  #募集人数
      t.integer :cost                                               #費用
      t.text :other_necessary                                       #その他必要なもの
      t.text :note                                                  #備考
      t.boolean :cancel_flg, null: false, default: false            #イベント中止

      t.timestamps
    end
  end
end
