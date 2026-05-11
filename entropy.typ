#let note(body) = text(fill: blue, body)
#let ans(body) = text(fill: red, body)

= Entropy

The concept of entropy is important in many fields of science, including to
digital technology. Began in thermodynamics, but now extends to "information" which in turn is important to Data Science (Shannon Entropy)

We've seen what a partition is in this class. One entry point into the concept of entropy is the concept of entropy of a partition, aluded to in the video above as a "macrostate".

== Notes

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
      // $alpha or beta$ is a partition because:
      - $A inter B$ is nonempty for some $A in alpha$ and $B in beta$ (since $alpha$ and $beta$ are partitions).
      - The sets $A inter B$ are disjoint (since $alpha$ and $beta$ are partitions).
      - The union of the sets $A inter B$ covers $X$ (since $alpha$ and $beta$ are partitions).
      - Therefore, $alpha or beta$ is a partition of $X$.
    ]

  - (b) (Optional, may be more difficult). Let $T: X -> X$ and assume $mu compose T^(-1) = mu$. Show $T^(-1) alpha = {T^(-1)(A) mid(|) A in alpha}$ is also a partition.

- *Exercise 6.1.4* (b), (c), (d) ((a) optional).

  Let $alpha$ and $beta$ be partitions of ($X$, $cal(F)$, $mu$, $T$), where $T$ is a measure preserving transformation.

  #set enum(numbering: "(a)")
  + Show that $H(T^(-1) alpha) = H(alpha)$.
  + Show that if $alpha <= beta$, then $H(alpha) <= H(beta)$.
  + Show that $H(alpha or beta) <= H(alpha) + H(beta)$.
  + We call two partitions $alpha$ and $beta$ _independent_ if $ mu(A inter B) = mu(A) mu(B) quad "for all" quad A in alpha, space B in beta $ Show that if $alpha$ and $beta$ are independent partitions, $ H(alpha or beta) = H(alpha) + H(beta) $

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

  Let $a$, $beta$ and $gamma$ be partitions of $X$.

  #set enum(numbering: "(a)")
  + Show that $H(alpha or beta | gamma) = H(alpha | gamma) + H(beta | alpha or gamma)$.
  + Show that, if $beta <= alpha$, then $H(gamma | alpha) <= H(gamma | beta)$.
  + Show that $H(alpha or beta) = H(alpha) + H(beta | alpha)$.
  + Show that, if $beta < alpha$, then $H(beta | alpha) = 0$.
  + Explain in words why each result (a)-(d) is reasonable.

=== Project

#set enum(numbering: "1.")
+ Video presentation, about 20-30 minutes (submit as a group)
+ A problem/exercise for the rest of the class to try to solve (see #5 below). Mention this problem at the end of your presentation without a solution, and submit your solution as a PDF on brightspace. One place to look for such problems is in the resource related to your project. (submitted as a group)
+ Write a summary for some other team's project. Follow the guidelines/prompt questions on brightspace (submit individually, this is not a group assignment).
+ Repeat the step above for another team's project.
+ Submit a solution to one of the two problems (see step 2) corresponding to projects you wrote a summary about (also submit individually, this is not a group assignment)
