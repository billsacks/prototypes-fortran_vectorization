ifneq ($(MAKECMDGOALS),clean)
ifeq ($(FC),nvfortran)
   FFLAGS := -O3 -g -Minfo -Mneginfo
else ifeq ($(FC),ifx)
   FFLAGS := -O2 -qopt-report=3 -vec-threshold0
else ifeq ($(FC),gfortran)
   FFLAGS := -O3 -g -fopt-info-all
else
   $(error FC must be set to nvfortran, ifx, or gfortran (got '$(FC)'))
endif
endif

OBJ := vectorize_test.F90

tester: $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

%.o: %.F90
	$(FC) $(FFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f tester *.o *.mod
