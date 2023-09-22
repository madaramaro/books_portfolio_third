class Aibook
  # 属性のアクセサを定義
  attr_accessor :title, :isbn, :description, :image_url, :author, :publisher, :published_date

  # 初期化メソッドを定義
  def initialize(attrs = {})
    @title = attrs[:title]
    @isbn = attrs[:isbn]
    @description = attrs[:description]
    @image_url = attrs[:image_url] # このサンプルでは使っていませんが、参考のために追加
    @author = attrs[:author]
    @publisher = attrs[:publisher]
    @published_date = attrs[:published_date]
  end
end
