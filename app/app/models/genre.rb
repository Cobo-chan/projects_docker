class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: "--" },
    { id: 2, name: "HR/HM" },
    { id: 3, name: "クラシック" },
    { id: 4, name: "ジャズ"},
    { id: 5, name: "ソウル/ブルース"},
    { id: 6, name: "レゲエ" },
    { id: 7, name: "クラブ/ダンス" },
    { id: 8, name: "ヒップホップ" },
    { id: 9, name: "J-POP" }
  ]

  include ActiveHash::Associations
  has_many :articles
end