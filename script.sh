#!/bin/bash
sed 's/\//-/g' data.csv > data1.csv
sed 's/-\([0-9][0-9]\);/-20\1;/' data1.csv > data2.csv
sed 's|\([0-9][0-9]\)-\([0-9][0-9]\)-\([0-9][0-9][0-9][0-9]\);|\3-\2-\1;|g' data2.csv > data3.csv
sed 's/\,/./g' data3.csv > data4.csv
sed 's/\;/,/g' data4.csv > data5.csv
sed -e 's:^,:/N,:g' -e 's:,,:,/N,:g' -e 's:,$:,/N:g' data5.csv > data6.csv
sed '\:/N:d' data7.csv > datafinal.csv
