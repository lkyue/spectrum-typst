#import "template.typ": *
#import "@preview/algo:0.3.6"
#import "@preview/alchemist:0.2.0": *
#import "@preview/cetz:0.5.2"
#import "@preview/unify:0.8.1": *
#import "@preview/physica:0.9.8": *

#show: note.with(
  title: "Spectrum Typst",
  author: "Demo Document",
  subtitle: "Feature Showcase",
  cover: true,
)
#set text(lang: "en")

= Theorem Environments

== All Environment Types

#theorem(title: "Mean Value Theorem")[
  If $f$ is continuous on $[a, b]$ and differentiable on $(a, b)$, then
  $ exists c in (a, b): f(b) - f(a) = f'(c)(b - a). $
] <thm:mvt>

#proof[
  Apply Rolle's theorem to $g(x) = f(x) - f(a) - frac(f(b) - f(a), b - a)(x - a)$.
]

#lemma(title: "Triangle Inequality")[
  For any vectors $bold(u), bold(v) in bb(R)^n$:
  $ |bold(u) + bold(v)| <= |bold(u)| + |bold(v)|. $
]

#definition(title: "Group")[
  A _group_ $(G, *) $ is a set $G$ with a binary operation $*$ satisfying:
  + _Closure:_ $forall a, b in G, a * b in G$.
  + _Associativity:_ $(a * b) * c = a * (b * c)$.
  + _Identity:_ $exists e in G, forall a in G: e * a = a * e = a$.
  + _Inverse:_ $forall a in G, exists a^(-1) in G: a * a^(-1) = a^(-1) * a = e$.
]

#property(title: "Determinant Multiplicativity")[
  For any $n times n$ matrices $A$ and $B$:
  $ det(A B) = det(A) dot det(B). $
]

#example(title: "Continuous but Not Differentiable")[
  The Weierstrass function $W(x) = sum_(n=0)^oo a^n cos(b^n pi x)$ is continuous everywhere
  but differentiable nowhere, for $0 < a < 1$ and odd $b$ with $a b > 1 + 3 pi / 2$.
]

#remark[
  While continuity is necessary for differentiability, it is not sufficient.
  The construction above is a classic counterexample.
]


#pagebreak()

Here is a common exam-style question.
#problem[
  Prove that a continuous function on a compact set is uniformly continuous.
]

#solution[
  Let $f: K -> bb(R)$ be continuous with $K$ compact. Given $epsilon > 0$, for each $x in K$ choose
  $delta_x$ via continuity. The open cover ${B_(delta_x/2)(x)}$ has a finite subcover. Let
  $delta = min_i delta_(x_i)/2$. For $|x - y| < delta$, both lie in some $B_(delta_(x_i))(x_i)$,
  so $|f(x) - f(y)| < epsilon$. $qed$
]

= Tables & Equations

== Striped Tables

All tables have alternating row colors automatically.

#table(
  columns: 4,
  table.header([Function], [Derivative], [Integral], [Series]),
  [$e^x$],   [$e^x$],         [$e^x + C$],   [$sum_(n=0)^oo x^n / n!$],
  [$sin x$],  [$cos x$],       [$-cos x + C$], [$sum_(n=0)^oo (-1)^n x^(2n+1) / (2n+1)!$],
  [$cos x$],  [$-sin x$],      [$sin x + C$],  [$sum_(n=0)^oo (-1)^n x^(2n) / (2n)!$],
  [$ln x$],   [$1/x$],         [$x ln x - x + C$], [—],
)

== Labeled Equations

Equations with labels are numbered by section and can be cross-referenced.

#definition(title: "Gradient and Hessian")[
  The gradient of $f: bb(R)^n -> bb(R)$ is
  $ grad f = (pdv(f, x_1), dots, pdv(f, x_n))^T. $ <eq:grad>

  The Hessian matrix is
  $ bold(H)_f = mat(
    pdv(f, x_1, 2), dots, pdv(f, x_1, x_n);
    dots, dots, dots;
    pdv(f, x_n, x_1), dots, pdv(f, x_n, 2)
  ). $ <eq:hess>
]

At a local minimum, @eq:grad vanishes and @eq:hess is positive semidefinite. See @thm:mvt for the
foundation of gradient-based optimization.

= Pseudocode & Algorithms

== Gradient Descent

#let gd-body = {
  [Input: objective $f: bb(R)^n -> bb(R)$, initial $bold(x)_0$, step $alpha > 0$, tolerance $epsilon$]
  linebreak()
  [$k := 0$]
  linebreak()
  [while $|grad f(bold(x)_k)| > epsilon$ do]
  linebreak()
  algo.i
  [#algo.comment[Compute descent direction]]
  linebreak()
  [#algo.i $bold(d)_k := -grad f(bold(x)_k)$ #algo.d]
  linebreak()
  [#algo.comment[Update with step size]]
  linebreak()
  [#algo.i $bold(x)_(k+1) := bold(x)_k + alpha bold(d)_k$ #algo.d]
  linebreak()
  [#algo.i $k := k + 1$ #algo.d]
  linebreak()
  algo.d
  [return $bold(x)_k$]
}

#algo.algo(
  line-numbers: true,
  indent-size: 1.5em,
  title: "Gradient Descent",
  gd-body,
)

== Newton's Method

#let newton-body = {
  [Input: $f$, $bold(x)_0$, tolerance $epsilon$]
  linebreak()
  [$k := 0$]
  linebreak()
  [while $|grad f(bold(x)_k)| > epsilon$ do]
  linebreak()
  algo.i
  [#algo.comment[Compute Newton direction]]
  linebreak()
  [#algo.i Solve $bold(H)_f(bold(x)_k) bold(d)_k = -grad f(bold(x)_k)$ #algo.d]
  linebreak()
  [#algo.i $bold(x)_(k+1) := bold(x)_k + bold(d)_k$ #algo.d]
  linebreak()
  [#algo.i $k := k + 1$ #algo.d]
  linebreak()
  algo.d
  [return $bold(x)_k$]
}

#algo.algo(
  line-numbers: true,
  indent-size: 1.5em,
  title: "Newton's Method",
  newton-body,
)

#remark[
  Gradient descent has linear convergence, while Newton's method has quadratic convergence
  near the optimum, at the cost of computing and inverting the Hessian at each step.
]

= Vector Graphics

== Coordinate System

#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  set-style(axes: (tick-length: 0.05))
  line((-4, 0), (4, 0), mark: (end: ">"))
  line((0, -3), (0, 3), mark: (end: ">"))
  content((4.3, 0), [$x$])
  content((0.1, 3.3), [$y$])
  content((1, -0.5), [$1$])
  content((-0.5, 1), [$1$])
  line((-0.2, 1), (0, 1))
  line((1, -0.2), (1, 0))
})

== Neural Network Sketch

#cetz.canvas(length: 0.9cm, {
  import cetz.draw: *
  let inputs = ((0, 3), (0, 1.5), (0, 0))
  let hidden = ((2.5, 3.5), (2.5, 2), (2.5, 0.5), (2.5, -1))
  let output = ((5, 1.5),)

  // Draw connections
  for i in inputs {
    for h in hidden {
      line(i, h, stroke: gray.lighten(50%))
    }
  }
  for h in hidden {
    for o in output {
      line(h, o, stroke: gray.lighten(50%))
    }
  }

  // Draw nodes
  for i in inputs { circle(i, radius: 0.25, fill: blue.lighten(60%)) }
  for h in hidden { circle(h, radius: 0.25, fill: green.lighten(60%)) }
  for o in output { circle(o, radius: 0.25, fill: red.lighten(60%)) }

  content((-1, 1.5), [Inputs])
  content((6.2, 1.5), [Output])
})

= Chemistry & Physics

== Chemical Structure

#skeletize({
  fragment(name: "A", "COOH")
  single()
  fragment(name: "B", "CH")
  branch({
    single(angle: 1)
    fragment(name: "X", "OH")
    single()
    fragment(name: "Y", $"NH"_2$)
  })
  single()
  fragment(name: "C", "CH")
  branch({
    single(angle: -1)
    fragment(name: "Z", $"CH"_3$)
  })
  single()
  fragment(name: "R2", "H")
})

A generic amino acid backbone with side chains.

== Reaction Thermodynamics

#table(
  columns: 4,
  table.header([Reaction], [Type], [$Delta H$], [$Delta S$]),
  [$"N"_2 + 3"H"_2 -> 2"NH"_3$], [Haber], [#qty("-92.4", "kJ/mol")], [#qty("-198.8", "J/(mol K)")],
  [$"C" + "O"_2 -> "CO"_2$], [Combustion], [#qty("-393.5", "kJ/mol")], [#qty("2.9", "J/(mol K)")],
  [$"CaCO"_3 -> "CaO" + "CO"_2$], [Decomposition], [#qty("178.3", "kJ/mol")], [#qty("160.4", "J/(mol K)")],
)

== Physics Notation

#property(title: "Maxwell's Equations in Vacuum")[
  $ div vb(E) = 0, quad div vb(B) = 0, $
  $ curl vb(E) = -pdv(vb(B), t), quad curl vb(B) = mu_0 epsilon_0 pdv(vb(E), t). $
]

#theorem(title: "Electromagnetic Wave Equation")[
  Taking the curl of Faraday's law and substituting Ampère's law yields the wave equation:
  $ laplacian vb(E) = mu_0 epsilon_0 pdv(vb(E), t, 2), $
  describing waves propagating at $c = 1 / sqrt(mu_0 epsilon_0) approx$ #qty("2.998e8", "m/s").
]

#example(title: "Visible Light")[
  Visible wavelengths range from #qtyrange("380", "750", "nm"), corresponding to frequencies
  of #qtyrange("400", "790", "THz"). The energy per photon is
  $E = h nu approx$ #qtyrange("1.65", "3.27", "eV").
]

#remark(title: "Unit Formatting")[
  All physical quantities above use the `unify` package: `qty` for values with units and
  `qtyrange` for ranges. Unit formatting is automatic and follows SI conventions.
]

= 中文示例

#set text(lang: "zh")

== 定积分与极限

#theorem(title: "牛顿-莱布尼茨公式")[
  若 $F$ 是 $f$ 在 $[a, b]$ 上的一个原函数，则
  $ integral_a^b f(x) dif x = F(b) - F(a). $
]

#proof[
  将 $[a, b]$ 分成 $n$ 等份，利用拉格朗日中值定理。
]

#definition(title: "一致连续")[
  设 $f: I -> bb(R)$。若对任意 $epsilon > 0$，存在 $delta > 0$，使得对任意 $x, y in I$，当 $|x - y| < delta$ 时恒有
  $ |f(x) - f(y)| < epsilon, $
  则称 $f$ 在 $I$ 上一致连续。
]

#problem[
  证明 $f(x) = sqrt(x)$ 在 $[0, oo)$ 上不一致连续，但在 $[1, oo)$ 上一致连续。
]

#solution[
  取 $x_n = 1/n^2$，$y_n = 1/(4n^2)$，则 $|x_n - y_n| -> 0$ 但 $|f(x_n) - f(y_n)| = 1/(2n) not-> 0$，
  故不一致连续。在 $[1, oo)$ 上，$|f(x) - f(y)| = |x-y|/(sqrt(x) + sqrt(y)) <= |x-y|/2$，满足 Lipschitz 条件。
]

== 物理常数

#table(
  columns: 3,
  table.header([常数], [符号], [数值]),
  [真空光速], [$c$], [#qty("2.998e8", "m/s")],
  [普朗克常数], [$h$], [#qty("6.626e-34", "J s")],
  [万有引力常数], [$G$], [#qty("6.674e-11", "m^3 kg^-1 s^-2")],
  [阿伏伽德罗常数], [$N_A$], [#qty("6.022e23", "mol^-1")],
)

#remark[
  @thm:mvt 可推广至多维：若 $f: bb(R)^n -> bb(R)$ 可微，则存在 $xi$ 使得
  $ f(bold(y)) - f(bold(x)) = grad f(xi) dot (bold(y) - bold(x)) $。
  参考式 @eq:grad 和 @eq:hess。
]
