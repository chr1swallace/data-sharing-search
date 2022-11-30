# data-sharing-search
code used in https://www.biorxiv.org/content/10.1101/2022.09.27.509657v2 to identify publications that shared GWAS summary data outside of GWAS catalog.

To run, do

rake retrieve_data # gets all the full text available
rake get_available # identifies papers with data available
