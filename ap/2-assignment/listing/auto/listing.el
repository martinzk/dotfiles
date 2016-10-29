(TeX-add-style-hook
 "listing"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "a4paper" "total={18cm, 26cm}") ("fontenc" "T1") ("beramono" "scaled=0.85")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "report"
    "rep10"
    "geometry"
    "fontenc"
    "textcomp"
    "beramono"
    "MnSymbol"
    "listings"
    "xcolor")
   (LaTeX-add-listings-lstdefinestyles
    "bwC++"
    "colorC++"))
 :latex)

