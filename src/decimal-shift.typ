#import "base-utils.typ": *

#let a = 3
#let b = 5
#let total = a + b
#let base = "5.835"

$#base times 10^#a times 10^#b = #base$

#let shifter(a) = [
    $10^#a$ means shift the decimal right #a times: #fill(sym.arrow.r, a)
]

#shifter(a)

#shifter(b)

That's a total of #total shifts.

#let decimal-shift(s, direction: "right") = {
      if direction == "right" {
          let next = str-replace(s, "\.(\d)", (x) => x.text.rev())
          if next == s {
              return str-replace(s, "\.", "0.")
          } else {
              return next
          }
      } else {
          let next = str-replace(s, "(\d)\.", (x) => x.text.rev())
          if test(next, "^\.") {
              return "0" + next
          } else if next == s {
          } else {
              return next
          }
      }
}
#{
  let store = ()
  let original = base
  let next = base
  let k = -1
  let direction = "left"
  for n in step(total) {
      let shift = bold(ordinal(n))
      let math = mathdown("#original times 10^#{k * n}", k: k, original: original, base: base, n: n)
      let next = decimal-shift(next, direction: direction)
      base = next
      store.push(shift)
      store.push(math)
      store.push(next)
  }
  table(columns: 3, ..store)
}

For dividing by 10, the exact opposite will happen. 
The number will get smaller, and the decimal will shift to the left.
