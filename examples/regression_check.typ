// =========================================================================
// typcas Regression Check
// =========================================================================
// Compile this file in CI/local checks.
// It panics if any regression check fails.
// =========================================================================

#import "../lib.typ": *

#let _check(name, ok, got: none, expect: none) = (
  name: name,
  ok: ok,
  got: got,
  expect: expect,
)

#let _check-eq(name, got, expect) = {
  let g = simplify(got)
  let e = simplify(expect)
  _check(name, expr-eq(g, e), got: g, expect: e)
}

#let checks = (
  // Sign/canonical normalization regressions.
  _check-eq(
    "sign-cancel-trig-product",
    simplify("2*cos(x)*(-sin(x)) + 2*cos(x)*sin(x)"),
    cas-parse("0"),
  ),
  _check-eq(
    "mixed-denominator-coeff-extract",
    simplify("x/(2*y) + x/(3*y)"),
    cas-parse("(5/6)*(x/y)"),
  ),
  _check-eq(
    "square-form-canonicalization",
    simplify("(x+y)^2 - (x+y)*(x+y)"),
    cas-parse("0"),
  ),
  _check-eq(
    "abs-square-even-power",
    simplify("abs(x)^2 - x^2"),
    cas-parse("0"),
  ),

  // Log reciprocal reductions.
  _check-eq(
    "log-recip-pair",
    simplify("ln(a/b) + ln(b/a)"),
    cas-parse("0"),
  ),
  _check-eq(
    "log-recip-unit",
    simplify("ln(a) + ln(1/a)"),
    cas-parse("0"),
  ),

  // Domain-sensitive policy behavior.
  _check(
    "domain-sensitive-default-off",
    not expr-eq(simplify("arcsin(sin(x))"), cas-parse("x")),
    got: simplify("arcsin(sin(x))"),
    expect: cas-parse("x"),
  ),
  _check-eq(
    "domain-sensitive-explicit-on",
    simplify("arcsin(sin(x))", allow-domain-sensitive: true),
    cas-parse("x"),
  ),

  // Calculus formula parity.
  _check-eq(
    "diff-log2",
    simplify(diff("log2(x)", "x")),
    cas-parse("1/(x*ln(2))"),
  ),
  _check-eq(
    "diff-arcsec-abs-denom",
    simplify(diff("arcsec(x)", "x")),
    cas-parse("1/(abs(x)*sqrt(x^2-1))"),
  ),
  _check-eq(
    "integrate-sec2-plus-csc2",
    simplify(integrate("sec(x)^2 + csc(x)^2", "x")),
    cas-parse("tan(x) - cot(x) + C"),
  ),

  // Solver sanity.
  _check(
    "cubic-solve-nonempty",
    solve("x^3 + 2*x^2 + 3*x + 1", 0, "x").len() >= 1,
    got: solve("x^3 + 2*x^2 + 3*x + 1", 0, "x"),
    expect: "at least one root",
  ),
)

#let failures = checks.filter(c => not c.ok)

#if failures.len() > 0 {
  panic("Regression failures:\n" + repr(failures))
}

= typcas Regression Check

All regression checks passed: #checks.len().
