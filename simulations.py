"""Simulations for Information Theory presentation.

Provides:
- empirical entropy convergence for a biased coin
- Binary Symmetric Channel (BSC) capacity plot
- Huffman coding average length example

Run with: `python simulations.py --help`
"""

from __future__ import annotations
import argparse
import os
from typing import Iterable, Dict

import heapq
import collections

import numpy as np
import matplotlib.pyplot as plt


def empirical_entropy(samples: Iterable[int], base: float = 2.0) -> float:
    """Compute empirical Shannon entropy for discrete samples."""
    counts = collections.Counter(samples)
    probs = np.array(list(counts.values()), dtype=float)
    probs /= probs.sum()
    # avoid log(0)
    return -np.sum(probs * np.log(probs) / np.log(base))


def simulate_coin_entropy(
    p: float = 0.5, n: int = 20000, step: int = 200, out_path: str | None = None
):
    """Simulate Bernoulli(p) samples and plot running empirical entropy.

    Saves a plot to `out_path` if provided and returns final empirical entropy.
    """
    rng = np.random.default_rng()
    samples = rng.random(n) < p
    samples = samples.astype(int)

    xs = list(range(step, n + 1, step))
    ys = []
    for m in xs:
        h = empirical_entropy(samples[:m], base=2.0)
        ys.append(h)

    # theoretical entropy
    q = p
    if q in (0.0, 1.0):
        h_true = 0.0
    else:
        h_true = -(q * np.log2(q) + (1 - q) * np.log2(1 - q))

    plt.figure(figsize=(6, 4))
    plt.plot(xs, ys, label="Empirical H_n", color="C0")
    plt.hlines(
        h_true,
        xs[0],
        xs[-1],
        colors="C1",
        linestyles="--",
        label=f"True H (p={p}) = {h_true:.4f}",
    )
    plt.xlabel("Samples")
    plt.ylabel("Entropy (bits)")
    plt.title(f"Empirical Entropy Convergence (p={p})")
    plt.legend()
    plt.grid(alpha=0.2)

    if out_path:
        os.makedirs(os.path.dirname(out_path), exist_ok=True)
        plt.savefig(out_path, bbox_inches="tight")
    else:
        plt.show()
    plt.close()
    return ys[-1]


def bsc_capacity_plot(out_path: str | None = None):
    """Plot capacity C = 1 - H(p) for p in [0,0.5]."""
    ps = np.linspace(0.0, 0.5, 201)

    def H(p):
        p = np.clip(p, 1e-12, 1 - 1e-12)
        return -(p * np.log2(p) + (1 - p) * np.log2(1 - p))

    Cs = 1 - H(ps)

    plt.figure(figsize=(6, 4))
    plt.plot(ps, Cs, color="C2")
    plt.xlabel("Error probability p")
    plt.ylabel("Capacity (bits/symbol)")
    plt.title("BSC Capacity: C = 1 - H(p)")
    plt.grid(alpha=0.2)

    if out_path:
        os.makedirs(os.path.dirname(out_path), exist_ok=True)
        plt.savefig(out_path, bbox_inches="tight")
    else:
        plt.show()
    plt.close()
    return ps, Cs


def huffman_average_length(freqs: Dict[str, float]) -> float:
    """Compute average code length for given symbol frequencies using Huffman algorithm.

    `freqs` maps symbol -> probability or relative frequency.
    """
    # Huffman: use min-heap of weights
    heap = [float(v) for v in freqs.values()]
    heapq.heapify(heap)
    total_cost = 0.0
    while len(heap) > 1:
        a = heapq.heappop(heap)
        b = heapq.heappop(heap)
        cost = a + b
        total_cost += cost
        heapq.heappush(heap, cost)
    # For average length, when weights are probabilities, total_cost equals sum p_i * l_i
    return total_cost


def simulate_huffman_example(out_path: str | None = None) -> float:
    freqs = {"A": 0.5, "B": 0.3, "C": 0.2}
    avg_len = huffman_average_length(freqs)

    # Create a small bar plot of frequencies
    names = list(freqs.keys())
    vals = [freqs[n] for n in names]
    plt.figure(figsize=(5, 3))
    plt.bar(names, vals, color=["C0", "C1", "C2"])
    plt.title(f"Huffman example — avg length ≈ {avg_len:.2f} bits")
    plt.ylabel("Probability")

    if out_path:
        os.makedirs(os.path.dirname(out_path), exist_ok=True)
        plt.savefig(out_path, bbox_inches="tight")
    else:
        plt.show()
    plt.close()
    return avg_len


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--coin", action="store_true", help="Run coin entropy simulation"
    )
    parser.add_argument(
        "--p", type=float, default=0.5, help="Bias for coin (default 0.5)"
    )
    parser.add_argument("--bsc", action="store_true", help="Plot BSC capacity")
    parser.add_argument("--huffman", action="store_true", help="Run Huffman example")
    parser.add_argument(
        "--out-dir",
        default="media/images/simulations",
        help="Output directory for images",
    )
    args = parser.parse_args()

    out_dir = args.out_dir
    if args.coin:
        out_file = os.path.join(out_dir, f"coin_entropy_p{args.p:.2f}.png")
        final_h = simulate_coin_entropy(p=args.p, n=20000, step=200, out_path=out_file)
        print(
            f"Saved coin entropy plot to {out_file}. Final empirical entropy: {final_h:.4f} bits"
        )

    if args.bsc:
        out_file = os.path.join(out_dir, "bsc_capacity.png")
        bsc_capacity_plot(out_path=out_file)
        print(f"Saved BSC capacity plot to {out_file}")

    if args.huffman:
        out_file = os.path.join(out_dir, "huffman_example.png")
        avg_len = simulate_huffman_example(out_path=out_file)
        print(
            f"Saved Huffman example plot to {out_file}. Average length: {avg_len:.2f} bits"
        )

    if not (args.coin or args.bsc or args.huffman):
        parser.print_help()


if __name__ == "__main__":
    main()
