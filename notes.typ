Information is a stream of symbols.

$mu$ is defined as the probability distribution

We define "information" as $i in {1,...,n}$ where $ mu(i) = "prob of" i $

Information of observing $i$ is $-log(mu(i) > 0)$

We define the average information per symbol
$ H(mu) = - sum^n_(i=1) mu(i) log mu(i) $

==== Events

We define a partition of the information set as

$
  cal(C)_m & = {1,...,n}^m \
           & = { (a_1,a_2,...,a_m) | a_i in {1,...,n} }
$

Let $w in cal(C)_m$ be the "words" of length $m$ $ [w] & = underbrace([a_1 a_2 ... a_m], "cylinder sets") \
    & = { x in X | x_0 = a_1, space x_1, = a_2, space ..., space x_(n-1) = a_n } $

We define the entropy of partition $cal(C)_m$

$ H_m = - sum_(w in cal(C)_m) mu([w])log mu([w]) $

Start with:
$ x = {0,1}^NN quad mu(0) = 2/3 quad mu(1) = 1/3 $
And find: $ H(mu) = ? $

---


Conditional entropy: $ H(alpha|beta) = - sum_(B in beta) sum_(A in alpha) mu(A inter B) log((mu(A inter B))/(mu(B))) $

Exercise 6.1.15
// Prove that if $alpha<=beta$ then $H(alpha|beta)=0$ and $H(beta|alpha) <= H(beta)$
