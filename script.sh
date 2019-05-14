# Agregar nombre de la estación
sed 's/\([0-9][0-9]\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion1;\1\/2\/3/g' estacion1.csv > estacion1a.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion2;\1\/2\/3/g' estacion2.csv > estacion2a.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion3;\1\/2\/3/g' estacion3.csv > estacion3a.csv
sed 's/\([0-9]*\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/estacion4;\1\/2\/3/g' estacion4.csv > estacion4a.csv
# Consolidacion de archivos estaciones
touch estacionestotal.csv
cat estacion1a.csv estacion2a.csv estacion3a.csv estacion4a.csv > estacionestotal.csv 
# Instalacion libreria SQL
sudo apt-get install -y csvkit  
# Cambio de "," por "."
sed 's/,/./g' estacionestotal.csv > estacionestotal1.csv
# Cambio de separadores ";" por ","
sed 's/;/,/g' estacionestotal1.csv > estacionestotal2.csv
# Cambio de "/" por "-"
sed 's/\//-/g' estacionestotal2.csv > estacionestotal3.csv
# Organizar formato mes y año
sed 's/-\([0-9]*\),/-0\1,/g' estacionestotal3.csv > estacionestotal4.csv
sed 's/-\([0-9]*\),/-20\1,/g' estacionestotal4.csv > estacionestotal5.csv
sed 's/-\([0-9]*\)-/-0\1-/g' estacionestotal5.csv > estacionestotal6.csv
# Nombres a columnas
sed 's/FECHA,/ESTACION,FECHA,AÑO,MES,HORA,/g' estacionestotal6.csv > estacionestotal7.csv
# Creacion de variables año, mes y hora
