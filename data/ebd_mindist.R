library(raster)
library(rasterExtras)
library(data.table)
nclus = 24;

ebd = fread('ebd_trim2.csv', sep = '\t')
clim = stack("../climgrids/bio.gri")
clim = clim[[1]];
ext = extent(c(-125, -100, 25, 45));
clim = crop(clim,ext);

stackit = dist2point(clim, ebd[,4:3], parallel=TRUE, nclus=nclus, maxram = 256)

merged = stackit;

save.image('ebd.mindist.RData')

plot(merged, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')
dev.off()



png('ebird_dist.png', height = 8, width = 8, res = 600, units = 'in')
plot(merged, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')
dev.off()


merged.scaled = 1-(merged/maxValue(merged)); ##Scaled 0 = high distance, 1 = low distance... Proportional to probability?
png('ebird_distscaled.png', height = 8, width = 8, res = 600, units = 'in')
plot(merged.scaled, col = c('black', viridis::magma(9999)));
usa1 = getData("GADM", cou='US', level=1)
plot(usa1, add=TRUE, border='white')
dev.off()

save.image('ebd.mindist.RData');

q('no');
