library(shiny)
library(htmlwidgets)
library(highcharter)
library(magrittr)
library(rChartsCalmap)
library(D3TableFilter)
library(parcoords)
library(d3wordcloud)

shinyServer(function(input, output) {
   
  output$pSite <- renderHighchart({
    data=data.frame(部位=c("肝癌","胃癌","食道癌","乳腺癌","皮肤癌","宫颈癌","肺癌","膀胱癌","骨癌","肾癌","血癌","淋巴癌"),
                      报告量=as.integer(sample(1:100000,12)))
    hchart(data,"pie",hcaes(x=部位,y=报告量),name="报告量")
  })
  
  output$dataTrend=renderHighchart({
    data=data.frame(日期=seq(from=as.Date("2016-08-03"), by=1, length.out=365),上传量=as.integer(sort(sample(100:464))+rnorm(365,0,20)))
    hchart(data,"spline",hcaes(x=日期,y=上传量),name="上传量")
  })
  
  output$Hospitals=renderHighchart({
    data=data.frame(医院=paste("医院",c(1:10),sep=""),上传量=sample(1:6000,10))
    hchart(data,"treemap",hcaes(x=医院,value=上传量,color=上传量),name="上传量")
  })
  output$record=renderCalheatmap({
    data=data.frame(日期=seq(from=as.Date("2016-08-03"), by=1, length.out=365),上传量=as.integer(sort(sample(10:200,365,replace = T))+rnorm(365,2,10)))
    calheatmap(x="日期",y="上传量",data=data,domain = 'month',start= Sys.Date()-183,legend = seq(0, 250, 50),itemName = '行上传量', range = 6)
  })
  
  output$projects=renderHighchart({
    data=data.frame(项目=c("项目1","项目2","项目3","项目4","项目5","项目6","项目7","项目8","项目9","项目10"),浏览量=sample(10:1000,10))
    hchart(data,"column",hcaes(x=项目,y=浏览量),name="下载量") %>% hc_size(height="200px")
  })
  output$relation=renderD3wordcloud({
    words <- c("黄渤", "黄晓明", "鹿晗", "吴亦凡", "陈伟霆", "李易峰", "古力娜扎", "迪丽热巴", "赵丽颖", "胡歌")
    freqs <- sample(seq(length(words)))
    
    d3wordcloud(words, freqs,tooltip=T,rotate.max = 0,rotate.min = 0, padding=0)
  })
 output$detail=renderParcoords({
   data(mtcars)
   parcoords(mtcars, brushMode = "2D-strums", reorderable = TRUE,autoresize=T)
})
 output$structured=renderDataTable({
   data(mtcars)
   datatable(mtcars,filter = 'top',extensions = c('Buttons','Responsive'),
             options = list(dom = 'Bfrtip', buttons = I('colvis'),searchHighlight = TRUE,language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Chinese.json'),
     initComplete = JS(
       "function(settings, json) {",
       "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
       "}")
   ))%>% formatStyle("mpg", background = styleColorBar(mtcars$mpg, 'steelblue'),backgroundSize = '100% 50%')
   #d3tf(mtcars, showRowNames = TRUE,filterInput = TRUE, tableStyle = "table table-bordered")
   
   # formattable(df, list(
   #   age = color_tile("white", "orange"),
   #   grade = formatter("span", style = x ~ ifelse(x == "A", 
   #                                                style(color = "green", font.weight = "bold"), NA)),
   #   area(col = c(test1_score, test2_score)) ~ normalize_bar("pink", 0.2),
   #   final_score = formatter("span",
   #                           style = x ~ style(color = ifelse(rank(-x) <= 3, "green", "gray")),
   #                           x ~ sprintf("%.2f (rank: %02d)", x, rank(-x))),
   #   registered = formatter("span",
   #                          style = x ~ style(color = ifelse(x, "green", "red")),
   #                          x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No")))
   # ))
 })
 })
