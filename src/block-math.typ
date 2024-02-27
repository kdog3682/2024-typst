#import "base-utils.typ": *



#let eq(s, spacing: 0) = {
    return box(baseline: -50%, equation(s))
}

#let parser(s) = {
    let get-type(x) = {
        return if x == " " {
            none
        } else if test(x, "\d") {
            "number"
        } else if test(x, "[+-/*]") {
            "operator"
        } else if test(x, "[()]") {
            "paren"
        } else {
            "variable"
        }
    }

    let runner(x) = {
        return (type: get-type(x), value: x)
    }
    return split-singles(remove-spaces(s)).map(runner)
}
#let block-arithmetic(s) = {
    let parts = parser(s)
    let block-type = "circle"

    // you can have paddings and arrays
    // you can have circles
    // you can have triangles
    // id do the parsing in javascript
    // typst should be for layout

    for part in parts {
        if part.type == "integer" {
            block-stack(part.value)
        }
        else if part.type == "paren" {
            eq(part.value)
        }
        else if part.type == "operator" {
            eq(part.value, spacing: 1)
        }

        else if part.type == "variable" {
            block-stack(part.value)
        }
    }
}

#let block-sum(..args) = {
  let (integers, attrs) = handle-args(args, base: "block-sum")
  let store = ()
  for (index, integer) in integers.enumerate() {
    let block = block-stack(integer)
    store.push(block)

    if is-last(index, integers) {
      let sum = block-answer(integers, "sum")
      store.push(eq("="))
      store.push(sum)
    } else {
      store.push(eq("+"))
    }
  }
  return store
}

#block-math((1,1,3)).join(" ")


#panic(parser("1 + 2"))
// handle-args is a way of doing something ...
