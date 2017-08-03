library(stringr)
library(magrittr)
library(readxl)
library(jiebaR)
Dictionary <- read_excel("E:/Dictionary_diagnosis.xlsx",col_names = FALSE)
colnames(Dictionary)=c("value","key","source")


x= "1.(肝右叶)肝细胞癌，细梁型，Ⅱ级，MVI分级=M0；2.慢性胆囊炎。"

valueP=paste0("[",paste0(Dictionary$value,collapse = "|"),"]","++")

str_extract_all(x, pattern =valueP)


segment(x,worker(stop_word = "D:/cancerTumor/stopword.txt",user = 'D:/cancerTumor/userDict.dict',symbol=T))
