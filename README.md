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

Conclusions:
- Pointers (without the contiguous attribute) prevent profitable vectorization
- Allocatable arrays or pointers declared as contiguous allow profitable vectorization
- Associates prevent profitable vectorization for any dynamically-sized arrays (I don't understand why this behavior differs for dynamically-sized arrays compared with statically-sized arrays)

Note: moving data_mod into the same file as the main program (vectorize_test.F90) didn't change the above results. (For this test, I deleted the doit module.)

## Results with nvfortran
Using 25.9-0 on derecho

See `nvfortran_out` for details.

Summary of results:
- Main program
  - Without associates
    - Pointer: Loop not vectorized: data dependency
    - Pointer contiguous: Loop not vectorized: data dependency
    - Allocatable: Loop not vectorized: data dependency
    - Static: Loop not vectorized: data dependency
  - With associates
    - Pointer: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Pointer contiguous: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Allocatable: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Static: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
- Subroutine, separate module (doit)
  - Without associates
    - Pointer: Loop not vectorized: data dependency
    - Pointer contiguous: Loop not vectorized: data dependency
    - Allocatable: Loop not vectorized: unprofitable for target
    - Static: Generated vector simd code for the loop
  - With associates
    - Pointer: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Pointer contiguous: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Allocatable: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
    - Static: Generated vector simd code for the loop (also, Loop versioned for possible aliasing)
- Subroutine, local to the main program (doit_local): Same results as for Subroutine, separate module (doit)

I'm confused about the result for allocatables, because in a different test, I was seeing allocatables being vectorized in some cases (using a pattern similar to the doit_local pattern here). So I'm unclear why now this is giving "unprofitable for target". That other test used different code, but seemed fundamentally similar, so I'm not sure what's causing the difference.

Conclusions:
- Results are sensitive to whether the code is in a subroutine (one hypothesis is that, in the subroutine, the compiler has better access to the type definition, since the instance is an argument declared to be the given type, and this can better inform the optimization).
- Pointers (with or without the contiguous attribute) prevent vectorization
- Allocatable arrays seem to allow vectorization in principle, but in this example it was deemed unprofitable for some reason
- Wrapping the code in an associate block allows vectorization (this feels wrong to me)

Note: moving data_mod into the same file as the main program (vectorize_test.F90) didn't change the above results. (For this test, I deleted the doit module.)
