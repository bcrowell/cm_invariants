cm_invariants
=============

Ben Crowell, Fullerton College

An implementation of the Carminati-McLenaghan invariants in Maxima,
using ctensor. The original paper (paywalled) describing the CM
invariants was Carminati and McLenaghan, J. Math. Phys. 32 (1991)
3135.  There is a brief article on Wikipedia that describes them,
https://en.wikipedia.org/wiki/Carminati%E2%80%93McLenaghan_invariants
.  The notation used here is the same as the notation in the Wikipedia
article. 

Installing
==========

The package is contained in the file cm_invariants.mac, which can be
installed wherever you like. If you wish, you can test your installation
by running the test suite, as described below.

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

After you call cm_invariants(), the invariants are all calculated and
stored in the array cm_invariant, stored in the order R, R1, R2, R3,
M3, M4, W1, W2, M1, M2, M5.  The names ("R", "R1", ...) are stored in
the array cm_invariant_name.  The array cm_nonvanishing_invariants
contains a list of the array indices of the invariants that are
nonzero, e.g., [7,8] in the case of the Schwarzschild metric to show
that W1 and W2 are nonzero. 

Calculating only some of the invariants
======================================= 

The full set of invariants includes polynomials of up to fifth order
in the Riemann tensor.  In moderately complicated cases, the
expressions for the components of the Riemann tensor itself can easily
have hundreds or thousands of terms. If the Riemann tensor has, for
example, 10^3 terms, then brute-force computation of a fifth-order
polynomial in the Riemann tensor will involve something like 10^15
terms, which is obviously infeasible.  For this reason, it may be
advantageous to compute only some of the invariants, or compute them
one at a time in order to see how long it takes. This can be done as
in the following example:

    load(ctensor)$
    ct_coordsys(kerr_newman,all)$
    load("cm_invariants.mac")$
    showtime:true$
    cm_init()$
    cm_r();
    cm_r1();

(This example works in Maxima 5.37 but not in Maxima 5.32.) The
calculation above takes about 20 minutes on my machine to determine
that R=0 for the Kerr-Newman spacetime, and also that (after a little
more simplification) R1=[e/(a^2 cos^2 theta+r^2)]^4.

Starting over with a new metric
===============================

If you've calculated the invariants for one metric and then want to
calculate them for some other metric within the same script, then you
need to tell ctensor to forget the first metric. To do this, call the
function init_ctensor(), then set up your new metric, and call
cm_invariants() again. 

Options
=======
By default we have

    cm_trig_simp:true; /* apply trigonometric substitutions? */
    cm_rat_simp:true;  /* rationally simplify results? */

To disable these simplifications, set these variables to false after
calling cm_invariants(). 

Public functions
================

The following functions and variables are the public interface of the
package. 

## cm_trig_simp

Global boolean variable, true by default. If true, then trigonometric
substitutions are applied to all results. To turn off this
simplification, set this variable to false after loading the package. 

## cm_rat_simp

Same as cm_trig_simp but for rational simplifications.

## cm_invariants()

Function that computes various tensors from the metric, and then
computes all the CM invariants. 

## cm_init()

Initializes tensors used in computing the CM invariants. This is
called automatically by cm_invariants(), so it only needs to be used
when calculating some rather than all of the invariants, as in the
example above using the Kerr-Newman metric. 

## cm_r(),cm_r1(),cm_r2(),cm_r3(),cm_m3(),cm_m4(),cm_w1(),cm_w2(),cm_m1(),cm_m2(),cm_m5()

Functions that calculate the individual CM invariants. The names
follow the notation defined in the Wikipedia article. 

## cm_s, cm_us, cm_uus

Global arrays holding the trace-free Ricci tensor,
cm_s[i,j]=S_ij=R_ij-(1/4)Rg_ij, as well as its fully contravariant and
mixed versions cm_uus[i,j]=S^ij and cm_us[i,j]=S^i_j. 

## cm_parity(p)

A function that returns -1, 0, or +1, depending on whether p is an
even or odd permutation away from being sorted.  The input p is an
array of integers. This routine is meant to be used for small arrays,
and will not have good performance on large arrays. 

## cm_eps

Global array containing the tensorial Levi-Civita tensor, i.e., the
parity of its four indices, multiplied by the square root of minus the
determinant of the metric. 

## cm_c, cm_c_mixed, cm_c_upper

Global arrays containing the Weyl tensor in the forms C_ijkl, C_ij^kl,
and C^ijkl.  The array cm_c is simply a copy of ctensor's weyl[] with
the indices reshuffled to conform to the literature, i.e.,
cm_c[l,i,j,k]=weyl[i,j,k,l].

## cm_c_star, cm_c_star_mixed, cm_c_star_upper

Global arrays containing the left Hudge duals of the various forms of
the Weyl tensor, i.e., *C_ijkl, *C_ij^kl, *C^ijkl. 

## cm_calculate_all_invariants()

Function that calculates all the invariants and stores the results in
the array cm_invariant. 

## cm_invariant

Global array containing
[cm_r(),cm_r1(),cm_r2(),cm_r3(),cm_m3(),cm_m4(),cm_w1(),cm_w2(),cm_m1(),cm_m2(),cm_m5()]. 

## cm_invariant_name

Global array containing
["R","R1","R2","R3","M3","M4","W1","W2","M1","M2","M5"]. The names
follow the notation defined in the Wikipedia article.

## cm_nonvanishing_invariants()

Function that returns a list of array indices in cm_invariant_name for
which the CM invariant vanishes. 

## cm_print_invariants()

Prints out all the nonvanishing CM invariants, or a message saying
that all of them vanish. 

Tests
=====

The code is distributed along with a test suite in the subdirectory
named tests. To test your installation, do "make test", which will run
the maxima programs located in that directory, one after another. The
following is a brief description of what these tests are. They are
somewhat automated, so that many possible bugs will result in an error
message. However, some of the output does need to be inspected by a
human.

The program parity.mac tests that the cm_parity() function works
correctly in a few cases.

The rest of the test programs set up the metric for some spacetime,
calculate its CM invariants, print them out, and, in some cases, check
that they seem to be correct. Several of these tests (flat.mac,
plane_wave.mac, and vsi.mac) are spacetimes for which it is known on
theoretical grounds that we should get zero for all curvature
invariants that are continuous functions of the Riemann tensor and its
derivatives (not just the CM invariants). If any of these fail to be
zero, an error is generated.

The programs sch.mac, closed.mac, and de_sitter.mac do the
calculations for the Schwarzschild spactime; a closed,
radiation-dominated FLRW cosmology; and an FLRW cosmology containing
only a repulsive cosmological constant (de Sitter space). For the
Schwarzschild and closed spacetimes, we expect some curvature
singularities where certain CM invariants blow up; the test programs
check for this and throw an error if this is not the case.  In the
case of de Sitter space, the output is a constant, which makes sense
because of the space's time-translation symmetry. 

The program end.mac calculates the invariants for a somewhat
pathological spacetime adapted from an example by Geroch, in which
timelike geodesics are incomplete as time approaches infinity. All of
the CM invariants remain finite, however. Since this spacetime is
conformally flat, the only CM invariants that can be nonzero are the
R's, and the test script checks whether this is true. 

All of the test programs call the function cm_do_tests(). This
function checks that the traceless Ricci tensor is indeed traceless,
checks the symmetries of the Weyl tensor and its Hodge dual, and
checks the tracelessness of the Weyl tensor and its Hodge dual. 

To do
=====

Find some known-good expressions for the CM invariants in some
spacetimes, either published in the literature or calculated using the
GRTensorII package, and check the results against those in some cases
where the results are finite. 

Make use of symmetries to improve efficiency.

The package uses local variables with the names i, j, k, and l.  If
the metric depends on parameters with the same names, the results of
the calculations will be incorrect. This should be fixed by completing
the process of renaming all the local loop indices to %ii, %jj, etc.
