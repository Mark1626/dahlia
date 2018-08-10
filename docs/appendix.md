-----
title: Appendix
-----

3-D array examples to visualize multi-dimensional access
--------------------------------------------------------

##### Example 1 
Consider a three-dimensional array $\text{a}$ defined like this:

$$a:t[2][5][3] \text{ bank} (5)$$

The flattened version, $\text{a}_f$, would have size $N=30$. Say we make an access $\text{a}[1][4][2]$. Using our formula we defined, we'd access $\text{a}_f$ with $i_f=29$.

Note that the banking factor is not used in this example.

##### Example 2a 
Let's consider an access to the array we considered earlier.
$$a:t[2][5][3] \text{ bank} (5)$$

Since the size of dimension 2 fits nicely with the banking factor, let's say we bank in terms of dimension 2. i.e., we put each set of elements in dim 2 in a different bank.

Let's try accessing the same element as we tried before, $a[1][4][2]$. In index type indexing, knowing banks represent dim 2, we can translate this to $a[\langle 0,1 \rangle][\langle 4,0 \rangle][\langle 0,2 \rangle]$.

Using the equation we derived,

$$
(0 + 1 \times 1) \times 15 + (4 + 5 \times 0) \times 3 + (0 + 1 \times 2) \times 1 = 29
$$

##### Example 2b 
Let's try to access the same array as before with the dynamic index set $d=\{1,0,2\}$

From the equation,

$$
\{ (s_0 + 1 \times 1) \times 15 + (s_1 + 5 \times 0) \times 3 + (s_2 + 1 \times 2) \times 1 ~|~ s_0 \in 0..1, s_1 \in 0..5, s_2 \in 0..1 \} = \{17,20,23,26,29\}
$$

##### Example 2c 
Consider this program:

    int a[2][5][3] bank(5)

    for x in 0..2 unroll 1
        for y in 0..5 unroll 5
            for z in 0..3 unroll 1
                access[x][y][z]

The types of $x$, $y$ and $z$ would then be:

 - $x : \text{idx}\langle 0 .. 1, 0 .. 2 \rangle$
 - $y : \text{idx}\langle 0 .. 5, 0 .. 1 \rangle$
 - $z : \text{idx}\langle 0 .. 1, 0 .. 3 \rangle$

Finally we compute the elements of $I_f$. We do this by computing the following, for all $s_0 \in 0 .. 1$, $s_1 \in 0 .. 5$, $s_2 \in 0 .. 1$, $d_0 \in 0 .. 2$, $d_1 \in 0 .. 1$, $d_2 \in 0 .. 3$:

$$
(s_0 + |0..k_0|*d_0)*\sigma_1*\sigma_2 + (s_1 + |0..k_1|*d_1)*\sigma_2 + (s_2 + |0..k_2|*d_2)*1
$$

Array banking strategies with 3-D example
-----------------------------------------

We are interested in the indices being used to access $\text{a}_f$, so we can restrict the banks that a Seashell programmer can access. However, which banks the programmer accesses is influenced by the array banking strategy. Here are a few ways we could bank $\text{a}_f$.

#### Bank Interleaving 
We could interleave the elements of $\text{a}_f$ among its banks, like this (each rectangle represents a bank):

| 0 5 10 15 20 25 | 1 6 11 16 21 26 | 2 7 12 17 22 27 | 3 8 13 18 23 28 | 4 9 14 19 24 29 |
| --- | --- | --- | --- | --- |

Then, given an index $i_f$ into $\text{a}_f$, we could determine the bank being accessed with $i \bmod b$. The index offset into the bank would be $i / b$.

#### Bank Chunking 
We could simply divide $a_f$ into banks, like this:

| 0 1 2 3 4 5 | 6 7 8 9 10 11 | 12 13 14 15 16 17 | 18 19 20 21 22 23 | 24 25 26 27 28 29 |
| --- | --- | --- | --- | --- |

Then, we could use $i / b$ to find the relevant bank, and $i \bmod b$ to find the index within the bank.

Both have use cases, but we won't go into those here.

##### Example 3  
Consider the array $a$ defined in example 1. Assume interleaving. If we index into $a_f$ with $i_f=29$, the bank accessed would be $29 \bmod 5 = 4$, and the index into this bank would be $29 / 5 = 5$. In other words, we would access the 5th element in the 4th bank.

2-D array examples to visualize multi-dimensional access
--------------------------------------------------------


##### Example 1 
Consider a two-dimensional array $\text{a}$ defined like this:

$$a:t[4][2] \text{ bank} (4)$$

The flattened version, $\text{a}_f$, would have size $N=8$. Say we make an access $\text{a}[3][1]$. Using our formula we defined, we'd access $\text{a}_f$ with $i_f=7$.

Note that the banking factor is not used.  

##### Example 2.1
Consider this program:

    int a[4][2] bank(4)

    for x in 0..4 unroll 2
        for y in 0..2 unroll 2
            access[x][y]

The types of $x$ and $y$ would then be:

 - $x : \text{idx}\langle 0 .. 2, 0 .. 2 \rangle$
 - $y : \text{idx}\langle 0 .. 2, 0 .. 1 \rangle$


Finally we compute the elements of $I_f$. We do this by computing the following, for all $s_0 \in 0 .. 2$, $s_1 \in 0 .. 2$, $d_0 \in 0 .. 2$, $d_1 \in 0 .. 1$:

$$
(s_0 + |0..k_0|*d_0)*\sigma_1*\sigma_2 + (s_1 + |0..k_1|*d_1)*\sigma_2
$$

Here are the computed elements:

  - $(0+2*0)*2*1 + (0+2*0)*1=0$
  - $(0+2*0)*2*1 + (1+2*0)*1=1$
  - $(1+2*0)*2*1 + (0+2*0)*1=2$
  - $(1+2*0)*2*1 + (1+2*0)*1=3$
  - $(0+2*1)*2*1 + (0+2*0)*1=4$
  - $(0+2*1)*2*1 + (1+2*0)*1=5$
  - $(1+2*1)*2*1 + (0+2*0)*1=6$
  - $(1+2*1)*2*1 + (1+2*0)*1=7$


##### Example 2.2
Consider this program:

    int a[4][2] bank(4)

    for i in 0..4 unroll 4
        for j in 0..2 unroll 1
            access a[i][j]

The types of $i$ and $j$ would then be:

 - $i : \text{idx}\langle 0 .. 4, 0 .. 1 \rangle$
 - $j : \text{idx}\langle 0 .. 1, 0 .. 2 \rangle$


With these index type indices we can compute the elements of $I_f$. We do this by computing the following, $\forall$ $d_0 \in 0 .. 1$, $d_1 \in 0 .. 2$:

$$
\{(s_0 + |0..4|*d_0)*\sigma_1 + (s_1 + |0..1|*d_1)*1 ~|~ \forall s_0 \in 0 .. 4, s_1 \in 0 .. 1 \}
$$

where $$ \sigma_1 = 2 $$

For a pair of $\langle d_0,d_1 \rangle = \langle 0,1 \rangle$:

  - $(0+4*0)*2 + (0+1*1)=1$
  - $(1+4*0)*2 + (0+1*1)=3$
  - $(2+4*0)*2 + (0+1*1)=5$
  - $(3+4*0)*2 + (0+1*1)=7$


Array Banking Strategies with 2-D example
-----------------------------------------

We are interested in the computing the indices being used to access flattened arrays,, so we can restrict the banks that a Seashell programmer can access. However, which banks the programmer accesses is influenced by the array banking strategy. This section will outine a couple of banking strategies. We'll show what it looks like to bank $\text{a}_f$, based on array $\text{a}$ from the example in the previous section.

#### Bank Interleaving/Cyclic Banking.
We could interleave the elements of $\text{a}_f$ among its banks, like this (each rectangle represents a bank):

| 0 4 | 1 5 | 2 6 | 3 7 |
| --- | --- | --- | --- |

Then, given an index $i_f$ into $\text{a}_f$, we could determine the bank being accessed with $i_f \bmod b$. The index offset into the bank would be $i_f / b$.

#### Bank Chunking/Block Banking
We could simply divide $a_f$ into banks, like this:

| 0 1 | 2 3 | 4 5 | 6 7 |
| --- | --- | --- | --- |

Then, we could use $i_f / b$ to find the relevant bank, and $i_f \bmod b$ to find the index within the bank.

Both have use cases, but we won't go into those here. For the remainder of this document we'll assume we're using bank interleaving, but we could have similar results with chunking.

Modulus proof
-------------

$$ab \bmod ac = ab - \lfloor \frac{ab}{ac} \rfloor ac   
            = a (b - \lfloor \frac{b}{c} \rfloor c )  
            = a (b \bmod c)  $$ 

