all: cache/prov_data.csv figures/daily-cases-7day-avg.png cache/model-fit.rds report/covid-report.pdf

cache/prov_data.csv: data-raw/cases.csv data-raw/tests.csv R/clean_data.R
	Rscript R/clean_data.R
	
figures/daily-cases-7day-avg.png: R/create_figures.R cache/prov_data.csv
	Rscript R/create_figures.R
	
cache/model-fit.rds: R/fit_model.R cache/prov_data.csv
	Rscript R/fit_model.R
	
report/covid-report.pdf: report/covid-report.Rmd cache/model-fit.rds figures/daily-cases-7day-avg.png
	Rscript -e 'rmarkdown::render("report/covid-report.Rmd")'