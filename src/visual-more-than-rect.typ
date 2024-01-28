#import "base-utils.typ": *


#let get(x) = {
    let ref = (
      "*": sym.times,
      "times": sym.times,
      "+": sym.plus,
      "plus": sym.plus,
    )
    return ref.at(x, default: x)
}

#let attrs = (
    width: 100pt,
)
#let table-attrs = (
    columns: 5,
    gutter: 5pt,
    stroke: none,
    inset: 0pt,
)

#let visual-more-than-rect() = {
    // this has to happen in the context of cetz.
    let hb = k * h1
    let ha = h1 - hb

    let a = rect(p.origin, (size, h1), ..d1)
    let a-stroked = rect((0, ha), (size, h1), ..d2)
    let b = rect((gap, 0), (gap + size, h2), ..d3)
    let b-stroked = rect((gap, h2), (gap + size, h2 + hb), ..d4)


    arrow
    c-arrow
    a
    b
    a-stroked
    b-stroked
}


// inoreab ls (it) => {
    // $c
// }

#let booga(a, n, delimiter, ending: none, equals: none) = {
    // takes a numeric term and repeats it n times
    // joining it with the delimiter provided

    let delimiter = get(delimiter)
    let val = str(a)
    let s = ""
    for i in range(n) {
        s += val
        if i == n - 1 {
            let value = if delimiter == sym.plus { a * n } else { calc.pow(a, n) }
            return if exists(ending) {
                s + templater(ending, value)
            } else if exists(equals) {
                s + " = " + str(value)
            } else {
                s
            }
        } else {
           s += " " + delimiter + " "
        }
    }
}


#let interweave(a, n, delimiter, equals: none) = {
    // takes a numeric term and repeats it n times
    // joining it with the delimiter provided

    let delimiter = get(delimiter)
    let base = (($#a$,) * n).join($space #delimiter space$)

    if equals != none {
        let value = if delimiter == sym.plus { a * n } else { calc.pow(a, n) }
        let ending = if is-string(equals) {
            markup(templater(" " + equals.trim(), value))
        } else {
            equals(value)
        }
        return base + ending
    }
    return base
}

#let to-number(x) = {
    return int(x)
}

#let content-templater(template, ..sink) = {
    let ref = sink.named()
    let items = split(template, "\s+")
    let runner(part) = {
        if test(part, "^\$") {
            let value = ref.at(part.slice(1))
            return if is-function(value) {
                value()
            } else {
                value
            }
        } else {
            return text(part)
        }
    }
    let parsed = items.map(runner)
    return parsed.join(" ")
}



#let ExponentGenerator(..a) = {

    let args = a.pos()
    let numbers = if args.len() == 2 {
        args
    } else {
        split(args.first(), "\^")
    }
    let (base, power) = numbers.map(to-number)

    let expand() = {
        return interweave(base, power, "times")
    }
    let value() = {
        return text(str(calc.pow(base, power)))
    }

    let expr() = {
        return [$#base^#power$]
    }

    let state = (
      expand: expand,
      equals: $space = space$,
      value: value,
      expr: expr,
    )

    let templater = content-templater.with(..state)
    state.insert("templater", templater)
    let definition() = {
        return templater("$expr means $expand")
    }
    state.insert("definition", definition)
    return templater
    return state
}

#{
  // let templater = ExponentGenerator(3, 4)

  // let boxy = (..items) => box(..attrs, table(..table-attrs, ..items))
  // let small-box = (content) => box(
      // width: 80pt,
      // text(size: 6pt, content)
  // )
}


#let boxed-interweave(a, b, c, equals: none) = {
  let small-box = (content) => box(
      width: b * 3pt,
      baseline: 100%,
      par(justify: true, text(size: 7pt, content))
  )
  return small-box(interweave(a, b, c, equals: equals))
}
// #boxed-interweave(2, 70, "+", equals: "\= *$1*?")

// #block(width: 200pt, fill: yellow)[
// how did you do that so fast? did you do #booga(2, 140, "+", equals: true)?
// 
// no. i did $2 times 70$.
// 
// wow kaylee.
// 
// i know. im smart
// ]


#let first = {
  for i in step(4) {
      let base = ExponentGenerator(10, i)
      let a = base("$expr $equals $expand")
      a
      linebreak()
  }
}

#let second = include("decimal-shift.typ")

#let second = eval(read("decimal-shift.typ"), mode: "markup")

#table(first, second)

the space and stuff will be handled explicitly
what does and doesnt define a content block is so interesting
one of the most interesting languages i have ever used

