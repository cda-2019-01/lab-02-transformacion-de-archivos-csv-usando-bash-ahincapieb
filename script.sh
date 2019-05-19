# Escriba su código aquí
#!/bin/bash
# Borrar encabezados de los archivos estaciones 2, 3 y 4 respectivamente
sed "1d" estacion2.csv > estacion22.csv
sed "1d" estacion3.csv > estacion33.csv
sed "1d" estacion4.csv > estacion44.csv
# Agregar nombre de la estación
sed 's/\([0-9][0-9]\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion1;\1\/2\/3/g' estacion1.csv > estacion1a.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion2;\1\/2\/3/g' estacion22.csv > estacion2a.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion3;\1\/2\/3/g' estacion33.csv > estacion3a.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion4;\1\/2\/3/g' estacion44.csv > estacion4a.csv
# Consolidacion de archivos estaciones
touch estacionestotal.csv
awk 'FNR==1 && NR!=1{next;}{print}' estacion1a.csv estacion2a.csv estacion3a.csv estacion4a.csv > estacionestotal.csv  
# Cambio de "," por "."
sed 's/,/./g' estacionestotal.csv > estacionestotal1.csv
# Cambio de separadores ";" por ","
sed 's/;/,/g' estacionestotal1.csv > estacionestotal2.csv
# Cambio de "/" por "-"
sed 's/\//-/g' estacionestotal2.csv > estacionestotal3.csv
# Organizar formato año AAAA
sed 's/-\([0-9]*\),/-0\1,/g' estacionestotal3.csv > estacionestotal4.csv
sed 's/-\([0-9]*\),/-20\1,/g' estacionestotal4.csv > estacionestotal5.csv
# Organizar formato mes MM
sed 's/-\([0-9]*\)-/-0\1-/g' estacionestotal5.csv > estacionestotal6.csv
# Cambiar - por , (para separar por columnas)
sed 's/-/,/g' estacionestotal6.csv > estacionestotal7.csv
# Nombrar columnas
sed 's/FECHA,/ESTACION,DIA,MES,YEAR,/g' estacionestotal7.csv > estacionestotal8.csv
# Consultas SQL
csvsql --query 'select ESTACION, MES, avg(VEL) from estacionestotal8 GROUP BY ESTACION, MES' estacionestotal8.csv >> velocidad-por-mes.csv #
csvsql --query 'select ESTACION, YEAR, avg(VEL) from estacionestotal8 GROUP BY ESTACION, YEAR' estacionestotal8.csv >> velocidad-por-ano.csv #
csvsql --query 'select ESTACION, HHMMSS, avg(VEL) from estacionestotal8 GROUP BY ESTACION, HHMMSS' estacionestotal8.csv >> velocidad-por-hora.csv #
head velocidad-por-mes.csv
head velocidad-por-ano.csv
head velocidad-por-hora.csv