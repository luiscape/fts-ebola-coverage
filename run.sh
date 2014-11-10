#!/bin/bash

# running the R scraper from the
# virtual environment
~/R/R-3.1.1/bin/Rscript tool/code/scraper.R

# running the python datastore scripts
source ~/venv/bin/activate
python ~/tool/code/create-datastore.py 93b92803-f9fa-45f4-bf72-73a8ab1d8922 API_KEY