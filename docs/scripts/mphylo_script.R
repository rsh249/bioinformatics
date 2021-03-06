curl https://raw.githubusercontent.com/rsh249/bioinformatics/master/docs/vert_mito_trim.fa > vert_mito_trim.fa

#RAxML has been installed at system level as 'raxmlHPC'

muscle -in vert_mito_trim.fa -phyiout out.phy -maxiters 20

raxmlHPC -f a -p 12345 -x 12345 -N 200 -T 20 -s out.phy -m GTRCAT -n hw
raxmlHPC -f b -t ref -z RAxML_bootstrap.hw -m GTRCAT -n consensus


