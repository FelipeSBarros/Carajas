quit()

cd pgsql/Carajas/workshop

######################
#MUDANCAS DE CUSTO!
######################
--TARZAN
 pgsql2shp -f teste_tarzan.shp -h localhost -u postgres -P postgres carajas "select t.massa, g.geom from workshop.grid_500_tarzan_sir t inner join grid.grid_sir g on st_intersects(g.geom, t.geom)"

--corpos AB
pgsql2shp -f teste_ab.shp -h localhost -u postgres -P postgres carajas "select ab.massa, g.geom from workshop.grid_500_ab_sir ab inner join grid.grid_sir g on st_intersects(g.geom, st_centroid(ab.geom))"

Custo PTOS
pgsql2shp -f ptos.shp -h localhost -u postgres -P postgres carajas "select sum(ptos.massa), g.geom from workshop.recursos_ptos_sir ptos inner join grid.grid_sir g on st_intersects(g.geom, st_centroid(ptos.geom))group by g.geom"

UNIAO TODOS
pgsql2shp -f custo_final.shp -h localhost -u postgres -P postgres carajas  "select sum(ptos.massa), g.geom from workshop.recursos_ptos_sir ptos inner join grid.grid_sir g on st_intersects(g.geom, st_centroid(ptos.geom))group by g.geom union select ab.massa, g.geom from workshop.grid_500_ab_sir ab inner join grid.grid_sir g on st_intersects(g.geom, st_centroid(ab.geom)) union select t.massa, g.geom from workshop.grid_500_tarzan_sir t inner join grid.grid_sir g on st_intersects(g.geom, t.geom)"

gdal_rasterize -a SUM -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l custo_final custo_final.shp custo_final.tif

mkdir cavernas
sudo chmod 777 cavernas

--Cavernas
######
# ALVO: Projecao horizontal: 
######
#um raster com valor do pixel = quantidade cavernas com PH>93(media+devpad) [atributo porj.horiz. da tabela 'espeleometria']
#NAO HA NECESSIDADE DE CRIAR CSV
######
##criando o shp
######
cd cavernas
sudo su
su postgres
pgsql2shp -f proj_horizontal_workshop.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.proj_horizontal) as val, g.geom FROM cavernas.espeleometria as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.proj_horizontal>=93 GROUP BY g.geom"

######
# ALVO: AREA
######
pgsql2shp -f area_workshop.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.proj_horizontal) as val, g.geom FROM cavernas.espeleometria as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.area>=362.5 GROUP BY g.geom"

######
# ALVO: Densidade de Caverna
######
#count cavernas contidas no grid
pgsql2shp -f Densidade_Cav.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) GROUP BY g.geom"

######
# ALVO: Alta Riqueza spp
######
pgsql2shp -f alta_riqueza_spp.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.alta_riqueza_spp='1' GROUP BY g.geom"

######
# ALVO: TROGLOMOFICOS
######
pgsql2shp -f troglobios_spp.shp -h localhost -u postgres -P postgres carajas "SELECT count(distinct c.troglomorfismo) as val, g.geom FROM fauna.fauna_cav_sir as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) GROUP BY g.geom"

##QUIROPTERO
pgsql2shp -f quiropteros.shp -h localhost -u postgres -P postgres carajas "SELECT 1 as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.quiropteros='1' GROUP BY g.geom"

##BAT_CAVE
pgsql2shp -f bat_cave.shp -h localhost -u postgres -P postgres carajas "SELECT 1 as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.bat_cave='1' GROUP BY g.geom"

######
# ALVO: presenca agua
######
pgsql2shp -f cav_agua.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.pres_agua='1' GROUP BY g.geom"

######
# ALVO: Litologias(Mafica, FFB, Ferricrete, Canga), Espeleotemas raros ediversidade
######
##Mafica
pgsql2shp -f cav_mafica.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.mafica='1' GROUP BY g.geom"
##FFB
pgsql2shp -f cav_ffb.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.ffb='1' GROUP BY g.geom"
##ferricrete
pgsql2shp -f cav_ferricrete.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.ferricrete='1' GROUP BY g.geom"
##canga
pgsql2shp -f cav_canga.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.canga='1' GROUP BY g.geom"

##espeleotemas raros
DESONSIDERADO REDUNDANTE COM MAXIMA RELEVANCIA

##diversidade espeleotemas
pgsql2shp -f cav_espeleot_diversidade.shp -h localhost -u postgres -P postgres carajas "SELECT count(c.gid) as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.espeleotem_diversidade='1' GROUP BY g.geom"

######
# ALVO: Maxima relevancia; testemunho DESCONSIDERADOS PELA REDUNDANCIA COM PH E AREA
######
##Relevancia maxima
--#pgsql2shp -f ./Cavernas/Output/shp/relevancia_maxima.shp -h localhost -u postgres -P postgres carajas "SELECT 1 as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.rel_maxima='1' GROUP BY g.geom"
##Testemunho
--#pgsql2shp -f ./Cavernas/Output/shp/cav_testemunho.shp -h localhost -u postgres -P postgres carajas "SELECT 1 as val, g.geom FROM cavernas.cavernas as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) where c.cav_testemunho='1' GROUP BY g.geom"

######
##Rasterizando TODOS os shapes em /output/shp
######
cd Cavernas/Output/shp/
for a in  *.shp; do echo PROCESSANDO $a; gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l ${a%.*} $a ${a%.*}.tif; done
cd ..

###########################################
ATUALIZACOES DA FLORA
cd flora/mudancas
ls *.shp
sudo su
su postgres
for a in *.shp; do shp2pgsql -W UTF8 -s 31982 $a workshop.${a%.*} | psql -h localhost -d carajas ;done


######
##ALVO: ESPESCIES AMEACADAS
######
mkdir ameacadas
sudo chmod 777 ameacadas
cd ..
cd flora/mudancas/ameacadas
sudo su
su postgres
psql carajas

## Listar spp ameacadas
COPY (SELECT distinct(a.nome_spp), count(a.gid) as val, a.categoria as categoria FROM workshop.ameacadas as a JOIN grid.grid_sir as g ON ST_Contains(g.geom, a.geom) group by a.nome_spp, a.categoria) TO '/home/felipe/pgsql/Carajas/workshop/flora/mudancas/ameacadas/flora_ameacada.csv' WITH CSV HEADER;

\q
exit
exit

##########################
## CARIAR BASH
./flora_ameacadas_EXE.sh
#########################
######
##Rasterizando
######
cd ameacadas/
for a in  *.shp; do echo PROCESSANDO $a; gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l ${a%.*} $a ${a%.*}.tif; done
cd ..


######
##Rasterizando
######
#MUDAR PARA PASTA
for a in  *.shp; do echo PROCESSANDO $a; gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l ${a%.*} $a ${a%.*}.tif; done
####

##Erythroxylum_nelson-rosae_Plowman
pgsql2shp -f erythroxylum.shp -h localhost -u postgres -P postgres carajas "SELECT 1 as val, g.geom FROM workshop.erythroxylum as c inner join grid.grid_sir as g ON ST_Contains(g.geom, c.geom) GROUP BY g.geom union SELECT 1 as val, g.geom FROM flora.flora as f inner join grid.grid_sir as g ON ST_Contains(g.geom, f.geom) where nome_spp= 'Erythroxylum_nelson-rosae_Plowman' GROUP BY g.geom"

gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l erythroxylum erythroxylum.shp Erythroxylum_nelson-rosae_Plowman_mod.tif

exit

cd ..
######
--MASCARA
##############
## ALVO: CRIAR MASCARA
##############

sudo su
su postgres
--mask valor1
pgsql2shp -f mascara1.shp -h localhost -u postgres -P postgres carajas "select 1 as val, g.geom from infra_estrutura.avc_lvr_n4ws infra1 inner join grid.grid_sir g on st_intersects(infra1.geom,g.geom) union select 1 as val, g.geom from infra_estrutura.estrutura_mina infra2 inner join grid.grid_sir g on st_intersects(infra2.geom,g.geom) union select 1 as val, g.geom from infra_estrutura.s11d_sir infra3 inner join grid.grid_sir g on st_intersects(infra3.geom,g.geom)"
--mask valor 2
pgsql2shp -f mascara2.shp -h localhost -u postgres -P postgres carajas "select 2 as val, g.geom from public.geoambientes geo inner join grid.grid_sir g on st_intersects(geo.geom,g.geom)"
--mask valor3
pgsql2shp -f mascara3.shp -h localhost -u postgres -P postgres carajas "select 3 as val, g.geom from cavernas.cavernas c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.rel_maxima='1' union select 3 as val, g.geom from cavernas.cavernas c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.cav_testemunho='1' union select 3 as val, g.geom from infra_estrutura.lagos_buffers_500 lb inner join grid.grid_sir g on st_intersects(lb.geom,g.geom)"
--mask valor 1000
--TARZAN
pgsql2shp -f tarzan_conserv.shp -h localhost -u postgres -P postgres carajas "select 1000 as val, g.geom from geoambientes c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.local='Tarzan'"
--BOCAINA
pgsql2shp -f bocaina_conserv.shp -h localhost -u postgres -P postgres carajas "select 1000 as val, g.geom from geoambientes c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.local='Bocaina'"

--REMOCAO BOCAINA
pgsql2shp -f sem_bocaina2.shp -h localhost -u postgres -P postgres carajas "select 0 as val, g.geom from geoambientes c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.local='Bocaina' union select 1 as val, g.geom from geoambientes c inner join grid.grid_sir g on st_disjoint(c.geom,g.geom) where c.local='Bocaina'"


--feito processamento para retirar sobreposicao (removido plo de valo 2 sobreporto ao 1.Removido polvalor 2 sobreposto valor 3. marge dos shps e rasterização
######
##Rasterizando Mascara
######
cd pgsql/Carajas/workshop/mascara/finais
for a in  *.shp; do echo PROCESSANDO $a; gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l ${a%.*} $a ${a%.*}.tif; done
cd ..

gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -l sem_bocaina sem_bocaina.shp sem_bocaina.tif
