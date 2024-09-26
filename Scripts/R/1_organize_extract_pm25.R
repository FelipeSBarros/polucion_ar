# rm(list=ls())
source("./Scripts/R/ToolBox.R")
library(geobr)
library(sf)
library(lubridate)

# Loading data ----
# Deptos
mun <- read_sf("./Data/Vectorial/departamento_continente.shp") %>% st_transform(4326) 

# Consolidating dates ----
args(cams_consolidation)
cams_consolidation(
  file_path = "./Data/Raw/CAMS_NRT/unzipped"
)

# Daily mean by mun sf ----
args(stars_extract)
dailyMeanMun <- stars_extract(
  rasterPath = "../../Data/Raw/CAMS_NRT", 
  pattern = '_daily.rds',
  sf = mun,
  stat='mean')

saveRDS(object = dailyMeanMun,
        file = '../../Data/tidy/municipios_pm25.rds',
        compress = TRUE)
