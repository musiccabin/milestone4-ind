# Makefile for smarter data analysis pipeline
# Replaces runall.sh functionality using GNU Make

# Define variables
PYTHON = python
QUARTO = quarto

# Data files and corresponding intermediate results
DATA_FILES = data/isles.txt data/abyss.txt data/last.txt data/sierra.txt
RESULTS = results/isles.dat results/abyss.dat results/last.dat results/sierra.dat
PLOTS = results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
REPORT = report/count_report.html

# Pattern rules
results/%.dat: data/%.txt
	$(PYTHON) scripts/wordcount.py --input_file=$< --output_file=$@

results/figure/%.png: results/%.dat
	$(PYTHON) scripts/plotcount.py --input_file=$< --output_file=$@

# Targets
.PHONY: all clean

all: $(RESULTS) $(PLOTS) $(REPORT)

$(REPORT): $(PLOTS) report/count_report.qmd
	$(QUARTO) render report/count_report.qmd

clean:
	rm -f $(RESULTS) $(PLOTS) $(REPORT)
