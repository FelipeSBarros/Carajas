quit()
######
##MASCARA
######
--ALVO: CRIAR MASCARA
cd /home/felipe/Felipe/CARAJAS/Dados/Mascara/Output2
sudo su
su postgres
--mask valor1
pgsql2shp -f mascara1.shp -h localhost -u postgres -P postgres carajas "select 1 as val, g.geom from infra_estrutura.avc_lvr_n4ws infra1 inner join grid.grid_sir g on st_intersects(infra1.geom,g.geom) union select 1 as val, g.geom from infra_estrutura.estrutura_mina infra2 inner join grid.grid_sir g on st_intersects(infra2.geom,g.geom) union select 1 as val, g.geom from infra_estrutura.s11d_sir infra3 inner join grid.grid_sir g on st_intersects(infra3.geom,g.geom)"
--mask valor 2
pgsql2shp -f mascara2.shp -h localhost -u postgres -P postgres carajas "select 2 as val, g.geom from public.geoambientes geo inner join grid.grid_sir g on st_intersects(geo.geom,g.geom)"
--mask valor3
pgsql2shp -f mascara3.shp -h localhost -u postgres -P postgres carajas "select 3 as val, g.geom from cavernas.cavernas c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.rel_maxima='1' union select 3 as val, g.geom from cavernas.cavernas c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.cav_testemunho='1' union select 3 as val, g.geom from infra_estrutura.lagos_buffers_500 lb inner join grid.grid_sir g on st_intersects(lb.geom,g.geom)"
--feito processamento para retirar sobreposicao (removido plo de valo 2 sobreporto ao 1.Removido polvalor 2 sobreposto valor 3. marge dos shps e rasterização

--Rasterizando Mascara

for a in  *.shp; do echo PROCESSANDO $a; gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l ${a%.*} $a ${a%.*}.tif; done
cd ..

select row_number() over(order by c.gid) as id, 3 as val, g.geom from cavernas.cavernas c inner join grid.grid_sir g on st_intersects(c.geom,g.geom) where c.rel_maxima='1'

select row_number() over(order by lb.gid) as id, 3 as val, g.geom from infra_estrutura.lagos_buffers_500 lb inner join grid.grid_sir g on st_intersects(lb.geom,g.geom)

select row_number() over(order by geo.gid) as id, 2 as val, g.geom from public.geoambientes geo inner join grid.grid_sir g on st_intersects(geo.geom,g.geom)

#####
##Criando mascara para cenarios 5 e 6
#####
--Rasterizando Mascara
--Os dados ja licenciado, com valor 1 se mantiveram. as demais areas (valor 2) foram transformadas em 3, excetos as em N1, N3 e N5 q ficaram com valor 2. As areas sobrepostas a cav de proj_horizontal, presenca troglobios e area foram ainda transformadas em valor 4(bloqueadas). As mascaras com valor 3 viraram valor 4.
cd /home/felipe/Felipe/CARAJAS/Dados/Mascara/Cenarios_5_6/
gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l Mascara_final Mascara_final.shp Mascara_N1_N3_N5.tif

--Cenário 7
cd /home/felipe/Felipe/CARAJAS/Dados/Mascara/Cenario7/
gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l Mascara_c7 Mascara_c7.shp Mascara_c7_versao2.tif

--Cenário 8
cd /home/felipe/Felipe/CARAJAS/Dados/Mascara/Cenario8/
gdal_rasterize -a val -tr 500.0 500.0 -te 550513.78 9279479.60 632013.78 9336979.60 -a_nodata 0 -l Mascara_c8 Mascara_c8.shp Mascara_c8.tif
