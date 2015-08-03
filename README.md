# Carajas
## This repository holds all scripts used to organize and generate the input raster data to run Zonation.
  
##Scripts available
**adequacao_bd**: This script makes clear all processes used during the database preparation and rectification in order to document all procedures executed;

**input_creation**: This is the core script for generating all Zonation raster data. **Plase note** that in this script we make use of PostGIS tools ('pgsql2shp'), GDAL and some loops in bash.
  
**Some procedures may not be specified as a script for being run in GUI. But for sure the procedure done is  mentioned.**
  
**mascaras**: In this script all process done to produce each kind of maks used in Zonation analysis.

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Licença Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Zonation scripts</span> de <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/FelipeSBarros/Carajas/edit/master/README.md" property="cc:attributionName" rel="cc:attributionURL">Felipe Sodré Barros</a> está licenciado com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons - Atribuição-NãoComercial-CompartilhaIgual 4.0 Internacional</a>.
