class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name                                          #ユーザー名
      t.string :full_name                                     #フルネーム
      t.string :email                                         #メールアドレス
      t.integer :sex, null: false, default: 1                 #性別（1:男,2:女）
      t.string :password_digest                               #パスワード
      t.boolean :administrator, null: false, default: false   #管理者フラグ
      t.boolean :delete_flg, null: false, default: false      #削除フラグ

      t.timestamps
    end
  end
end
