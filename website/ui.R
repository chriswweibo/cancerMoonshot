library(shiny)
library(shinythemes)
library(highcharter)
library(rChartsCalmap)
library(parcoords)
library(d3wordcloud)
library(DT)
# Define UI for application that draws a histogram
shinyUI(navbarPage(selected="数据上传",collapsible=T,header = tags$style(type="text/css", "body {padding-top: 70px;}"), position ="fixed-top",
                   theme = shinytheme("cosmo"),
                   "中国抗癌登月平台",
                   tabPanel("首页",
                            sidebarPanel(width=12,h4("数据平台")),
                            sidebarPanel(" ",width=2,
                              radioButtons("gender","性别",c("男"="男","女"="女"),inline =T),
                              sliderInput("age", "年龄",min=0,max=100,value = c(50, 70)),
                              selectInput("type","癌种",c("肝癌"="肝癌","肺癌"="肺癌","胃癌"="胃癌")),
                              selectInput("province","地区",c("北京"="北京","河北"="河北","山东"="山东")),
                              dateRangeInput("date","报告日期",start= "1970-01-01", end = Sys.Date(), format = "yyyy/mm/dd", separator = " - ")),
                            
                            mainPanel(width=3,h4("癌种占比"),
                                      highchartOutput("pSite")),
                            mainPanel(width=4,h4("数据趋势"),
                                      highchartOutput("dataTrend")),
                            mainPanel(width=3,h4("医院贡献"),
                                      highchartOutput("Hospitals")),
                            sidebarPanel(width=12,h4("我的记录")),
                            sidebarPanel(width=12,"实时信息",
                                         h4("xxxxxxxxxxxxxxxxxxxxxxxxxxx")),
                            mainPanel(width=3,h4("活跃记录"),
                                      calheatmapOutput("record")),
                            mainPanel(width=6,h4("被下载排名"),
                                      highchartOutput("projects",height="150px")),
                            mainPanel(width=3,h4("关系网络"),
                                      d3wordcloudOutput("relation",height="150px"))
                            
                              ),
                   navbarMenu("数据项目",
                              tabPanel("数据上传",
                                       sidebarPanel(width=3,
                                                    textInput("nama","项目名称",placeholder = "仅限中英文，数字，下划线"),
                                                    fileInput("file","选取文件",accept = "仅限csv，tsv，xls文件",buttonLabel="选择本地文件"),
                                                    checkboxInput("storage","存储声明:如果项目名称已经存在，则新数据进行追加",value=T),
                                                    checkboxInput("privacy","隐私声明：数据适合公开，支持他人下载",value=F)),
                                       mainPanel(width=9,"数据详情",
                                                 parcoordsOutput("detail")),
                                       mainPanel(width=12,"数据结果",
                                                dataTableOutput("structured"))
                                       ),
                              tabPanel("数据分析"),
                              tabPanel("数据报告")),
                   navbarMenu("数据仓库",
                              tabPanel("数据共享"),
                              tabPanel("申请标注"),
                              tabPanel("数据报告")),
                   navbarMenu("知识图谱",
                              tabPanel("癌症基础"),
                              tabPanel("病理知识"),
                              tabPanel("药物数据"),
                              tabPanel("基因检测")),
                   navbarMenu("学术前沿",
                              tabPanel("科研论文"),
                              tabPanel("业界最新")),
                   navbarMenu("政策指南",
                              tabPanel("国家政策"),
                              tabPanel("国际标准"),
                              tabPanel("诊疗指南")),
                   navbarMenu("关于",
                              tabPanel("相关文档"),
                              tabPanel("数据隐私"),
                              tabPanel("增值服务"),
                              tabPanel("媒体咨询"),
                              tabPanel("联系方式"))
  

))

