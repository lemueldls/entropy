#let note(body) = text(fill: blue, body)
#let ans(body) = text(fill: red, body)

= Entropy

#note[Information is a stream of symbols, and $mu$ is the probability distribution on the information set.]

Set of outcomes: $X = {x_1, ..., x_n}$ (or $NN$).
$p_i = P(X = x_i)$, $p_i > 0$, $sum p_i = 1$, $mu = (p_1, ..., p_n)$.

$ H(mu) = - sum_(i=1)^n p_i log p_i $

#note[The information gained by observing outcome $i$ is $-log(mu(i))$, provided $mu(i) > 0$.]

Uncertainty in transmitting the symbol $x_i$ is $-log p_i$.
Average amount of information (uncertainty) per symbol.

- $p_i = 1$ (no randomness) $=> H(mu) = 0$ (convention $0 dot log 0 = 0$).
- $p_i = 1/n quad forall i$ (most random) $=> H(mu) = log n$ (maximal) (p. 156).

Information of event $E$: $-log mu(E) = I(E)$.

For independent events (i.e., $mu(E inter F) = mu(E) mu(F)$):
$ I(E inter F) = I(E) + I(F) $

Let $zeta_m = X^m = X times X times dots times X$ ($m$ times, $n$ blocks).

#note[For words of length $m$, $zeta_m$ is the set of all $m$-blocks $ { (a_1, a_2, ..., a_m) | a_i in {1, ..., n} } $]

#note[A word $w in zeta_m$ determines a cylinder set $[w]$, the set of sequences whose first $m$ symbols agree with $w$.]

Note $zeta_m$ provides a partition of elements $X$ with $|zeta_m| = n^m$.

$ H_m = - sum_(C in zeta_m) mu(C) log mu(C) $

#note[Equivalently, $H_m$ is the entropy of the partition into $m$-blocks.]

Average information per symbol when n-block is transmitted $approx 1/n H_n$.
$h = lim_(n -> oo) 1/n H_n$ (entropy of source).

- *Example:* $X = {0, 1}$, $p_0 = 2/3$. What are $H_1$, $H_2$, $H_3$? (Explain why $H_3 > H_2 > H_1$). (How much work is it to find a formula for $H_n$? If possible, find it).

#ans[
  $
    H_1 & = -2/3 log(2/3) - 1/3 log(1/3) approx 0.918 \
    H_2 & = 2 dot H_1 = -4/9 log(4/9) - 2/9 log(2/9) - 1/9 log(1/9) - 1/27 log(1/27) approx 1.836 \
    H_3 & = 3 dot H_1 approx 2.754
  $

  For independent and identically distributed processes, entropy is additive.
  The formula for $H_n$ is $ H_n = n dot H_1 $
]

- *Exercise 6.1.2*
  - (a) Let $alpha = {A_1, ..., A_m}$ and $beta = {B_1, ..., B_l}$ be partitions of $X$. Show $alpha or beta = {A inter B mid(|) A in alpha "and" B in beta}$ is also a partition.

    #ans[
      $alpha or beta$ is a partition because:
      - $A inter B$ is nonempty for some $A in alpha$ and $B in beta$ (since $alpha$ and $beta$ are partitions).
      - The sets $A inter B$ are disjoint (since $alpha$ and $beta$ are partitions).
      - The union of the sets $A inter B$ covers $X$ (since $alpha$ and $beta$ are partitions).
    ]

  - (b) (Optional, may be more difficult). Let $T: X -> X$ and assume $mu compose T^(-1) = mu$. Show $T^(-1) alpha = {T^(-1)(A) mid(|) A in alpha}$ is also a partition.

- *Exercise 6.1.4* b, c, d ((a) optional).

(Compared to the video on entropy, the moral of the story is that smaller "macrostates" (i.e., partition elements) have higher entropy).

== Conditional Entropy

#note[Conditional entropy measures the remaining uncertainty after the partition $beta$ is known.]

$alpha, beta$ partitions of $X$.

$ H(alpha | beta) = - sum_(A in alpha) sum_(B in beta) mu(A inter B) log (mu(A inter B) / mu(B)) $

If independent:
$
  H(alpha | beta) & = - sum_(A in alpha) sum_(B in beta) mu(A) mu(B) [log mu(A)] \
                  & = - sum_(A in alpha) [mu(A) log mu(A)] \
                  & = H(alpha)
$

#note[If $alpha <= beta$, then knowing $beta$ determines $alpha$, so $H(alpha | beta) = 0$ and $H(beta | alpha) <= H(beta)$.]

#note[Exercise 6.1.15 is the place to check these identities carefully, especially part (e).]

*Example:* Consider previous example (1) with $alpha = zeta_2 = {00, 01, 10, 11}$.
$beta = {B_1, B_2, B_3}$ gives the number of 1s = ${11}$, ${01, 10}$, ${00}$ (i.e., 2, 1, or 0 ones).
Are $alpha$ and $beta$ independent?
You already calculated $H(alpha)$. What are $H(beta)$, $H(alpha | beta)$, $H(beta | alpha)$? Interpret these results.

- *Exercise 6.1.15.* Especially part (e).
