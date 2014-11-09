library(shiny)

shinyServer(function(input, output, session) {

  # article変数への代入タイミングを制御するreactive関数を定義する
  article <- reactive({

    # "更新"ボタンが押されたタイミングでarticle変数の値を更新する
    input$update
    isolate({
      getArticleDataFrame(input$selection)
    })
  })

  # wordcloud()の呼び出し結果に再現性があるように設定する
  wordcloud_rep <- repeatable(wordcloud)

  # 画面(ui.R)へ渡すワードクラウドを変数output$plotへ格納する
  output$plot <- renderPlot({

    article.df <- article()

    # par(family="Hiragino Mincho Pro W6")  # Mac
    # par(family="IPAexMincho")  # Ubuntu ※fontの事前インストールが必要
    # (参考) http://sudori.info/stat/stat_fig_font.html

    # ワードクラウドの作成（min.freqとmax.wordsの値は画面から入力された値を受け取る）
    wordcloud_rep(article.df$word, article.df$freq, scale=c(4,0.5),
                  min.freq=input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })

  # articleURL変数への代入タイミングを制御するreactive関数を定義する
  articleURL <- reactive({

    # "更新"ボタンが押されたタイミングでarticleURL変数の値を更新する
    input$update
    isolate({
      sprintf("http://codezine.jp/article/detail/%s", input$selection)
    })
  })

  # 画面(ui.R)へ渡すリンクを変数output$linkへ格納する
  output$link <- renderUI({
    url <- articleURL()
    div(a(href=url, target="_blank", url), align="center")
  })
})
