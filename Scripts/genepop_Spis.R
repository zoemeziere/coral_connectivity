library(genepop)

StyloTaxon1_IBD_all_test <- ibd(inputFile= "StyloTaxon1_genepop_mercator.txt", outputFile = "StyloTaxon1_genepop_1d_distance0-100000_out.txt", statistic='a', dataType='Diploid', maximalDistance = 100000, settingsFile = '', geographicScale='2D')
