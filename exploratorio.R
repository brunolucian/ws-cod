library(magrittr) # não vivo sem esse pacote
library(rvest) # principal pacote para web-scraping
library(readr) # usado para extrair numeros de texto
library(stringr) # usado para o data cleaning
library(curl) # usado como suporte para o rvest
library(tidyr) # data cleaning
library(dplyr) # data cleaning


url_cod <- "https://cod.tracker.gg/warzone/leaderboards/stats/all/Kills?page=1"
# number_pages <- 100 #hard coded
# Criar vetor com todos os urls para as páginas do olx
# lista_urls <- paste0(url_apt, "?o=", 1:number_pages)

# url_teste <- lista_urls[1]
# system.time(df <- extrairAnuncios(url_teste, info_adicional = TRUE))

mycurl <- curl(url_cod, handle = curl::new_handle("useragent" = "Mozilla/5.0"))
mycurl <- read_html(mycurl)

url <- mycurl %>% 
  html_nodes("div.container.card.bordered.responsive") %>% 
  html_nodes("div.board") %>% 
  html_nodes("table")

table_kills <- url %>% 
  html_table(x, header = T) %>% 
  as.data.frame()


url_cod <- "https://cod.tracker.gg/warzone/leaderboards/stats/all/Kills?page="

table_kills <- list()

for (paginas in 1:10) {
  print(paginas)
  # Criar vetor com todos os urls para as páginas do olx
  url_cod_aux <- paste0(url_cod, paginas)
  
  # url_teste <- lista_urls[1]
  # system.time(df <- extrairAnuncios(url_teste, info_adicional = TRUE))
  Sys.sleep(10)
  mycurl <- curl(url_cod_aux, handle = curl::new_handle("useragent" = "Mozilla/5.0"))
  mycurl <- read_html(mycurl)
  
  url <- mycurl %>% 
    html_nodes("div.container.card.bordered.responsive") %>% 
    html_nodes("div.board") %>% 
    html_nodes("table")
  
  table_kills <- url %>% 
    html_table(x, header = T) %>% 
    as.data.frame()
  
}


