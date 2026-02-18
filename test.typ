// =========================================================================
// typcas Test & Demo
// =========================================================================
#import "lib.typ": *

#set page(margin: 1.5cm)
#set text(font: "New Computer Modern", size: 11pt)

#align(center)[
  #text(size: 18pt, weight: "bold")[typcas Test Suite]
  #v(0.3em)
  #text(size: 10pt, fill: gray)[A Lightweight Computer Algebra System for Typst]
]

#line(length: 100%, stroke: 0.5pt + gray)

// === Helpers ===
#let test-row(label, input-expr, result-expr) = {
  block(below: 0.6em)[
    *#label:* $ #cas-display(input-expr) arrow.r.double #cas-display(result-expr) $
  ]
}
#let show-fn(expr) = { $ #cas-display(expr) $ }
#let p = cas-parse  // shorthand

// =====================================================================
= 1. Expression Construction
// =====================================================================

// Parsed expressions
#table(
  columns: (auto, auto),
  stroke: none,
  inset: (x: 1em, y: 0.4em),
  [*Variable*], show-fn(p("x")),
  [*Number*], show-fn(p("42")),
  [*Pi*], show-fn(p("pi")),
  [*Euler*], show-fn(p("e")),
  [*Sum*], show-fn(p("x + 3")),
  [*Product*], show-fn(p("2x")),
  [*Power*], show-fn(p("x^2")),
  [*Fraction*], show-fn(p("x / 3")),
  [*Composed*], show-fn(p("3x^2 - 2x + 5")),
  [*Abs*], show-fn(p("abs(x)")),
  [*Log*], show-fn(p("log_2(x)")),
  [*Log Impl*], show-fn(p("log_2 x")),
  [*Log(a,b)*], show-fn(p("log(2, 8)")),

)


=== Trig (6)
#grid(
  columns: 6,
  gutter: 1em,
  show-fn(p("sin(x)")),
  show-fn(p("cos(x)")),
  show-fn(p("tan(x)")),
  show-fn(p("csc(x)")),
  show-fn(p("sec(x)")),
  show-fn(p("cot(x)")),
)

=== Inverse Trig (6)
#grid(
  columns: 6,
  gutter: 1em,
  show-fn(p("arcsin(x)")),
  show-fn(p("arccos(x)")),
  show-fn(p("arctan(x)")),
  show-fn(p("arccsc(x)")),
  show-fn(p("arcsec(x)")),
  show-fn(p("arccot(x)")),
)

=== Hyperbolic (6)
#grid(
  columns: 6,
  gutter: 1em,
  show-fn(p("sinh(x)")),
  show-fn(p("cosh(x)")),
  show-fn(p("tanh(x)")),
  show-fn(p("csch(x)")),
  show-fn(p("sech(x)")),
  show-fn(p("coth(x)")),
)

=== Inverse Hyperbolic (6)
#grid(
  columns: 6,
  gutter: 1em,
  show-fn(p("arcsinh(x)")),
  show-fn(p("arccosh(x)")),
  show-fn(p("arctanh(x)")),
  show-fn(p("arccsch(x)")),
  show-fn(p("arcsech(x)")),
  show-fn(p("arccoth(x)")),
)

=== Other
#grid(
  columns: 3,
  gutter: 1em,
  show-fn(p("ln(x)")), show-fn(p("exp(x)")), show-fn(p("sqrt(x)")),
)

=== Summation & Product
#grid(
  columns: 2,
  gutter: 2em,
  show-fn(p("sum_(k=1)^n k^2")), show-fn(p("product_(k=1)^n k")),
)

=== Matrix
$ #cas-display(cmat(((1, 2), (3, 4)))) #h(2em) #cas-display(mat-id(3)) $

// =====================================================================
= 2. Simplification
// =====================================================================

#{
  let x = p("x")
  test-row("x + 0", p("x + 0"), simplify(p("x + 0")))
  test-row("x × 1", p("x * 1"), simplify(p("x * 1")))
  test-row("x × 0", p("x * 0"), simplify(p("x * 0")))
  test-row("x^1", p("x^1"), simplify(p("x^1")))
  test-row("x^0", p("x^0"), simplify(p("x^0")))
  test-row("2 + 3", p("2 + 3"), simplify(p("2 + 3")))
  test-row("4 × 5", p("4 * 5"), simplify(p("4 * 5")))
  test-row("2^3", p("2^3"), simplify(p("2^3")))
  test-row("−(−x)", neg(neg(cvar("x"))), simplify(neg(neg(cvar("x")))))
  test-row("x + x", p("x + x"), simplify(p("x + x")))
  test-row("3x + 2x", p("3x + 2x"), simplify(p("3x + 2x")))
  test-row("x × x", p("x * x"), simplify(p("x * x")))
  test-row("x / x", p("x / x"), simplify(p("x / x")))
  test-row("6 / 4", p("6 / 4"), simplify(p("6 / 4")))
}

=== Function identities
#test-row("ln(e)", ln-of(const-e), simplify(ln-of(const-e)))
#test-row("exp(0)", exp-of(num(0)), simplify(exp-of(num(0))))
#test-row("sinh(0)", sinh-of(num(0)), simplify(sinh-of(num(0))))
#test-row("cosh(0)", cosh-of(num(0)), simplify(cosh-of(num(0))))
#test-row("tanh(0)", tanh-of(num(0)), simplify(tanh-of(num(0))))

=== Logarithm rules
#{
  let x = cvar("x")
  let y = cvar("y")
  test-row("ln(x·y)", ln-of(mul(x, y)), simplify(ln-of(mul(x, y))))
  test-row("ln(x/y)", ln-of(cdiv(x, y)), simplify(ln-of(cdiv(x, y))))
  test-row("ln(x²)", p("ln(x^2)"), simplify(p("ln(x^2)")))
}

=== Absolute value
#test-row("|−5|", abs-of(num(-5)), simplify(abs-of(num(-5))))
#test-row("|3|", abs-of(num(3)), simplify(abs-of(num(3))))
#test-row("|−x|", abs-of(neg(cvar("x"))), simplify(abs-of(neg(cvar("x")))))

=== Expansion
#{
  let expr = p("x^2 + 3x")
  let repl = p("y + 1")
  let sub-expr = substitute(expr, "x", repl)
  let simplified = simplify(sub-expr)
  block(below: 0.6em)[
    *Substitute $x = #cas-display(repl)$ into $#cas-display(expr)$:*
    $ arrow.r.double #cas-display(sub-expr) $
    $ arrow.r.double #cas-display(simplified) #h(0.5em) "(expanded)" $
  ]
}

// =====================================================================
= 3. Differentiation
// =====================================================================

#{
  let all = (
    ("d/dx (x³)", p("x^3")),
    ("d/dx (sin x)", p("sin(x)")),
    ("d/dx (cos x)", p("cos(x)")),
    ("d/dx (tan x)", p("tan(x)")),
    ("d/dx (csc x)", p("csc(x)")),
    ("d/dx (sec x)", p("sec(x)")),
    ("d/dx (cot x)", p("cot(x)")),
    ("d/dx (ln x)", p("ln(x)")),
    ("d/dx (eˣ)", p("exp(x)")),
    // Inverse trig
    ("d/dx (arcsin x)", p("arcsin(x)")),
    ("d/dx (arccos x)", p("arccos(x)")),
    ("d/dx (arctan x)", p("arctan(x)")),
    ("d/dx (arccsc x)", p("arccsc(x)")),
    ("d/dx (arcsec x)", p("arcsec(x)")),
    ("d/dx (arccot x)", p("arccot(x)")),
    // Hyperbolic
    ("d/dx (sinh x)", p("sinh(x)")),
    ("d/dx (cosh x)", p("cosh(x)")),
    ("d/dx (tanh x)", p("tanh(x)")),
    ("d/dx (csch x)", p("csch(x)")),
    ("d/dx (sech x)", p("sech(x)")),
    ("d/dx (coth x)", p("coth(x)")),
  )
  for (label, expr) in all {
    test-row(label, expr, simplify(diff(expr, "x")))
  }
}

=== Higher-Order Derivatives
#{
  let expr = p("x^4")
  block(below: 0.6em)[
    *d²/dx² (x⁴):* $ #cas-display(expr) arrow.r.double #cas-display(diff-n(expr, "x", 2)) $
  ]
}
#{
  let expr = p("sin(x)")
  block(below: 0.6em)[
    *d³/dx³ (sin x):* $ #cas-display(expr) arrow.r.double #cas-display(diff-n(expr, "x", 3)) $
  ]
}

// =====================================================================
= 4. Integration
// =====================================================================

#{
  let all = (
    ("∫ x² dx", p("x^2")),
    ("∫ sin(x) dx", p("sin(x)")),
    ("∫ cos(x) dx", p("cos(x)")),
    ("∫ eˣ dx", p("exp(x)")),
    ("∫ 1/x dx", p("1 / x")),
    ("∫ sec(x) dx", p("sec(x)")),
    ("∫ csc(x) dx", p("csc(x)")),
    ("∫ cot(x) dx", p("cot(x)")),
    ("∫ sinh(x) dx", p("sinh(x)")),
    ("∫ cosh(x) dx", p("cosh(x)")),
    ("∫ tanh(x) dx", p("tanh(x)")),
  )
  for (label, expr) in all {
    test-row(label, expr, simplify(integrate(expr, "x")))
  }
}

=== Definite Integrals
#{
  let result = definite-integral(p("x^2"), "x", 0, 1)
  block(below: 0.6em)[
    *∫₀¹ x² dx:* $ #cas-display(result) $
  ]
}

#{
  let result = definite-integral(p("2x"), "x", 1, 3)
  block(below: 0.6em)[
    *∫₁³ 2x dx:* $ #cas-display(result) $
  ]
}

// =====================================================================
= 5. Taylor Series
// =====================================================================

#{
  let result = taylor(p("exp(x)"), "x", 0, 4)
  block(below: 0.6em)[
    *Taylor of eˣ at x=0 (order 4):*
    $ #cas-display(result) $
  ]
}

#{
  let result = taylor(p("sin(x)"), "x", 0, 5)
  block(below: 0.6em)[
    *Taylor of sin(x) at x=0 (order 5):*
    $ #cas-display(result) $
  ]
}

// =====================================================================
= 6. Limits
// =====================================================================

#{
  let expr = p("sin(x) / x")
  let result = limit(expr, "x", 0)
  block(below: 0.6em)[
    *lim(x→0) sin(x)/x:* $ #cas-display(result) $
  ]
}

#{
  let expr = p("(x^2 - 4) / (x - 2)")
  let result = limit(expr, "x", 2)
  block(below: 0.6em)[
    *lim(x→2) (x²−4)/(x−2):* $ #cas-display(result) $
  ]
}

// =====================================================================
= 7. Equation Solving
// =====================================================================

#{
  let lhs = p("2x + 6")
  let solutions = solve(lhs, 0, "x")
  test-row("Linear: 2x + 6 = 0", lhs, solutions.at(0))
}

#{
  let lhs = p("3x - 9")
  let solutions = solve(lhs, 0, "x")
  test-row("Linear: 3x − 9 = 0", lhs, solutions.at(0))
}

#{
  let lhs = p("x^2 - 4")
  let solutions = solve(lhs, 0, "x")
  block(below: 0.6em)[
    *Quadratic: x² − 4 = 0:* $ #cas-display(lhs) = 0 arrow.r.double x = #cas-display(solutions.at(0)) "or" x = #cas-display(solutions.at(1)) $
  ]
}

// =====================================================================
= 8. Polynomial Factoring
// =====================================================================

#{
  let expr = p("x^2 - 5x + 6")
  let factored = factor(expr, "x")
  test-row("x² − 5x + 6", expr, factored)
}

#{
  let expr = p("x^2 - 4")
  let factored = factor(expr, "x")
  test-row("x² − 4", expr, factored)
}

#{
  let expr = p("x^3 - 6x^2 + 11x - 6")
  let factored = factor(expr, "x")
  test-row("x³ − 6x² + 11x − 6", expr, factored)
}

// =====================================================================
= 9. Numeric Evaluation
// =====================================================================

#{
  let expr = p("3x^2 + 2x + 1")
  let result = eval-expr(expr, (x: 2))
  block(below: 0.6em)[
    *Evaluate at x = 2:* $ #cas-display(expr) = #result $
  ]
}

#{
  let expr = sin-of(cdiv(const-pi, num(2)))
  let result = eval-expr(expr, (:))
  block(below: 0.6em)[
    *Evaluate:* $ #cas-display(expr) = #calc.round(result, digits: 6) $
  ]
}

#{
  let expr = p("abs(-7)")
  let result = eval-expr(expr, (:))
  block(below: 0.6em)[
    *Evaluate:* $ #cas-display(expr) = #result $
  ]
}

#{
  let expr = log-of(num(2), num(8))
  let result = eval-expr(expr, (:))
  block(below: 0.6em)[
    *Evaluate:* $ #cas-display(expr) = #calc.round(result, digits: 6) $
  ]
}

=== Summation Evaluation
#{
  // Σ_{k=1}^{10} k² = 385
  let expr = p("sum_(k=1)^10 k^2")
  let result = eval-expr(expr, (:))
  block(below: 0.6em)[
    *Evaluate:* $ #cas-display(expr) = #result $
  ]
}

#{
  // Π_{k=1}^{5} k = 120
  let expr = p("product_(k=1)^5 k")
  let result = eval-expr(expr, (:))
  block(below: 0.6em)[
    *Evaluate:* $ #cas-display(expr) = #result $
  ]
}

// =====================================================================
= 10. Matrix Algebra
// =====================================================================

#{
  let a = cmat(((1, 2), (3, 4)))
  let b = cmat(((5, 6), (7, 8)))

  block(below: 0.6em)[
    *A + B:*
    $ #cas-display(a) + #cas-display(b) = #cas-display(mat-add(a, b)) $
  ]

  block(below: 0.6em)[
    *A × B:*
    $ #cas-display(a) dot.op #cas-display(b) = #cas-display(mat-mul(a, b)) $
  ]

  block(below: 0.6em)[
    *det(A):* $ det #cas-display(a) = #cas-display(mat-det(a)) $
  ]

  block(below: 0.6em)[
    *Aᵀ:* $ #cas-display(a)^top = #cas-display(mat-transpose(a)) $
  ]
}

=== System of Equations (Cramer's Rule)
#{
  let a = cmat(((1, 2), (3, 4)))
  let b-vec = (num(5), num(6))
  let solutions = mat-solve(a, b-vec)
  block(below: 0.6em)[
    *Solve Ax = b:*
    $ #cas-display(a) vec(x, y) = vec(5, 6) $
    $ x = #cas-display(solutions.at(0)), #h(0.5em) y = #cas-display(solutions.at(1)) $
  ]
}



// =====================================================================
= 12. Substitution
// =====================================================================

#{
  let expr = p("x^2 + 3x")
  let repl = p("y + 1")
  let sub-expr = substitute(expr, "x", repl)
  let simplified = simplify(sub-expr)
  block(below: 0.6em)[
    *Substitute $x = #cas-display(repl)$ into $#cas-display(expr)$:*
    $ arrow.r.double #cas-display(sub-expr) $
    $ arrow.r.double #cas-display(simplified) #h(0.5em) "(expanded)" $
  ]
}

// =====================================================================
= 13. Parser Round-Trip
// =====================================================================

#{
  let expr = p("x^3 + 2x^2 - x + 5")
  let simplified = simplify(expr)
  let deriv = simplify(diff(simplified, "x"))
  block(below: 0.6em)[
    *Parse, simplify, differentiate `"x^3 + 2x^2 - x + 5"`*
    $ "parsed:" #h(0.5em) #cas-display(expr) $
    $ "simplified:" #h(0.5em) #cas-display(simplified) $
    $ "d/dx:" #h(0.5em) #cas-display(deriv) $
  ]
}

#{
  let expr = p("x^2 - 5x + 6")
  let solutions = solve(expr, 0, "x")
  block(below: 0.6em)[
    *Parse and solve `"x^2 - 5x + 6 = 0"`*
    $ #cas-display(expr) = 0 arrow.r.double x = #solutions.map(s => cas-display(s)).join(" or ") $
  ]
}

// =====================================================================
= 14. Content Parsing
// =====================================================================

#{
  let expr1 = cas-parse($x^2 + frac(1, 2)$)
  let expr2 = cas-parse($sqrt(x) + root(3, y)$)
  let expr3 = cas-parse($sum_(k=1)^n k^2$)
  let expr4 = cas-parse($sin(x) + cos(x)$)
  let expr5 = cas-parse($product_(i=1)^n i$)

  block(below: 0.6em)[
    *Content `$x^2 + frac(1, 2)$`:* $ #cas-display(expr1) $
    *Content `$sqrt(x) + root(3, y)$`:* $ #cas-display(expr2) $
    *Content `$sum_(k=1)^n k^2$`:* $ #cas-display(expr3) $
    *Content `$sin(x) + cos(x)$`:* $ #cas-display(expr4) $
    *Content Product* $ #cas-display(expr5) $
  ]
}
