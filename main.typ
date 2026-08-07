#import "template.typ": *
// #import "@local/spectrum-typst:0.1.0": *
#import "@preview/algo:0.3.6"
#import "@preview/alchemist:0.2.0": *
#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/unify:0.8.1": *
#import "@preview/physica:0.9.8": * 

// Rewrite a usage sample file.




// #show: note.with(title: "STEM Notes", author: "John Doe", cover: true, subtitle: "Usage Guidance")
// #set text(lang:"en")

// = Mathematics

// == Partial Derivatives

// #definition[
//   The partial derivative of $f: bb(R)^n -> bb(R)$ with respect to $x_i$ at $vec(x)$ is
//   $ pdv(f, x_i) = lim_(h->0) (f(vec(x) + h e_i) - f(vec(x))) / h. $
// ]

// #lemma(title: "Descent Direction")[
//   If $grad f != 0$, then $-grad f$ is a descent direction:
//   $ exists alpha > 0, f(vec(x) - alpha grad f) < f(vec(x)). $
// ]

// #proof[
//   By Taylor: $ f(vec(x) - alpha grad f) = f(vec(x)) - alpha |grad f|^2 + cal(O)(alpha^2). $ For small $alpha$, the linear term dominates.
// ]

// #theorem(title: "Chain Rule")[
//   If $f(bold(x))$ and $bold(x)(bold(u))$ are differentiable, then
//   $ pdv(f, u_i) = sum_j pdv(f, x_j) pdv(x_j, u_i). $
// ]

// == Common Gradients

// #table(
//   columns: 4,
//   table.header([$f$], [$grad f$], [Convex?], [Note]),
//   [$|x|^2$],   [$2x$],  [Yes], [Strongly],
//   [$x^T A x$], [$(A + A^T)x$], [if $A ⪰ 0$], [Quadratic],
//   [$-log x$],  [$-1/x$], [Yes], [Log barrier],
//   [$e^x$],     [$e^x$], [Yes], [Strictly],
// )

// = Physics

// == Maxwell's Equations

// #property(title: "Gauss's Law")[
//   $ div vb(E) = rho / epsilon_0, $ 
// ]


// #table(
//   columns: 3,
//   table.header([Law], [Integral Form], [Differential Form]),
//   [Gauss],   [$oint vb(E) dot dd(vb(A)) = q_"enc"/epsilon_0$], [$div vb(E) = rho/epsilon_0$],
//   [Faraday], [$oint vb(E) dot dd(vb(l)) = - dv(,t) integral vb(B) dot dd(vb(A))$], [$curl vb(E) = -pdv(vb(B),t)$],
//   [Ampère],  [$oint vb(B) dot dd(vb(l)) = mu_0 I_"enc" + mu_0 epsilon_0 dv(,t) integral vb(E) dot dd(vb(A))$], [$curl vb(B) = mu_0 vb(J) + mu_0 epsilon_0 pdv(vb(E),t)$],
// )

// == Electromagnetic Wave

// #definition[
//   In free space, taking curl of Faraday and substituting Ampère:
//   $ laplacian vb(E) = mu_0 epsilon_0 pdv(vb(E), t, 2). $
//   This is the wave equation with speed $c = 1 / sqrt(mu_0 epsilon_0)$.
// ]

// #example(title: "Plane Wave")[
//   $vb(E)(z, t) = E_0 cos(k z - omega t) vu(x)$ propagates along $z$.

//   #canvas(length: 1cm, {
//     import draw: *
//     set-style(axes: (tick-length: 0.05))
//     line((-0.5, 0), (5.5, 0), mark: (end: ">"))
//     line((0, -1.5), (0, 1.5), mark: (end: ">"))
//     content((5.8, 0), [$z$])
//     content((0.1, 1.7), [$vb(E)$])
//     line((-0.2, 1), (0, 1)); content((-0.3, 1), [$E_0$])
//     line((0, 0), (0.25, 1), stroke: red)
//     line((0.25, 1), (0.75, -1), stroke: red)
//     line((0.75, -1), (1.25, 1), stroke: red)
//     line((1.25, 1), (1.75, -1), stroke: red)
//     line((1.75, -1), (2.25, 1), stroke: red)
//     line((2.25, 1), (2.75, -1), stroke: red)
//     line((2.75, -1), (3.25, 1), stroke: red)
//     line((3.25, 1), (3.75, -1), stroke: red)
//     line((3.75, -1), (4.25, 1), stroke: red)
//     line((4.25, 1), (4.75, -1), stroke: red)
//     line((4.75, -1), (5, 0), stroke: red)
//   })

//   Wavelength $lambda = 2 pi / k$, visible light: #qtyrange("380", "750", "nm"). #footnote[$c approx$ #qty("2.998e8", "m/s").]
// ]

// #problem[
//   Show $vb(B)(z, t) = (E_0/c) cos(k z - omega t) vu(y)$ satisfies Faraday's law.
// ]

// #solution[
//   $curl vb(E) = pdv(E_x, z) vu(y) = -k E_0 sin(k z - omega t) vu(y) = -pdv(vb(B), t)$. $qed$
// ]

// = Chemistry

// == Chemical Structures

// #skeletize({
//   fragment(name: "A", "R")
//   single()
//   fragment("B")
//   branch({
//     single(angle: 1)
//     fragment(name: "X", "OH")
//     single()
//     fragment(name: "Y", $"NH"_2$)
//   })
//   single()
//   fragment(name: "C", "COOH")
// })

// == Key Reactions

// #table(
//   columns: 3,
//   table.header([Reaction], [Type], [$Delta H$]),
//   [$"N"_2 + 3"H"_2 -> 2"NH"_3$], [Haber], [#qty("-92.4", "kJ/mol")],
//   [$"C" + "O"_2 -> "CO"_2$], [Combustion], [#qty("-393.5", "kJ/mol")],
//   [$"H"_2"O" -> "H"^+ + "OH"^-$], [Dissociation], [#qty("55.8", "kJ/mol")],
// )

// #remark[
//   Reaction rates follow Arrhenius: $k = A e^(-E_a / (R T))$, where $E_a$ is activation energy (typically #qtyrange("40", "200", "kJ/mol")).
// ]

// = Computer Science

// == Gradient Descent

// #let gd-body = {
//   [Input: $f: bb(R)^n -> bb(R)$, $x_0$, step $alpha > 0$, tolerance $epsilon$]
//   linebreak()
//   [$k := 0$]
//   linebreak()
//   [while $|grad f(x_k)| > epsilon$ do]
//   linebreak()
//   algo.i
//   [#algo.comment[Descent direction]]
//   linebreak()
//   [#algo.i $d_k := -grad f(x_k)$ #algo.d]
//   linebreak()
//   [#algo.comment[Line search]]
//   linebreak()
//   [#algo.i $x_(k+1) := x_k + alpha d_k$ #algo.d]
//   linebreak()
//   [#algo.i $k := k + 1$ #algo.d]
//   linebreak()
//   algo.d
//   [return $x_k$]
// }

// #algo.algo(
//   line-numbers: true,
//   indent-size: 1.5em,
//   title: "Gradient Descent",
//   gd-body,
// )

// #theorem(title: "Convergence")[
//   For $L$-smooth, $mu$-strongly convex $f$ with $alpha = 2/(L+mu)$:
//   $ |x_k - x^*| <= ((kappa - 1)/(kappa + 1))^k |x_0 - x^*|, $ where $kappa = L/mu$.
// ]

// #problem[
//   Implement GD for $f(x) = (x-3)^2$ with $x_0 = 0$, $alpha = 0.1$. How many iterations to reach $|f'(x)| < 10^(-3)$?
// ]

// #solution[
//   $f'(x) = 2(x-3)$, $x_(k+1) = x_k - 0.2(x_k - 3) = 0.8 x_k + 0.6$. Starting from 0: $x_1 = 0.6$, $x_2 = 1.08$, ... converges to 3. Error halves roughly every 3 iterations. $qed$
// ]

// = Earth Science

// == Earth's Structure

// #canvas(length: 1cm, {
//   import draw: *
//   circle((0, 0), radius: 3, fill: yellow.lighten(80%), stroke: black)
//   circle((0, 0), radius: 2.2, fill: orange.lighten(60%), stroke: black)
//   circle((0, 0), radius: 1.1, fill: red.lighten(40%), stroke: black)
//   circle((0, 0), radius: 0.3, fill: red, stroke: black)
//   content((0, 2.5), [Crust])
//   content((0, 1.5), [Mantle])
//   content((0, 0.6), [Core])
// })

// == Key Properties

// #table(
//   columns: 4,
//   table.header([Layer], [Depth], [Temp], [State]),
//   [Crust],    [#qtyrange("0", "35", "km")],  [#qtyrange("0", "400", "degC")],  [Solid],
//   [Mantle],   [#qtyrange("35", "2890", "km")], [#qtyrange("1000", "3700", "degC")], [Solid],
//   [Outer Core], [#qtyrange("2890", "5150", "km")], [#qtyrange("3700", "4300", "degC")], [Liquid],
//   [Inner Core], [#qtyrange("5150", "6371", "km")], [#qtyrange("4300", "5500", "degC")], [Solid],
// )

// #property(title: "Seismic Waves")[
//   P-waves travel through solids and liquids at $v_P = sqrt((K + 4/3 G) / rho)$, while S-waves only through solids at $v_S = sqrt(G / rho)$.
// ]

// #remark[
//   The Earth's magnetic field ($approx$ #qty("50", "uT") at the surface) is generated by convection in the liquid outer core (geodynamo). #footnote[Earth's mass: #qty("5.97e24", "kg"), radius: #qty("6371", "km").]
// ]
