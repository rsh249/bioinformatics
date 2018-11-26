##from ENMevaluate object called eval
## with best model declared as object 'best'
# e.g., best=2

future= getData('CMIP5', var='bio', res=5, rcp=45, model='AC', year=70) #You can pick the parameter for rcp, model, and year
fu = crop(future, ext)
fu
names(fu) = names(predictors)

fupr = maxnet.predictRaster(eval@models[[best]], fu, type = 'exponential', clamp=TRUE)
plot(fupr)
plot(eval@predictions[[best]]>thr$equal_sens_spec)
plot(fupr>thr$equal_sens_spec)

