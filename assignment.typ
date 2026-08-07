#import "template.typ": *
#import "@preview/algo:0.3.6"
#import "@preview/alchemist:0.2.0": *
#import "@preview/cetz:0.5.2"
#import "@preview/unify:0.8.1": *
#import "@preview/physica:0.9.8": *

#show: note.with(
  title: "Problem Set & Lab Report",
  author: "John Doe",
  subtitle: "Optimization Methods · Electromagnetic Waves",
  lecturer: "Prof. Smith",
  institution: "MIT",
  cover: false,
)
#set text(lang: "en")

= Problem Set 3

== Quadratic Minimization

#problem[
  Find the global minimum of
  $ f(x) = x^2 - 4x + 5. $ <eq:min>
]

#solution[
  Set $f'(x) = 2x - 4 = 0$, so $x = 2$. Since $f''(x) = 2 > 0$, the critical point is a
  minimum, and $f(2) = 1$.
]

#problem[
  Show that $f(bold(x)) = bold(x)^T A bold(x) - 2 bold(b)^T bold(x)$ with $A$ symmetric
  positive definite has a unique minimizer $bold(x)^* = A^(-1) bold(b)$.
]

#solution[
  The gradient is $grad f = 2 A bold(x) - 2 bold(b)$, so setting $grad f = 0$ gives
  $A bold(x) = bold(b)$. Since $A succ 0$, the Hessian $bold(H) = 2A$ is positive definite,
  hence $bold(x)^* = A^(-1) bold(b)$ is the unique minimizer.
]

== Descent Directions

#definition(title: "Gradient Descent Update")[
  The gradient descent iteration with step size $alpha$ is
  $ bold(x)_(k+1) = bold(x)_k - alpha grad f(bold(x)_k). $ <eq:gd>
]

#problem[
  For $f(x) = x^2 - 4x + 5$ and $alpha = 0.1$, starting from $x_0 = 0$, how many iterations
  does gradient descent take to reach $|f'(x)| < 10^(-3)$?
]

#solution[
  The update is $x_(k+1) = x_k - 0.2(x_k - 2) = 0.8 x_k + 0.4$, converging to $x = 2$.
  The error $e_k = x_k - 2$ satisfies $e_(k+1) = 0.8 e_k$, so we need
  $0.8^k dot 2 < 10^(-3)$, i.e. $k > ln(2000) / ln(1/0.8) approx 34$. About 34 iterations.
]

== Newton's Method

#remark[
  Newton's method uses the curvature of $f$ to converge faster:
  $ bold(x)_(k+1) = bold(x)_k - bold(H)_f(bold(x)_k)^(-1) grad f(bold(x)_k). $
]

#problem[
  Apply one Newton step to $f(x) = x^2 - 4x + 5$ from $x_0 = 0$ and compare with gradient
  descent.
]

#solution[
  $x_1 = x_0 - (2x_0 - 4)/2 = 0 - (-4)/2 = 2$. Newton's method reaches the exact minimizer
  in a single step for a quadratic function, while gradient descent needs ~34 iterations.
]

= Lab Report: Plane Wave Propagation

== Setup and Governing Equation

#definition(title: "Plane Wave")[
  In a lossless medium, the electric field of a plane wave propagating along $z$ is
  $ vb(E)(z, t) = E_0 cos(k z - omega t) vu(x). $ <eq:plane>
]

#property(title: "Dispersion Relation")[
  Substituting @eq:plane into the wave equation gives the dispersion relation
  $ k = omega / c, quad c = 1 / sqrt(mu_0 epsilon_0) approx$ #qty("2.998e8", "m/s").
]

#theorem(title: "Energy Flux")[
  The time-averaged Poynting vector of @eq:plane is
  $ angle(vb(S)) angle = (E_0^2)/(2 mu_0 c) vu(z), $
  representing the energy transported per unit area per unit time.
]

== Experimental Measurement

#problem[
  A visible-light laser has a measured power of #qty("5.0", "mW") over a spot of diameter
  #qty("2.0", "mm"). Estimate the peak electric field amplitude $E_0$.
]

#solution[
  Intensity is $I = P / A = (5.0 dot 10^(-3)) / (pi (1.0 dot 10^(-3))^2) approx$
  #qty("1592", "W/m^2"). Using $I = (E_0^2)/(2 mu_0 c)$,
  $ E_0 = sqrt(2 mu_0 c I) approx$ #qty("1095", "V/m").
]

== Numerical Verification

#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  set-style(axes: (tick-length: 0.05))
  line((-0.5, 0), (5.5, 0), mark: (end: ">"))
  line((0, -1.5), (0, 1.5), mark: (end: ">"))
  content((5.8, 0), [$z$])
  content((0.1, 1.7), [$vb(E)$])
  line((-0.2, 1), (0, 1)); content((-0.3, 1), [$E_0$])
  line((0, 0), (0.25, 1), stroke: red)
  line((0.25, 1), (0.75, -1), stroke: red)
  line((0.75, -1), (1.25, 1), stroke: red)
  line((1.25, 1), (1.75, -1), stroke: red)
  line((1.75, -1), (2.25, 1), stroke: red)
  line((2.25, 1), (2.75, -1), stroke: red)
  line((2.75, -1), (3.25, 1), stroke: red)
  line((3.25, 1), (3.75, -1), stroke: red)
  line((3.75, -1), (4.25, 1), stroke: red)
  line((4.25, 1), (4.75, -1), stroke: red)
  line((4.75, -1), (5, 0), stroke: red)
})

The snapshot above confirms the sinusoidal profile of @eq:plane at a fixed time $t = 0$.

#remark[
  For wavelengths in the visible range, #qtyrange("380", "750", "nm"), the corresponding
  photon energies are #qtyrange("1.65", "3.27", "eV").
]
