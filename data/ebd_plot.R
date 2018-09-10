library(raster)
library(rasterExtras)
library(data.table)
nclus = 24;
samsize = 50000;
resam = 100;
bandwidth = 2; #a value in kilometers

ebd = fread('ebd_trim2.csv', sep = '\t')
clim = stack("../climgrids/bio.gri")
clim = clim[[1]];
ext = extent(c(-125, -100, 25, 45));
clim = crop(clim,ext);

stackit = list();

#for (i in 1:resam){
#	stackit[[i]] = gkde(clim, ebd[sample(1:nrow(ebd), samsize),4:3], parallel =TRUE, nclus = nclus, maxram = 96, bw = 4);	
#}

stackit = gkde(clim, ebd[,4:3], parallel=TRUE, nclus=nclus, maxram = 64, bw=bandwidth);
#stackit = dist2points(clim, ebd[,4:3], parallel=TRUE, nclus=nclus, maxram = 64)
#stacked = stack(unlist(stackit))


#merged = sum(stacked)/resam;

merged = stackit;

save.image('ebd.plots.RData')

plot(merged, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')


plot(merged**0.1, col = viridis::magma(9999))  
plot(usa1, add=TRUE, border='white')
dev.off();



png('ebird_density.png', height = 8, width = 8, res = 600, units = 'in')
plot(merged, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')
dev.off()


merged.scaled = merged/maxValue(merged)
png('ebird_densityscaled.png', height = 8, width = 8, res = 600, units = 'in')
plot(merged.scaled, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')
dev.off()

merged.5root = merged.scaled**(1/5)
png('ebird_density5root.png', height = 8, width = 8, res = 600, units = 'in')
plot(merged.5root, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')
dev.off()

merged.log10 = log(merged+0.00000001, base=10)  
png('ebird_loglik.png', height = 8, width = 8, res = 600, units = 'in')
plot(merged.log10, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')
dev.off()




save.image('ebd.plots.RData');

q('no');
