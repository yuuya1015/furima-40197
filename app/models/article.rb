class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  # 空の投稿を保存できないようにする
  validates :title, :text, presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :genre_id, numericality: { other_than: 1, message: "can't be blank" }

  # この後、ルーティングを設定して、コントローラーとビューを作成する必要があるかもしれない。
end
