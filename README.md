# Proyecto de análisis de datos de polución en Argentina

[Idea origina](https://github.com/FelipeSBarros/EngolindoFumaca_paper)

1. [Creando el ambiente de trabajo](#creando-el-ambiente-de-trabajo)
1. [Configuración de acceso](#configuración-de-acceso)
   1. Crea usuário para acceder al [Atmospheric Data Store (ADS)](https://ads.atmosphere.copernicus.eu/#!/home). 
   1. Identifica tu [clave](https://api.ecmwf.int/v1/key/).
   1. Instala el [cdsapi](#instalando-el-cdsapi)
1. [Descarga de datos](#descarga-de-datos)
1. [Organización de los datos descargados](#organización-de-los datos-descargados)

[Acceso a los datos publicos](https://confluence.ecmwf.int/display/WEBAPI/Access+ECMWF+Public+Datasets)

## Creando el ambiente de trabajo

```commandline
#mkdir polucion_ar
#cd polucion_ar
#git init
#touch README.md
git clone git@github.com:FelipeSBarros/polucion_ar.git
cd polucin_ar
#python -m venv .venv
poetry install
```

## Configuración de acceso

1. Crea el archivo `.cdsapirc` y añadelos datos [de aceso](https://ads.atmosphere.copernicus.eu/api-how-to):
2. [Más infos](https://confluence.ecmwf.int/display/WEBAPI/Access+ECMWF+Public+Datasets)

```commandline
touch ~/.cdsapirc
# agregar infos de clave al archivo
```

### instalando el cdsapi

```commandline
pip install --upgrade pip
pip install cdsapi 
pip install python-dateutil
```

### Descarga de datos

Ejemplo de requisición con el `cdsapi`:

```commandline
import cdsapi

c = cdsapi.Client()

c.retrieve(
    'cams-global-atmospheric-composition-forecasts',
    {
        'type': 'forecast',
        'format': 'netcdf_zip',
        'variable': 'particulate_matter_2.5um',
        'date': '2023-05-01/2023-05-02',
        'time': [
            '00:00', '12:00',
        ],
        'leadtime_hour': [
            '0', '12', '6',
        ],
    },
    'download.netcdf_zip')
```

#### parâmetro `area`
Debe ser informada una lista con cuatro elementos: latitude norte (max y), longitude oeste (min x), latitude sul (min x) e longitude este (max x).

```python
{
   ...,
    "area":  [6.1599998802974305, -73.99, -18.04, -43.3899994411983982],
}
```

[**Script python usado**](./Download_pm25_monthly.py)

## Organización de los datos descargados

* unzip;
[Script de organização dos dados](./organinzing_cams_data.py)

## Conversão em objeto R

* Consolidação dos `netCDF` em um `rds` mensal;
* Consolidação dos `netCDF` em um `rds` mensal com valor médio diário de pm<2.5;
* Extração dos valores de pm>2.5 médios diários por município;
 
[Processo desenvolvido em R](./Scripts/R/1_organize_extract_pm25.R)
