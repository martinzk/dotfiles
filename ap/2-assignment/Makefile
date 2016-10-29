ALL:
	clang++ -std=c++14 -O2 -Wall -g -pthread main.cpp -o main.out
MPDF:
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make report/master.tex
LPDF:
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make listing/listing.tex
