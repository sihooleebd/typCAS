#import "./lib.typ": *

= New Feature Tests

// Test 1: Radical simplification
#let r1 = cas.simplify("sqrt(12)")
#let r2 = cas.simplify("sqrt(72)")
#let r3 = cas.simplify("sqrt(50)")
#let r4 = cas.simplify("12^(1/3)")

*Radicals:*
- $sqrt(12)$ = #cas.display(r1.expr)
- $sqrt(72)$ = #cas.display(r2.expr)
- $sqrt(50)$ = #cas.display(r3.expr)
- $12^(1/3)$ = #cas.display(r4.expr)

// Test 2: Double-angle
#let sin2x = cas.expr("2*sin(x)*cos(x)")
#let da = cas.simplify(sin2x)
*Double angle:* $2 sin(x) cos(x)$ = #cas.display(da.expr)

// Test 3: Integration
#let i1 = cas.integrate("arctan(x)", "x")
#let i2 = cas.integrate("1/(1+x^2)", "x")
#let i3 = cas.integrate("arcsin(x)", "x")
#let i4 = cas.integrate("ln(x)", "x")
#let i5 = cas.integrate("x*ln(x)", "x")

*Integration:*
- $integral arctan(x) dif x$ = #cas.display(i1.expr)
- $integral 1/(1+x^2) dif x$ = #cas.display(i2.expr)
- $integral arcsin(x) dif x$ = #cas.display(i3.expr)
- $integral ln(x) dif x$ = #cas.display(i4.expr)
- $integral x ln(x) dif x$ = #cas.display(i5.expr)

// Test 4: Transcendental solve
#let s1 = cas.solve("sin(x)", rhs: 0)
#let s2 = cas.solve("exp(x)", rhs: 5)
#let s3 = cas.solve("ln(x)", rhs: 2)

*Transcendental solve:*
- $sin(x)=0$: #cas.roots-of(s1).map(r => [#cas.display(r)]).join(", ")
- $e^x=5$: #cas.roots-of(s2).map(r => [#cas.display(r)]).join(", ")
- $ln(x)=2$: #cas.roots-of(s3).map(r => [#cas.display(r)]).join(", ")
