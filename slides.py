from manim import *
from manim_slides import Slide


class Title(Slide):
    def construct(self):
        title = Text("Entropy", font_size=72, weight=BOLD)
        subtitle = Text("Math 308 Project", font_size=36)
        subtitle.next_to(title, DOWN, buff=0.5)

        self.play(Write(title), run_time=1.5)
        self.play(FadeIn(subtitle), run_time=1)
        self.next_slide()

        # self.play(FadeOut(title), FadeOut(subtitle))


class HistoryAndMotivation(Slide):
    def construct(self):
        title = Text("History & Motivation", font_size=54, weight=BOLD)
        title.to_edge(UP)

        self.play(Write(title))
        self.next_slide()

        # Create bullet points
        points = [
            "Claude Shannon (1948) - Founder of Information Theory",
            "Problem: How to reliably transmit information over noisy channels?",
            "Applications: Communication, compression, cryptography, AI",
            "Fundamental question: What is information?",
        ]

        text_objs = []
        for i, point in enumerate(points):
            text = Text(f"• {point}", font_size=24, color=WHITE)
            text.to_edge(LEFT, buff=0.5)
            text.shift(DOWN * (0.8 + i * 1.2))
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.5)

        self.next_slide()
        self.play(FadeOut(title, *text_objs))


class Entropy(Slide):
    def construct(self):
        title = Text("Shannon Entropy", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        # Formula
        formula_text = MathTex(
            r"H(X) = -\sum_x p(x) \log_2 p(x)", font_size=40, color=YELLOW
        )
        formula_text.next_to(title, DOWN, buff=1)
        self.play(Write(formula_text))
        self.next_slide()

        # Explanation
        explanation = [
            "• Measures average uncertainty in a random variable",
            "• Units: bits (when using log₂)",
            "• Higher entropy = more uncertainty",
            "• Maximum entropy when all outcomes equally likely",
        ]

        text_objs = []
        for i, text_str in enumerate(explanation):
            text = Text(text_str, font_size=22)
            text.next_to(formula_text, DOWN, buff=0.5).shift(DOWN * i * 0.8)
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.3)

        self.next_slide()
        self.play(FadeOut(title, formula_text, *text_objs))


class EntropyExample(Slide):
    def construct(self):
        title = Text("Entropy Example: Fair Coin", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        # Show coin flip outcomes
        coin_text = Text("Fair Coin: p(Heads) = 0.5, p(Tails) = 0.5", font_size=28)
        coin_text.next_to(title, DOWN, buff=1)
        self.play(Write(coin_text))
        self.next_slide()

        # Calculation
        calculation = MathTex(
            r"H = -\left(0.5 \times \log_2(0.5) + 0.5 \times \log_2(0.5)\right)"
            + "\n"
            + r"H = -\left(0.5 \times (-1) + 0.5 \times (-1)\right)"
            + "\n"
            + r"H = 1 \text{ bit}",
            font_size=26,
            color=YELLOW,
        )
        calculation.next_to(coin_text, DOWN, buff=0.8)
        self.play(Write(calculation))
        self.next_slide()

        # Visualization
        bars = VGroup()
        prob_text = Text("Probability: 50% each outcome", font_size=24)
        prob_text.next_to(calculation, DOWN, buff=1)

        for i, label in enumerate(["Heads", "Tails"]):
            bar = Rectangle(width=1.5, height=1.5, color=BLUE)
            bar.next_to(prob_text, DOWN, buff=0.3).shift(RIGHT * (i - 0.5) * 2)
            label_text = Text(label, font_size=20)
            label_text.next_to(bar, DOWN, buff=0.2)
            bars.add(bar, label_text)

        self.play(FadeIn(prob_text), FadeIn(bars))
        self.next_slide()

        self.play(FadeOut(title, coin_text, calculation, prob_text, bars))


class InformationContent(Slide):
    def construct(self):
        title = Text("Information Content", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        # Formula
        formula = MathTex(
            r"I(x) = \log_2\left(\frac{1}{p(x)}\right) = -\log_2 p(x)",
            font_size=40,
            color=YELLOW,
        )
        formula.next_to(title, DOWN, buff=1)
        self.play(Write(formula))
        self.next_slide()

        # Key points
        points = [
            "• Information content is inversely related to probability",
            "• Rare events carry more information",
            "• Expected information = Entropy",
            "• Measured in bits per symbol",
        ]

        text_objs = []
        for i, point in enumerate(points):
            text = Text(point, font_size=22)
            text.next_to(formula, DOWN, buff=0.5).shift(DOWN * i * 0.8)
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.3)

        self.next_slide()
        self.play(FadeOut(title, formula, *text_objs))


class SourceCoding(Slide):
    def construct(self):
        title = Text("Source Coding (Data Compression)", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        points = [
            "Problem: Efficiently encode data",
            "Goal: Minimize average code length",
            "Kraft-McMillan Inequality: L ≥ H(X)",
            "Example: Huffman Coding",
            "Theoretical limit: Entropy H(X)",
        ]

        text_objs = []
        for i, point in enumerate(points):
            text = Text(f"• {point}", font_size=24)
            text.to_edge(LEFT, buff=0.5)
            text.shift(DOWN * (0.8 + i * 1))
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.4)

        self.next_slide()
        self.play(FadeOut(title, *text_objs))


class HuffmanExample(Slide):
    def construct(self):
        title = Text("Huffman Coding Example", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        # Symbol frequencies
        freq_text = MathTex(r"\text{Symbols: } A(0.5), B(0.3), C(0.2)", font_size=28)
        freq_text.next_to(title, DOWN, buff=0.8)
        self.play(Write(freq_text))
        self.next_slide()

        # Huffman codes
        codes_text = Text(
            "Huffman Codes:\nA → 0 (1 bit)\nB → 10 (2 bits)\nC → 11 (2 bits)",
            font_size=26,
            color=YELLOW,
        )
        codes_text.next_to(freq_text, DOWN, buff=0.8)
        self.play(Write(codes_text))
        self.next_slide()

        # Average length calculation
        avg_text = MathTex(
            r"\text{Average length: } 0.5(1) + 0.3(2) + 0.2(2) = 1.5 \text{ bits}",
            font_size=24,
            color=GREEN,
        )
        avg_text.next_to(codes_text, DOWN, buff=0.8)
        self.play(Write(avg_text))
        self.next_slide()

        # Entropy comparison
        entropy_text = MathTex(
            r"\text{Entropy: } 0.5(-\log_2 0.5) + 0.3(-\log_2 0.3) + 0.2(-\log_2 0.2) \approx 1.49 \text{ bits}",
            font_size=22,
        )
        entropy_text.next_to(avg_text, DOWN, buff=0.5)
        self.play(Write(entropy_text))
        self.next_slide()

        self.play(FadeOut(title, freq_text, codes_text, avg_text, entropy_text))


class MutualInformation(Slide):
    def construct(self):
        title = Text("Mutual Information", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        # Definition
        formula = MathTex(
            r"I(X;Y) = \sum_x \sum_y p(x,y) \log_2\left(\frac{p(x,y)}{p(x)p(y)}\right)",
            font_size=36,
            color=YELLOW,
        )
        formula.next_to(title, DOWN, buff=0.8)
        self.play(Write(formula))
        self.next_slide()

        # Explanation
        explanation = [
            "• Measures shared information between two variables",
            "• I(X;Y) = H(X) - H(X|Y) = H(Y) - H(Y|X)",
            "• Symmetric: I(X;Y) = I(Y;X)",
            "• Always non-negative: I(X;Y) ≥ 0",
            "• Independence: I(X;Y) = 0 iff X and Y independent",
        ]

        text_objs = []
        for i, text_str in enumerate(explanation):
            text = Text(text_str, font_size=22)
            text.next_to(formula, DOWN, buff=0.5).shift(DOWN * i * 0.7)
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.3)

        self.next_slide()
        self.play(FadeOut(title, formula, *text_objs))


class ChannelCapacity(Slide):
    def construct(self):
        title = Text("Channel Capacity", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        # Shannon's Channel Capacity Theorem
        formula = MathTex(r"C = \max_{p(x)} I(X;Y)", font_size=40, color=YELLOW)
        formula.next_to(title, DOWN, buff=0.8)
        self.play(Write(formula))
        self.next_slide()

        # Key insights
        insights = [
            "• Maximum rate at which information can be reliably transmitted",
            "• Maximized over all possible input distributions p(x)",
            "• For AWGN channel: C = log₂(1 + SNR) bits/symbol",
            "• Shannon-Hartley Theorem: C = B × log₂(1 + P/N)",
            "  where B = bandwidth, P = signal power, N = noise power",
        ]

        text_objs = []
        for i, text_str in enumerate(insights):
            text = Text(text_str, font_size=22)
            text.next_to(formula, DOWN, buff=0.5).shift(DOWN * i * 0.8)
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.3)

        self.next_slide()
        self.play(FadeOut(title, formula, *text_objs))


class BinarySymmetricChannel(Slide):
    def construct(self):
        title = Text("Binary Symmetric Channel (BSC)", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        # Channel description
        desc = Text("Bit transmitted with error probability p", font_size=28)
        desc.next_to(title, DOWN, buff=0.8)
        self.play(Write(desc))
        self.next_slide()

        # Capacity formula
        capacity = MathTex(
            r"C = 1 - H(p) = 1 + p \log_2 p + (1-p) \log_2(1-p)",
            font_size=28,
            color=YELLOW,
        )
        capacity.next_to(desc, DOWN, buff=0.8)
        self.play(Write(capacity))
        self.next_slide()

        # Examples
        examples = [
            "• p = 0: C = 1 bit/symbol (perfect transmission)",
            "• p = 0.5: C = 0 bits/symbol (complete noise)",
            "• p = 0.1: C ≈ 0.53 bits/symbol",
            "• Better coding can approach channel capacity",
        ]

        text_objs = []
        for i, example in enumerate(examples):
            text = Text(example, font_size=22)
            text.next_to(capacity, DOWN, buff=0.5).shift(DOWN * i * 0.7)
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.3)

        self.next_slide()
        self.play(FadeOut(title, desc, capacity, *text_objs))


class ErrorCorrection(Slide):
    def construct(self):
        title = Text("Error Correction Codes", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        points = [
            "Problem: Recover message despite channel noise",
            "Solution: Add redundancy to transmitted data",
            "Hamming Distance: Minimum difference between codewords",
            "Error Detection & Correction Trade-off",
            "Examples: Hamming codes, Reed-Solomon codes, Turbo codes",
        ]

        text_objs = []
        for i, point in enumerate(points):
            text = Text(f"• {point}", font_size=24)
            text.to_edge(LEFT, buff=0.5)
            text.shift(DOWN * (0.8 + i * 1))
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.4)

        self.next_slide()
        self.play(FadeOut(title, *text_objs))


class HammingCode(Slide):
    def construct(self):
        title = Text("Hamming(7,4) Code Example", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        desc = Text(
            "Transmit 7 bits to encode 4 data bits (3 parity bits)", font_size=28
        )
        desc.next_to(title, DOWN, buff=0.8)
        self.play(Write(desc))
        self.next_slide()

        details = [
            "4 information bits → 7 transmitted bits",
            "Can detect and correct any single-bit error",
            "Code rate: 4/7 ≈ 0.57",
            "Uses parity-check matrix: H = [[1,0,0,1,0,1,1],",
            "                                  [0,1,0,1,1,0,1],",
            "                                  [0,0,1,0,1,1,1]]",
        ]

        text_objs = []
        for i, detail in enumerate(details):
            text = Text(detail, font_size=20)
            text.next_to(desc, DOWN, buff=0.4).shift(DOWN * i * 0.65)
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.3)

        self.next_slide()
        self.play(FadeOut(title, desc, *text_objs))


class Applications(Slide):
    def construct(self):
        title = Text("Applications of Information Theory", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        applications = [
            "🔹 Data Compression: ZIP, JPEG, MP3, H.264 video",
            "🔹 Communications: 5G, WiFi, Satellite networks",
            "🔹 Cryptography: Secure key distribution, encryption",
            "🔹 Storage: Hard drives, SSDs, memory optimization",
            "🔹 Machine Learning: Classification, entropy-based decision trees",
            "🔹 Biology: DNA sequencing, genetic information",
            "🔹 AI: Information gain, deep learning optimization",
        ]

        text_objs = []
        for i, app in enumerate(applications):
            text = Text(app, font_size=22)
            text.to_edge(LEFT, buff=0.5)
            text.shift(DOWN * (0.6 + i * 0.75))
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.3)

        self.next_slide()
        self.play(FadeOut(title, *text_objs))


class KeyTakeaways(Slide):
    def construct(self):
        title = Text("Key Takeaways", font_size=54, weight=BOLD)
        title.to_edge(UP)
        self.play(Write(title))
        self.next_slide()

        takeaways = [
            "✓ Entropy quantifies average information in a signal",
            "✓ Channel capacity is the maximum reliable transmission rate",
            "✓ Coding theory bridges theory and practice",
            "✓ Information theory has applications across science & technology",
            "✓ Fundamental limits guide system design",
        ]

        text_objs = []
        for i, takeaway in enumerate(takeaways):
            text = Text(takeaway, font_size=26)
            text.to_edge(LEFT, buff=0.5)
            text.shift(DOWN * (0.8 + i * 0.95))
            text_objs.append(text)

        for text_obj in text_objs:
            self.play(FadeIn(text_obj), run_time=0.4)

        self.next_slide()
        self.play(FadeOut(title, *text_objs))


class Conclusion(Slide):
    def construct(self):
        text1 = Text("Information Theory", font_size=60, weight=BOLD)
        text2 = Text("The language of the digital age", font_size=36, color=BLUE)
        text2.next_to(text1, DOWN, buff=0.8)

        self.play(Write(text1), run_time=1.5)
        self.play(FadeIn(text2), run_time=1)
        self.next_slide()
