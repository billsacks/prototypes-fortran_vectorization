## Overview

This prototype tests vectorization of simple loops with various Fortran array types.

Compile with one of these:
- `make FC=nvfortran 2>nvfortran_out`
- `make FC=ifx`
- `make FC=gfortran`

(On derecho, with appropriate modules loaded, FC will be set automatically, so can just compile with `make`.)

## Results with ifx
Using 2025.2.1 on derecho

See `vectorize_test.optrpt` and `doit_mod.optrpt` for details.

Summary of results:
- Main program
  - Without associates
    - Pointer: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Pointer contiguous: Vectorization profitable (estimated potential speedup: 2.593750)
    - Allocatable: Vectorization profitable (estimated potential speedup: 2.593750)
    - Static: Vectorization profitable (estimated potential speedup: 2.500000)
  - With associates
    - Pointer: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Pointer contiguous: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Allocatable: Vectorization not profitable (estimated potential speedup: 0.359375)
    - Static: Vectorization profitable (estimated potential speedup: 2.500000)
- Subroutine, separate module (doit): Basically the same results, though some small differences in estimated speedups
- Subroutine, local to the main program (doit_local): Basically the same results, though some small differences in estimated speedups

## Results with nvfortran
Using 25.9-0 on derecho

See `nvfortran_out` for details.

Summary of results:
- Main program
  - Without associates
    - Pointer: Loop not vectorized: data dependency
    - Pointer contiguous: Loop not vectorized: data dependency
    - Allocatable: Loop not vectorized: data dependency
    - Static: Loop not vectorized: data dependency (however, loop was unrolled 8 times)
  - With associates
    - Pointer: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Pointer contiguous: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Allocatable: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Static: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
- Subroutine
  - Without associates
    - Pointer: Loop not vectorized: data dependency
    - Pointer contiguous: Loop not vectorized: data dependency
    -
