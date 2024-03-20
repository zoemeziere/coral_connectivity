library(genepop)

PverTaxon1A_IBD_10000 <- ibd(inputFile= "PverTaxon1A_genepop_mercator.txt", outputFile = "PverTaxon1A_genepop_1d_All_out.txt", statistic='a', dataType='Diploid', settingsFile = '', geographicScale='1D', verbose = interactive())
