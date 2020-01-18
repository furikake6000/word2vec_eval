require 'nokogiri'
require 'open-uri'

url = 'https://thesaurus.weblio.jp/category/aa'

charset = nil

loop do
  html = open(url) do |f|
      charset = f.charset
      f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)
  doc.css('ul.CtgryUlL a.crosslink').each do |node|
    p node.inner_text
  end

  # 次のページが存在すれば移動
  nextlink = doc.at('a:contains("次へ＞")')
  if nextlink
    url = nextlink.attribute('href')
  else
    break
  end
end