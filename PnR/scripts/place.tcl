# Place standard cells automatically with optimizations to meet all constraints of all corners
placeDesign -inPlaceOpt -prePlaceOpt

# Place Tie-Low & Tie-High cells
addTieHiLo -cell TIELOM -prefix LTIE
addTieHiLo -cell TIEHIM -prefix HTIE