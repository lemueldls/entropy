#!/usr/bin/env python3

from __future__ import annotations
import argparse
import shutil
import subprocess
import sys


DEFAULT_SLIDES = [
    "Title",
    # "HistoryAndMotivation",
    # "Entropy",
    # "EntropyExample",
    # "InformationContent",
    # "SourceCoding",
    # "HuffmanExample",
    # "MutualInformation",
    # "ChannelCapacity",
    # "BinarySymmetricChannel",
    # "ErrorCorrection",
    # "HammingCode",
    # "Applications",
    # "KeyTakeaways",
    "CoinEntropySim",
    "BSCCapacitySim",
    "HuffmanSim",
    # "Conclusion",
]


def run_cmd(cmd: list[str]) -> None:
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError:
        print(f"Command failed: {' '.join(cmd)}", file=sys.stderr)
        raise


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--render-only", action="store_true")
    parser.add_argument("--present-only", action="store_true")
    parser.add_argument("--slides", nargs="*", help="List slide class names in order")
    parser.add_argument(
        "--manim-cmd",
        default="manim-slides",
        help="manim-slides command (default: manim-slides)",
    )
    args = parser.parse_args()

    manim_cmd = shutil.which(args.manim_cmd)
    if manim_cmd is None:
        print(f"Error: '{args.manim_cmd}' not found in PATH.", file=sys.stderr)
        sys.exit(1)

    do_render = not args.present_only
    do_present = not args.render_only

    slides = args.slides if args.slides and len(args.slides) > 0 else DEFAULT_SLIDES

    if do_render:
        print("Rendering slides (this may take a while)...")
        run_cmd([manim_cmd, "render", "slides.py"] + slides)

    if do_present:
        print("Presenting slides in order:", " ".join(slides))
        run_cmd([manim_cmd, "present"] + slides)


if __name__ == "__main__":
    main()
