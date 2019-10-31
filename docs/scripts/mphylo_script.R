curl https://raw.githubusercontent.com/rsh249/bioinformatics/master/docs/seq.fa > data/merged.fa


cat data/merged.fa | awk -F "|" '{if($2 ~ /[A-Za-z_0-9]/){print ">" $4 }else{print $0}}' > data/trim.fa #accession numbers only

./muscle -in data/trim.fa -phyiout out.phy -maxiters 20

./raxml -f a -p 12345 -x 12345 -N 200 -T 20 -s out.phy -m GTRCAT -n hw
./raxml -f b -t ref -z RAxML_bootstrap.hw -m GTRCAT -n consensus


