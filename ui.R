library(shiny)

shinyUI(fluidPage(

  # アプリケーション名
  headerPanel("CodeZine「Tech-Sketch」出張所"),

  # サイドバー
  sidebarPanel(width = 5,
    selectInput("selection", "記事を選んで下さい",
                choices = articles),
    actionButton("update", "更新"),
    hr(),
    sliderInput("freq",
                "出現頻度の下限値:",
                min=1, max=50, value=5),
    sliderInput("max",
                "最大単語数:",
                min=1, max=300, value=100)
  ),

  # ワードクラウドと記事へのリンクを表示
  mainPanel(width=7,
    plotOutput("plot"),
    htmlOutput("link")
  )
))
