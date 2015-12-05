############## FLORA
--ADEQUANDO GRAFIA ESPECIE MITRACARPUS CARAJAENSIS FLORA:
select * from flora.flora where nome_spp like '%carpus_cara%'

UPDATE flora.flora set nome_spp = 'Mitracarpus_carajasensis_E_L_Cabral' where nome_spp = 'Mitracarpus_carajasensis_E_L_Cabral,_Sobrado_&_E_B_Souza'

############## CAVERNAS
Adequação de dados de  troglobio apos insercao da contagem de troglobios
update cavernas.cavernas set quant_troglobios=0 where quant_troglobios='#N/A'


############## FAUNA
Organizaçãodo banco de dados fauna com categoria
alter table fauna.repteis_sir add column ameaca_geral varchar(4);
update fauna.repteis_sir set ameaca_geral=ameaca_iucn where ameaca_iucn in('CR','VU','NT');
update fauna.repteis_sir set ameaca_geral=ameaca_br where ameaca_br in('CR','VU','NT');
update fauna.repteis_sir set ameaca_geral=ameaca_para where ameaca_para in('CR','VU','NT');
##############



##Inserção dados sobre custo no BD:
--Alterando tabela geoambiente para adicionar coluna de recurso_reserva
alter table public.geoambientes add column recursos_reserva numeric
--Alterando tabela geoambiente para adicionar coluna de distancia
alter table public.geoambientes add column distancia numeric

--Alterando tabela geoambiente para adicionar coluna de area
alter table public.geoambientes add column area numeric

----Alterando tabela geoambiente para adicionar coluna de raw_cost valor rec_reserv/dist/area
alter table public.geoambientes add column raw_cost numeric

--Alterando tabela adicionando coluna cost
alter table public.geoambientes add column final_cost numeric


--Preenchendo as colunas
update public.geoambientes set recursos_reserva=5000 where local = 'Corpo D'

update public.geoambientes set distancia=17700 where local LIKE 'Corpo D'

update public.geoambientes set area=16.36 where local LIKE 'Corpo D'


select * from public.geoambientes where local LIKE 'Corpo%'

update public.geoambientes set raw_cost= recursos_reserva / distancia 


select max(raw_cost) from geoambientes  
where local='Tarzan'


update geoambientes set raw_cost = recursos_reserva/(distancia*2)/area
min 0.00129163627522489668
max 0.42806183115338882759


update public.geoambientes set final_cost=raw_cost/0.42806183115338882759 where raw_cost is not null
