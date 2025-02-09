library(genepop)

StyloTaxon1_IBD_all_test <- ibd(inputFile= "Spis_genepop.txt", 
        outputFile = "Spis_genepop_out.txt", 
        statistic='a', 
        dataType='Diploid', 
        settingsFile = '', 
        geographicScale=‘2D')
