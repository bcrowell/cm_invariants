cm_invariants
=============

Ben Crowell, Fullerton College

An implementation of the Carminati-McLenaghan invariants in
Maxima, using ctensor.

Installing
==========

The package is contained in the file cm_invariants.mac, which
can be installed wherever you like. The code is distributed along
with a test suite in the subdirectory named tests. To test your
installation, do "make test".

Basic use
=========
The following example shows the use of the package to compute the CM
invariants of the Schwarzschild spacetime.

    load(ctensor);
    ct_coords:[t,r,theta,phi];
    lg:matrix([(1-2*m/r),0,0,0],
              [0,-1/(1-2*m/r),0,0],
              [0,0,-r^2,0],
              [0,0,0,-r^2*sin(theta)^2])$
    load("cm_invariants.mac");
    cm_invariants(); /* Calculate all the invariants. */
    cm_print_invariants(); /* Print out the ones that are nonzero. */

The output is as follows:

    Nonvanishing CM invariants: 
               2  - 6
       W1 = 6 m  r    
                 3  - 9
       W2 = - 6 m  r    

Options
=======
By default we have

    cm_trig_simp:true; /* apply trigonometric substitutions? */
    cm_rat_simp:true;  /* rationally simplify results? */

To disable these simplifications, set these variables to false after calling cm_invariants().

Starting over with a new metric
===============================
If you've calculated the invariants for one metric and then want to calculate them
for some other metric within the same script, then you need to tell ctensor to forget
the first metric. To do this, call the function init_ctensor(), then set up your
new metric, and call cm_invariants() again.

To do
=====
Find some known-good expressions for the CM invariants in some spacetimes,
either published in the literature or
calculated using the GRTensorII package, and check the results against those in some cases
where the results are finite.

Make use of symmetries to improve efficiency.

The package uses local variables with the names a, b, c, d, e, f, i, j, k, and l.
If the metric depends on parameters with the same names, the results of the calculations
will be incorrect. This should be fixed by completing the process of renaming all the local
loop indices to %aa, %bb, etc.
