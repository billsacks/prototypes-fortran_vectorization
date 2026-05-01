## Overview

This prototype tests vectorization of simple loops with various Fortran array types.

Compile with one of these:
- `make FC=nvfortran`
- `make FC=ifx`
- `make FC=gfortran`

## Results with ifx
Using 2025.2.1 on derecho

See vectorize_test.optrpt for details.

Summary of results:
- Main program
  - Without associates
    - Pointer: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Pointer contiguous: Vectorization profitable (estimated potential speedup: 3.312500)
    - Allocatable: Vectorization profitable (estimated potential speedup: 3.312500)
    - Static: Vectorization profitable (estimated potential speedup: 3.281250)
  - With associates
    - Pointer: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Pointer contiguous: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Allocatable: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Static: Vectorization profitable (estimated potential speedup: 3.281250)
- Subroutine: Basically the same results, though some small differences in estimated speedups

## Results with nvfortran

