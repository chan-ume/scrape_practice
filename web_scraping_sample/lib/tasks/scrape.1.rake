# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# スクレイピング先のURL
url = ''
namespace :scrape do

  desc 'URLと会社名とメールアドレス'
  task :company => :environment do

    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを作成
    doc = Nokogiri::HTML.parse(html, nil, charset)
    # 取得したいタグへの経路？を書く．//で一気に該当箇所へ行けるよ
    doc.xpath('//table//td//td//a').each do |node|
        check = node.inner_text.include?("TEL") # 電話番号を取得したいときなど
        if check
                print node.inner_text + "\n"
        end
        
    end
  end
end