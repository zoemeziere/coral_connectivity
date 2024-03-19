#Script to run Genepop for Stylophora pistillata

library(genepop)

StyloTaxon1_IBD_all_test <- ibd(inputFile= "StyloTaxon1_genepop.txt", 
        outputFile = "StyloTaxon1_genepop_out.txt", 
        statistic='a', 
        dataType='Diploid', 
        settingsFile = '', 
        geographicScale=‘2D')
