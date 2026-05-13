#let note(body) = text(fill: blue, body)
#let ans(body) = text(fill: red, body)

#show math.equation.where(block: false): set math.frac(style: "skewed")

= Entropy

The concept of entropy is important in many fields of science, including to
digital technology. Began in thermodynamics, but now extends to "information" which in turn is important to Data Science (Shannon Entropy)

We've seen what a partition is in this class. One entry point into the concept of entropy is the concept of entropy of a partition, aluded to in the video above as a "macrostate".

== Notes

#note[Information is a stream of symbols, and $mu$ is the probability distribution on the information set.]

Set of outcomes: $X = {x_1, ..., x_n}$ (or $NN$).
$p_i = P(X = x_i)$, $p_i > 0$, $sum p_i = 1$, $mu = (p_1, ..., p_n)$.

$ H(mu) = - sum_(i=1)^n p_i log p_i $

#note[Unless otherwise stated, take $log$ to be base 2, so entropy is measured in bits.]

#note[The information gained by observing outcome $i$ is $-log(mu(i))$, provided $mu(i) > 0$.]

Uncertainty in transmitting the symbol $x_i$ is $-log p_i$.
Average amount of information (uncertainty) per symbol.

- $p_i = 1$ (no randomness) $=> H(mu) = 0$ (convention $0 dot log 0 = 0$).
- $p_i = 1/n quad forall i$ (most random) $=> H(mu) = log n$ (maximal) (p. 156).

Information of event $E$: $-log mu(E) = I(E)$.

For independent events (i.e., $mu(E inter F) = mu(E) mu(F)$):
$ I(E inter F) = I(E) + I(F) $

Let $zeta_m = X^m = X times X times dots times X$ ($m$ times, $n$ blocks).

#note[For words of length $m$, $zeta_m$ is the set of all $m$-letter words over the alphabet $X$: $ { (a_1, a_2, ..., a_m) | a_i in X } $.]

#note[A word $w in zeta_m$ determines a cylinder set $[w]$, the set of sequences whose first $m$ symbols agree with $w$. These cylinder sets form a partition of the sequence space.]

Note $zeta_m$ indexes a partition of the sequence space into $|zeta_m| = n^m$ cylinder sets.

$ H_m = - sum_(w in zeta_m) mu([w]) log mu([w]) $

#note[Equivalently, $H_m$ is the entropy of the partition into $m$-letter cylinder sets.]

Average information per symbol in an $m$-letter block is $H_m / m$.
$h = lim_(m -> oo) H_m / m$ (entropy rate of the source).

- *Example:* $X = {0, 1}$, $p_0 = 2/3$. Let $S_m = X_1 + dots + X_m$ be the number of 1s among the first $m$ symbols. What are $H(S_1)$, $H(S_2)$, $H(S_3)$? (Explain why $H(S_3) > H(S_2) > H(S_1)$). (How much work is it to find a formula for $H(S_m)$? If possible, find it). This is the entropy of the count distribution, not the block entropy $H_m$ above.

#ans[
  #let h1 = -(2 / 3) * calc.log(2 / 3, base: 2) - (1 / 3) * calc.log(1 / 3, base: 2);
  #let h2 = (
    -(1 / 9) * calc.log(1 / 9, base: 2) - (4 / 9) * calc.log(4 / 9, base: 2) - (4 / 9) * calc.log(4 / 9, base: 2)
  );

  - $H(S_1)$ (entropy of the count after one draw)

    The distribution is ${2/3,1/3}$
    $ H(S_1) = -(2/3 log(2/3) + 1/3 log(1/3)) approx 0.918 "bits" $

  - $H(S_2)$ (entropy of the count after two draws)

    The possible sums are ${0, 1, 2}$, i.e. the number of 1s in two Bernoulli trials, with probabilities ${(2/3)^2,2(2/3)(1/3),(1/3)^2} = {1/9, 4/9, 4/9}$.
    $ H(S_2) = -(1/9 log(1/9) + 4/9 log(4/9) + 4/9 log(4/9)) approx 1.392 "bits" $

  - $H(S_3)$ (entropy of the count after three draws)

    The sum follows a binomial distribution $B(3,1/3)$ with probabilities ${8/27,12/27,6/27,1/27}$
    $ H(S_3) = -(8/27 log(8/27) + 12/27 log(12/27) + 6/27 log(6/27) + 1/27 log(1/27)) approx 1.698 "bits" $
]

- *Exercise 6.1.2.*
  - (a) Let $alpha = {A_1, ..., A_m}$ and $beta = {B_1, ..., B_l}$ be partitions of $X$. Show $alpha or beta = {A inter B mid(|) A in alpha "and" B in beta}$ is also a partition.

    #ans[
      $alpha or beta$ is a partition because:
      - $A inter B$ is nonempty for some $A in alpha$ and $B in beta$.
      - The sets $A inter B$ are disjoint because if $(A_i inter B_j) inter (A_k inter B_l)$ is non-empty, then $A_i$ must equal $A_k$ and $B_j$ must equal $B_l$ as the original sets were partitions.
      - The union covers $X$ because $union_(i,j) (A_i inter B_j) = (union_i A_i) inter (union_j B_j) = X inter X = X$.
      - Therefore, $alpha or beta$ is a partition of $X$.
    ]

  - (b) (Optional, may be more difficult). Let $T: X -> X$ and assume $mu compose T^(-1) = mu$. Show $T^(-1) alpha = {T^(-1)(A) mid(|) A in alpha}$ is also a partition.

    #ans[
      $T^(-1) alpha$ is a partition because:
      - Since $alpha$ partitions $X$, $union_{A in alpha} A = X$, so $union T^(-1)(A) = T^(-1)(union A) = T^(-1)(X) = X$.
      - For $A, B in alpha$ where $A != B$, $T^(-1)(A) inter T^(-1)(B) = T^(-1)(A inter B) = T^(-1)(emptyset) = emptyset$.
      - Since $mu compose T^(-1) = mu$ and $mu(A) > 0$, $mu(T^(-1)A) > 0$, ensuring the sets are non-empty in the measure-theoretic sense.
    ]

- *Exercise 6.1.3.* Show that if $beta$ is a refinement of $alpha$, then each atom of $alpha$ is a finite (disjoint) union of atoms of $beta$.

- *Exercise 6.1.4.* (b), (c), (d) ((a) optional).

  Let $alpha$ and $beta$ be partitions of ($X$, $cal(F)$, $mu$, $T$), where $T$ is a measure preserving transformation.

  #set enum(numbering: "(a)")
  + Show that $H(T^(-1) alpha) = H(alpha)$.

  #ans[
    $ H(T^(-1) alpha) = - sum_{A in alpha} mu(T^(-1)A) log mu(T^(-1)A) $
    Since $T$ is measure preserving, $mu(T^(-1)A) = mu(A)$.

    Substituting this gives $ H(T^(-1) alpha) = - sum_{A in alpha} mu(A) log mu(A) = H(alpha) $
  ]

  + Show that if $alpha <= beta$, then $H(alpha) <= H(beta)$.

  #ans[
    If $alpha <= beta$, then every $B in beta$ is a subset of exactly one $A in alpha$. Thus $mu(A) = sum_{B subset A} mu(B)$. Since the function $f(x) = -x log x$ is concave, or by observing that refining a partition increases the number of outcomes and spreads probability, the uncertainty $H(beta)$ must be greater than or equal to $H(alpha)$.
  ]

  + Show that $H(alpha or beta) <= H(alpha) + H(beta)$.
  #ans[
    This is subadditivity. $ H(alpha or beta) - H(alpha) - H(beta) = sum_{A, B} mu(A inter B) log((mu(A)mu(B)) / mu(A inter B)) $ Using the inequality $ln(x) <= x - 1$, we can show this sum is $<= 0$, meaning $ H(alpha or beta) <= H(alpha) + H(beta) $
  ]

  + We call two partitions $alpha$ and $beta$ _independent_ if $ mu(A inter B) = mu(A) mu(B) quad "for all" quad A in alpha, space B in beta $  Show that if $alpha$ and $beta$ are independent partitions, $ H(alpha or beta) = H(alpha) + H(beta) $

  #ans[
    $ H(alpha or beta) = - sum_{A, B} mu(A inter B) log mu(A inter B) $. Under independence:
    $
      & -sum_{A, B} mu(A)mu(B) log (mu(A)mu(B)) \
      & = - sum_{A, B} mu(A)mu(B) [log mu(A) + log mu(B)] \
      & = - sum_B mu(B) (sum_A mu(A) log mu(A)) - sum_A mu(A) (sum_B mu(B) log mu(B)) \
      & = 1 dot H(alpha) + 1 dot H(beta) = H(alpha) + H(beta)
    $
  ]

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

#note[*Exercise 6.1.15.* is the place to check these identities carefully, especially part (e).]

*Example:* Consider previous example (1) with $alpha = zeta_2 = {00, 01, 10, 11}$.
$beta = {B_1, B_2, B_3}$ gives the number of 1s = ${11}$, ${01, 10}$, ${00}$ (i.e., 2, 1, or 0 ones).
Are $alpha$ and $beta$ independent?
You already calculated $H(alpha)$. What are $H(beta)$, $H(alpha | beta)$, $H(beta | alpha)$? Interpret these results.

#ans[
  - *Independence:* No. $beta$ is a coarsening of $alpha$ ($beta <= alpha$ in the book's order, meaning $alpha$ refines $beta$). For example, $mu(00 inter B_3) = mu(00) = 4/9$, while $mu(00)mu(B_3) = 4/9 dot 4/9 = 16/81$.
  - *Calculations:*
    $mu(B_1) = 1/9, mu(B_2) = 4/9, mu(B_3) = 4/9$ (where index matches number of ones).
    $H(beta) = -(1/9 log 1/9 + 4/9 log 4/9 + 4/9 log 4/9) approx 1.39$ bits.
    $H(beta | alpha) = 0$ because if you know the exact block (e.g., $01$), you know the number of 1s exactly.
    Since $beta <= alpha$, the chain rule gives $H(alpha) = H(beta) + H(alpha | beta)$, so $H(alpha | beta) = H(alpha) - H(beta) approx 1.836 - 1.39 = 0.446$ bits.
  - *Interpretation:* $H(beta)$ is the uncertainty in the "count". $H(alpha | beta)$ is the remaining uncertainty about the sequence once the count is known (only the $B_2$ group has uncertainty).
]

- *Exercise 6.1.14.* Let $alpha = {A_1,...,A_n}$ and $beta = {B_1,...,B_m}$ be two independent partitions of $X$. Then show that $H(alpha | beta) = H(alpha)$.

// The above quantity $H(alpha | beta)$ is interpreted as the average uncertainty about which element of the partition $alpha$ the point $x$ will enter
// (under $T$) if we already know which element of $beta$ the point $x$ will enter.

- *Exercise 6.1.15.* Especially part (e).

  Let $alpha$, $beta$ and $gamma$ be partitions of $X$.

  #set enum(numbering: "(a)")
  + Show that $H(alpha or beta | gamma) = H(alpha | gamma) + H(beta | alpha or gamma)$.

  #ans[
    By definition: $ H(alpha or beta | gamma) = - sum_{A, B, C} mu(A inter B inter C) log (mu(A inter B inter C) / mu(C)) $
    We can write the log term as: $ log (mu(A inter C) / mu(C)) + log (mu(A inter B inter C) / mu(A inter C)) $
    Substituting and splitting the sum yields $ H(alpha | gamma) + H(beta | alpha or gamma) $
  ]

  + Show that, if $beta <= alpha$, then $H(gamma | alpha) <= H(gamma | beta)$.

  #ans[
    This reflects the fact that conditioning on a more refined partition ($alpha$) reduces uncertainty more than conditioning on a coarser one ($beta$).
  ]

  + Show that $H(alpha or beta) = H(alpha) + H(beta | alpha)$.

  #ans[
    This is the Chain Rule for Entropy. Total uncertainty of the pair is the uncertainty of $alpha$ plus the remaining uncertainty of $beta$ once $alpha$ is known.
  ]

  + Show that, if $beta <= alpha$, then $H(beta | alpha) = 0$.

  #ans[
    If $beta$ is coarser than $alpha$, knowing the specific element of $alpha$ uniquely determines the element of $beta$. There is zero remaining uncertainty.
  ]

  + Explain in words why each result (a)-(d) is reasonable.

  #ans[
    - (a) The uncertainty of two pieces of info given a third is the uncertainty of the first piece plus the remaining uncertainty of the second.
    - (b) More information ($alpha$) can only help you guess $gamma$ better than less information ($beta$).
    - (c) Total uncertainty is the sum of the initial uncertainty and the conditional uncertainty.
    - (d) You can't be uncertain about a summary ($beta$) if you already know the full detail ($alpha$).
  ]



=== Project

==== Notes

Some notes about the book:
+ Focus on section 6.1
+ $mu$ (Greek letter) refers to a probability, which the book will sometimes call a "measure".
+ You can ignore the stuff about transformations (the function $T : X -> X$). Especially after excercise 6.1.4.
+ Narrow your focus further to subsections 6.1.1, 6.1.2 (up to and including exercise 6.1.4). Then skip to subsection 6.1.4 up to and including exercise 6.1.15.

You can pick and choose among these exercises, and also include the example I talked about on the board (also written in the notes). You should at least include a proof of why the entropy of the uniform distribution is maximal (p. 156). If you want you can talk about the second videos (the one about wordle). You can also talk about some of the history (e.g. Ludwig Boltzmann, Claude Shannon) and significance (i.e. information theory, probability theory, machine learning, maximum entropy principle, etc.) of this topic.

#set enum(numbering: "1.")
+ Video presentation, about 20-30 minutes (submit as a group)
+ A problem/exercise for the rest of the class to try to solve (see #5 below). Mention this problem at the end of your presentation without a solution, and submit your solution as a PDF on brightspace. One place to look for such problems is in the resource related to your project. (submitted as a group)
+ Write a summary for some other team's project. Follow the guidelines/prompt questions on brightspace (submit individually, this is not a group assignment).
+ Repeat the step above for another team's project.
+ Submit a solution to one of the two problems (see step 2) corresponding to projects you wrote a summary about (also submit individually, this is not a group assignment)

==== Presentation

- What is information theory?
  - History: Claude Shannon, Bell Labs
  - What questions does it aim to solve?
    - Encryption, error correcting algorithms, anything relating to digital communication
- What is information?
  - Logarithms?
  - Bits as units of information
- Average information per symbol, then define as entropy
  - Solve some problem with entropy
- Wordle application for finding an informative first word
- Proof that uniform distribution has maximal entropy
- Introduce cylinder sets and entropy of a partition, related to wordle example

===== Script

*Speaker 1*: Hi everyone. For our project, we looked at the concept of entropy. You've probably heard of entropy in thermodynamics or physics, originally tied to people like Ludwig Boltzmann. But today we're going to focus on its application in Data Science and digital communication, which is usually called Shannon Entropy.

[Manim Animation: Display a simple timeline starting with Boltzmann (Thermodynamics) moving to Claude Shannon at Bell Labs (1948). Show a basic graphic of a sender, a noisy channel, and a receiver.]

*Speaker 1*:
Claude Shannon essentially invented Information Theory while working at Bell Labs. He wanted to solve problems related to digital communication, like encryption, error-correcting algorithms, and how to reliably send data over a noisy channel.

To do that, he had to define what "information" actually is. In this context, information is just a stream of symbols. The amount of information you get from an event is related to how surprised you are by it. If you know something is definitely going to happen, it gives you zero information. Because computers use binary, we measure this information in bits, which means we use base-2 logarithms for all our math. I'll pass it to *Speaker 2* to go over the actual formula.

*Speaker 2*: Right, so mathematically, if we have a set of outcomes $X$, and a probability distribution $mu$, the Shannon entropy $H$ is defined as the negative sum of $p_i$ times the base-2 log of $p_i$.

[Manim Animation: Fade in the formula: $H(mu) = -sum_(i=1)^n p_i log_2 p_i$. Then show a graph of $-p log_2 p$ to visually demonstrate the curve peaking in the middle.]

*Speaker 2*:
This formula gives us the average amount of information, or uncertainty, per symbol.

Let's look at the extremes. If $p_i = 1$, meaning there's absolutely no randomness and we know exactly what will happen, the entropy is zero. By convention, zero times log zero is just treated as zero.

On the other hand, the entropy is maximized when the distribution is completely uniform—meaning every outcome is equally likely. So if every $p_i = 1/n$, the entropy formula simplifies to just $log_2(n)$. The proof for this relies on the fact that the log function is strictly concave. Because of that concavity, spreading the probability out as evenly as possible across all options maximizes the sum. If you skew the probabilities, you decrease the uncertainty, and the entropy goes down.

*Speaker 3*: We can also look at this through the lens of partitions, which we covered in class. In the notes, a partition element is referred to as a "macrostate."

[Manim Animation: Visualize a large rectangle representing the sequence space, then slice it into smaller grids to represent cylinder sets forming a partition $zeta_m$.]

*Speaker 3*:
If we have words of length $m$, they determine what are called cylinder sets. These are basically sets of sequences whose first $m$ symbols agree. These cylinder sets form a partition of the sequence space.

Looking at Exercise 6.1.2 from the text, we proved that if you have two partitions, $alpha$ and $beta$, their join—written as $alpha or beta$—is also a partition.

[Manim Animation: Show vertical slices for partition $alpha$ (yellow) and horizontal slices for partition $beta$ (blue). Overlay them to show the grid formed by $alpha or beta$ (green intersections).]

*Speaker 3*:
It's a partition because the intersection of the sets from $alpha$ and $beta$ are disjoint, and their union still covers the entire space $X$. When you refine a partition like this, you're basically creating smaller macrostates. And smaller macrostates mean you have more specific information, which relates to how entropy changes.

*Speaker 1*: To make this more concrete, we did a calculation for a simple coin flip scenario, but with a biased coin. Let's say the alphabet $X$ is 0 and 1, where the probability of 0 is 2/3, and the probability of 1 is 1/3.

[Manim Animation: Show a tree diagram of the coin flips. First branch: 0 (2/3) and 1 (1/3). Calculate $H(S_1) approx 0.918$. Expand to two and three flips, grouping by the sum of 1s.]

*Speaker 1*:
We looked at the entropy of the count distribution, meaning the number of 1s after $m$ flips.
After one flip, $S_1$, the probabilities are just 2/3 and 1/3. Plugging that into the formula gives us an entropy of about 0.918 bits.

After two flips, $S_2$, the possible sums of 1s are 0, 1, or 2. The probabilities become 4/9, 4/9, and 1/9. Calculating that gives an entropy of 1.392 bits.
For three flips, it follows a binomial distribution, and the entropy goes up to 1.698 bits.
The entropy of the sum increases as you do more draws, but not linearly, because the extreme sums become increasingly rare.

*Speaker 2*: Moving on to Exercise 6.1.4, we looked at a few properties of entropy when dealing with partitions.

[Manim Animation: Bulleted list appearing one by one with brief visual representations.

$alpha < beta => H(alpha) < H(beta)$

$H(alpha or beta) < H(alpha) + H(beta)$

Independence: $H(alpha or beta) = H(alpha) + H(beta)$]

*Speaker 2*:
First, if partition $alpha$ is a refinement of $beta$, then $H(alpha) < H(beta)$. Refining a partition spreads the probability out among more outcomes, which increases the uncertainty.

Second is subadditivity. The entropy of the joint partition $alpha or beta$ is always less than or equal to the sum of their individual entropies.

And finally, if the two partitions are completely independent—meaning the probability of their intersection is just the product of their individual probabilities—then the entropy of the joint partition is exactly equal to $H(alpha) + H(beta)$.

*Speaker 3*: So, why do we actually care about any of this? A practical, everyday application of this is the game Wordle.

[Manim Animation: Show a mock Wordle grid. Type a word like "CRANE". Show the grid of possible remaining words shrinking massively.]

*Speaker 3*:
When you guess a word in Wordle, the game gives you a pattern of green, yellow, and gray squares. You can think of the possible feedback patterns as a partition of the remaining valid words in the dictionary.

An optimal Wordle bot uses Shannon entropy to pick the first word. It calculates the expected information for every possible guess. A word with high entropy will partition the remaining dictionary into roughly equal-sized buckets. This minimizes your uncertainty for the next guess. If you pick a bad starting word, the partition is highly skewed, and your expected information in bits is much lower.

*Speaker 1*: That pretty much covers the basics of block entropy and partitions. To wrap up our presentation, we have a problem for the class to try based on the formula we went over earlier.

[Manim Animation: Display the problem text cleanly on the screen in large text:
"Find probabilities $p_1, p_2, p_3$ for a system with three letters such that the entropy per symbol $x$ satisfies $1/4 < x < 1/3$."]

*Speaker 1*: We have a system with three letters, and you need to find a valid probability distribution—so $p_1, p_2,$ and $p_3$ need to add up to 1. You just need to find values such that the total entropy per symbol is between 1/4 and 1/3 of a bit.

We'll be uploading our solution to Brightspace. You guys can work on that now. Thanks.

==== Problem for the class

- Problem with cylinder sets
- Find probabilities $p_1$, $p_2$, $p_3$ for a system with three letters such that the entropy per symbol $x$ satisfies $1/4 < x < 1/3$.
