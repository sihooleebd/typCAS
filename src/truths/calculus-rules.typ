// =========================================================================
// CAS Calculus Rules Table
// =========================================================================
// Single source of truth for function-level calculus rules.
// Each entry maps a function name to:
//   - diff: closure u => outer derivative f'(u)  (chain rule multiplied externally)
//   - integ: closure u => antiderivative F(u), or none
//   - diff-step: string pattern for step display (@ = inner function placeholder)
//   - domain-note (optional): domain caveat text for real-domain usage.
// =========================================================================

#import "../expr.typ": *

/// Public helper `calc-rules`.
#let calc-rules = (
  // --- Basic Trig ---
  sin: (
    diff: u => cos-of(u),
    integ: u => neg(cos-of(u)),
    diff-step: "d/dx sin(@) = cos(@) · @'",
  ),
  cos: (
    diff: u => neg(sin-of(u)),
    integ: u => sin-of(u),
    diff-step: "d/dx cos(@) = -sin(@) · @'",
  ),
  tan: (
    diff: u => cdiv(num(1), pow(cos-of(u), num(2))),
    integ: u => neg(ln-of(abs-of(cos-of(u)))),
    diff-step: "d/dx tan(@) = sec²(@) · @'",
  ),
  csc: (
    diff: u => neg(mul(csc-of(u), cot-of(u))),
    integ: u => neg(ln-of(abs-of(add(csc-of(u), cot-of(u))))),
    diff-step: "d/dx csc(@) = -csc(@)cot(@) · @'",
  ),
  sec: (
    diff: u => mul(sec-of(u), tan-of(u)),
    integ: u => ln-of(abs-of(add(sec-of(u), tan-of(u)))),
    diff-step: "d/dx sec(@) = sec(@)tan(@) · @'",
  ),
  cot: (
    diff: u => neg(cdiv(num(1), pow(sin-of(u), num(2)))),
    integ: u => ln-of(abs-of(sin-of(u))),
    diff-step: "d/dx cot(@) = -csc²(@) · @'",
  ),

  // --- Inverse Trig ---
  arcsin: (
    diff: u => cdiv(num(1), sqrt-of(sub(num(1), pow(u, num(2))))),
    integ: none,
    diff-step: "d/dx arcsin(@) = @'/√(1-@²)",
    domain-note: "Real-domain derivative requires -1 < @ < 1.",
  ),
  arccos: (
    diff: u => neg(cdiv(num(1), sqrt-of(sub(num(1), pow(u, num(2)))))),
    integ: none,
    diff-step: "d/dx arccos(@) = -@'/√(1-@²)",
    domain-note: "Real-domain derivative requires -1 < @ < 1.",
  ),
  arctan: (
    diff: u => cdiv(num(1), add(num(1), pow(u, num(2)))),
    integ: none,
    diff-step: "d/dx arctan(@) = @'/(1+@²)",
  ),
  arccsc: (
    diff: u => neg(cdiv(num(1), mul(u, sqrt-of(sub(pow(u, num(2)), num(1)))))),
    integ: none,
    diff-step: "d/dx arccsc(@) = -@'/(@√(@²-1))",
    domain-note: "Real-domain derivative requires |@| > 1.",
  ),
  arcsec: (
    diff: u => cdiv(num(1), mul(u, sqrt-of(sub(pow(u, num(2)), num(1))))),
    integ: none,
    diff-step: "d/dx arcsec(@) = @'/(@√(@²-1))",
    domain-note: "Real-domain derivative requires |@| > 1.",
  ),
  arccot: (
    diff: u => neg(cdiv(num(1), add(num(1), pow(u, num(2))))),
    integ: none,
    diff-step: "d/dx arccot(@) = -@'/(1+@²)",
  ),
  // Common aliases
  asin: (
    diff: u => cdiv(num(1), sqrt-of(sub(num(1), pow(u, num(2))))),
    integ: none,
    diff-step: "d/dx asin(@) = @'/√(1-@²)",
    domain-note: "Real-domain derivative requires -1 < @ < 1.",
  ),
  acos: (
    diff: u => neg(cdiv(num(1), sqrt-of(sub(num(1), pow(u, num(2)))))),
    integ: none,
    diff-step: "d/dx acos(@) = -@'/√(1-@²)",
    domain-note: "Real-domain derivative requires -1 < @ < 1.",
  ),
  atan: (
    diff: u => cdiv(num(1), add(num(1), pow(u, num(2)))),
    integ: none,
    diff-step: "d/dx atan(@) = @'/(1+@²)",
  ),
  acsc: (
    diff: u => neg(cdiv(num(1), mul(u, sqrt-of(sub(pow(u, num(2)), num(1)))))),
    integ: none,
    diff-step: "d/dx acsc(@) = -@'/(@√(@²-1))",
    domain-note: "Real-domain derivative requires |@| > 1.",
  ),
  asec: (
    diff: u => cdiv(num(1), mul(u, sqrt-of(sub(pow(u, num(2)), num(1))))),
    integ: none,
    diff-step: "d/dx asec(@) = @'/(@√(@²-1))",
    domain-note: "Real-domain derivative requires |@| > 1.",
  ),
  acot: (
    diff: u => neg(cdiv(num(1), add(num(1), pow(u, num(2))))),
    integ: none,
    diff-step: "d/dx acot(@) = -@'/(1+@²)",
  ),

  // --- Hyperbolic ---
  sinh: (
    diff: u => cosh-of(u),
    integ: u => cosh-of(u),
    diff-step: "d/dx sinh(@) = cosh(@) · @'",
  ),
  cosh: (
    diff: u => sinh-of(u),
    integ: u => sinh-of(u),
    diff-step: "d/dx cosh(@) = sinh(@) · @'",
  ),
  tanh: (
    diff: u => cdiv(num(1), pow(cosh-of(u), num(2))),
    integ: u => ln-of(cosh-of(u)),
    diff-step: "d/dx tanh(@) = sech²(@) · @'",
  ),
  csch: (
    diff: u => neg(mul(csch-of(u), coth-of(u))),
    integ: u => ln-of(abs-of(tanh-of(cdiv(u, num(2))))),
    diff-step: "d/dx csch(@) = -csch(@)coth(@) · @'",
  ),
  sech: (
    diff: u => neg(mul(sech-of(u), tanh-of(u))),
    integ: u => mul(num(2), arctan-of(tanh-of(cdiv(u, num(2))))),
    diff-step: "d/dx sech(@) = -sech(@)tanh(@) · @'",
  ),
  coth: (
    diff: u => neg(pow(csch-of(u), num(2))),
    integ: u => ln-of(abs-of(sinh-of(u))),
    diff-step: "d/dx coth(@) = -csch²(@) · @'",
  ),

  // --- Inverse Hyperbolic ---
  arcsinh: (
    diff: u => cdiv(num(1), sqrt-of(add(pow(u, num(2)), num(1)))),
    integ: none,
    diff-step: "d/dx arcsinh(@) = @'/√(@²+1)",
  ),
  arccosh: (
    diff: u => cdiv(num(1), sqrt-of(sub(pow(u, num(2)), num(1)))),
    integ: none,
    diff-step: "d/dx arccosh(@) = @'/√(@²-1)",
    domain-note: "Real-domain derivative requires @ > 1.",
  ),
  arctanh: (
    diff: u => cdiv(num(1), sub(num(1), pow(u, num(2)))),
    integ: none,
    diff-step: "d/dx arctanh(@) = @'/(1-@²)",
    domain-note: "Real-domain derivative requires |@| < 1.",
  ),
  arccsch: (
    diff: u => neg(cdiv(num(1), mul(u, sqrt-of(add(pow(u, num(2)), num(1)))))),
    integ: none,
    diff-step: "d/dx arccsch(@) = -@'/(@√(@²+1))",
  ),
  arcsech: (
    diff: u => neg(cdiv(num(1), mul(u, sqrt-of(sub(num(1), pow(u, num(2))))))),
    integ: none,
    diff-step: "d/dx arcsech(@) = -@'/(@√(1-@²))",
  ),
  arccoth: (
    diff: u => cdiv(num(1), sub(num(1), pow(u, num(2)))),
    integ: none,
    diff-step: "d/dx arccoth(@) = @'/(1-@²)",
    domain-note: "Real-domain derivative requires |@| > 1.",
  ),
  // Common aliases
  asinh: (
    diff: u => cdiv(num(1), sqrt-of(add(pow(u, num(2)), num(1)))),
    integ: none,
    diff-step: "d/dx asinh(@) = @'/√(@²+1)",
  ),
  acosh: (
    diff: u => cdiv(num(1), sqrt-of(sub(pow(u, num(2)), num(1)))),
    integ: none,
    diff-step: "d/dx acosh(@) = @'/√(@²-1)",
    domain-note: "Real-domain derivative requires @ > 1.",
  ),
  atanh: (
    diff: u => cdiv(num(1), sub(num(1), pow(u, num(2)))),
    integ: none,
    diff-step: "d/dx atanh(@) = @'/(1-@²)",
    domain-note: "Real-domain derivative requires |@| < 1.",
  ),
  acsch: (
    diff: u => neg(cdiv(num(1), mul(u, sqrt-of(add(pow(u, num(2)), num(1)))))),
    integ: none,
    diff-step: "d/dx acsch(@) = -@'/(@√(@²+1))",
  ),
  asech: (
    diff: u => neg(cdiv(num(1), mul(u, sqrt-of(sub(num(1), pow(u, num(2))))))),
    integ: none,
    diff-step: "d/dx asech(@) = -@'/(@√(1-@²))",
  ),
  acoth: (
    diff: u => cdiv(num(1), sub(num(1), pow(u, num(2)))),
    integ: none,
    diff-step: "d/dx acoth(@) = @'/(1-@²)",
    domain-note: "Real-domain derivative requires |@| > 1.",
  ),

  // --- Logarithmic & Exponential ---
  ln: (
    diff: u => cdiv(num(1), u),
    integ: none,
    diff-step: "d/dx ln(@) = @'/@",
    domain-note: "Real-domain derivative requires @ > 0.",
  ),
  log: (
    diff: u => cdiv(num(1), u),
    integ: none,
    diff-step: "d/dx log(@) = @'/@",
    domain-note: "Real-domain derivative requires @ > 0.",
  ),
  exp: (
    diff: u => func("exp", u),
    integ: u => func("exp", u),
    diff-step: "d/dx e^@ = e^@ · @'",
  ),
  log2: (
    diff: u => cdiv(num(1), mul(u, ln-of(num(2)))),
    integ: none,
    diff-step: "d/dx log₂(@) = @'/( @ ln 2 )",
    domain-note: "Real-domain derivative requires @ > 0.",
  ),
  log10: (
    diff: u => cdiv(num(1), mul(u, ln-of(num(10)))),
    integ: none,
    diff-step: "d/dx log₁₀(@) = @'/( @ ln 10 )",
    domain-note: "Real-domain derivative requires @ > 0.",
  ),

  // --- Other ---
  abs: (
    diff: u => cdiv(u, abs-of(u)),
    integ: none,
    diff-step: "d/dx |@| = @/|@| · @'",
    domain-note: "Derivative is undefined when @ = 0.",
  ),
  sqrt: (
    diff: u => cdiv(num(1), mul(num(2), sqrt-of(u))),
    integ: none,
    diff-step: "d/dx √(@) = @'/(2√(@))",
    domain-note: "Real-domain derivative requires @ > 0.",
  ),
)
