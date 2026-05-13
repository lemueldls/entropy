== Entropy & Information Theory - Presentation Script

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
