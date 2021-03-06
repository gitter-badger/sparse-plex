Combinatorics
============================

.. highlight:: matlab



Steiner Systems
---------------------------


Steiner system with block size 2::

    v = 10;
    m = SPX_SteinerSystem.ss_2(v);


Steiner system with block size 3  (STS Steiner Triple System)::

    m = SPX_SteinerSystem.ss_3(v);


Bose construction for STS system for v = 6n + 3 ::

    m = SPX_SteinerSystem.ss_3_bose(v);


Verify if a given incidence matrix is a Steiner system::

    SPX_SteinerSystem.is_ss(M, k)

Latin square construction::


    SPX_SteinerSystem.commutative_idempotent_latin_square(n)


Verify if a table is a Latin square::

    SPX_SteinerSystem.is_latin_square(table)





