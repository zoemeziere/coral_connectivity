library(genepop)

PverTaxon1A_IBD_10000 <- ibd(inputFile= "Pver_genepop_mercator.txt", outputFile = "Pver_genepop_1d_out.txt", statistic='a', dataType='Diploid', settingsFile = '', geographicScale='1D', verbose = interactive())
