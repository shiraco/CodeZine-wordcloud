library(wordcloud)
library(memoise)

# 全記事をlistとして保持
articles <<- list("R言語のデータ分析レポートをShinyでインタラクティブにしてみる～「環境構築編」"="8148",
                  "WebRTC（PeerJS）で遠隔作業支援システムを作る（実装編2）"="8018",
                  "WebRTC（PeerJS）で遠隔作業支援システムを作る（実装編1）"="8017",
                  "WebRTC（PeerJS）で遠隔作業支援システムを作る（基礎知識編）"="8016",
                  "オープンソースのクラウド基盤「OpenStack」で試すクラウドオーケストレーション"="7897",
                  "ScalaのWebアプリケーションフレームワーク「Play Framework」入門　～（3）"="7817",
                  "ScalaのWebアプリケーションフレームワーク「Play Framework」入門　～（2）"="7816",
                  "構成管理ツール「Chef」の一歩進んだ使い方 ―独自のResourceを定義する―"="7767",
                  "Node.jsのWebフレームワーク「Sails」を使ってpub/subアプリを作ってみる"="7696",
                  "ScalaのWebアプリケーションフレームワーク「Play Framework」入門　～（1）"="7580",
                  "オープンソースのワークフローエンジン「Activiti」チュートリアル"="7495",
                  "「D3.js」を使ったデータビジュアライゼーション"="7459",
                  "rChartsでR言語のデータ解析結果をダイナミックに可視化しよう"="7383",
                  "「AWS OpsWorks」で環境一式を自動構築"="7304",
                  "オープンソースのワークフローエンジン「Activiti」入門"="7251",
                  "Kinectを利用した簡単3Dモデル作成と3Dモデル活用法"="7183",
                  "PostgreSQL 9.2の同期レプリケーションを利用する際の勘所"="7109",
                  "スマホのネイティブアプリでSocket.IOを利用する"="7076",
                  "リアルタイムWebを構築しやすくする「Socket.IO」とは"="7075")

# 選択した記事のワードの出現頻度のデータのdata.frameを返す関数を定義する
# "memoise"パッケージを使って結果をキャッシュするようにしておく
getArticleDataFrame <- memoise(function(article) {

  # 記事の存在チェック
  if (!(article %in% articles))
    stop("記事が見つかりません。")

  # articleディレクトリから該当記事のTSVファイルをdata.frame型で読み込む
  read.csv(sprintf("./articles/%s.tsv", article), sep="\t", encoding="UTF-8")
})
