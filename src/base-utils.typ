// documentation
// 
// various useful helpers
// does not implement any builders
// - doesnt implement stroke-builder
// 
// does not implement complicated layout
// - doesnt implement boxy-align
// 
// this file is only for simple util  helpers
// 


#let is-content(x) = { type(x) == "content" }
#let is-array(x) = { type(x) == "array" }
#let is-dict(x) = { type(x) == "dictionary" }
#let is-object(x) = { type(x) == "dictionary" }
#let is-integer(x) = { type(x) == "integer" }
#let is-number(x) = { type(x) == "integer" }
#let is-length(x) = { type(x) == "length" }
#let is-function(x) = { type(x) == "function" }
#let is-string(x) = { type(x) == "string" }

#let debugger(x) = {
    repr(type(x))
}

#let exists(x) = {
  return x != none
}

#let trim(x) = {
    return x.trim()
}
#let has-value(x) = {
    return x != none and x.len() > 0
}
#let split(s, r) = {
  return s.split(regex(r)).map(trim).filter(has-value)
}

#let len(s) = {
    return s.len()
}
#let colored(x, color) = {
  return text(fill: resolve-color(color), resolve-text(x))
}

#let array-to-dict(aa) = {
    let store = (:)
    for (a,b) in aa {
        store.at(a) = b
    }
    return store
}

#let bold(x) = {
    let content = if is-content(x) {x} else { str(x) }
    return text(weight: "bold", content)
}

#let boxify(size: 10, fill: yellow, content) = {
    // centers a content inside of a box
    // boxes are by default inline
    let size = resolve-pt(size)
    return box(
        width: size, 
        height: size, 
        radius: 50%,
        fill: fill,
        stroke: stroke-builder("1pt solid black"),
        centered(resolve-content(content))
    )
}


#let centered(content) = {
  align(center + horizon, content)
}


#let resolve-str(x) = {
  if is-string(x) {
    return x
  }
  return str(x)
}

#let resolve-text(x) = {
  if is-string(x) {
    return x
  }
  if is-content(x) {
    return x
  }
  if is-object(x) {
      return x.text
  }
  return str(x)
}

#let resolve-pt(x) = {
  if is-length(x) {
     return x
  }
  return x * pt
}

#let resolve-content(x) = {
  if is-content(x) {
      return x
  }
  return text(str(x))
}



#let merge(..args) = {

    let merge-array(..items) = {
      return items.flatten()
    }

    let merge-dictionary(a, b, overwrite: true) = {
      if type(a) == dictionary and type(b) == dictionary {
        let c = a
        for (k, v) in b {
          if not k in c {
            c.insert(k, v)
          } else {
            c.at(k) = merge-dictionary(a.at(k), v, overwrite: overwrite)
          }
        }
        return c
      } else {
        return if overwrite {b} else {a}
      }
    }

  let items = args.pos()
  let t = type(items.at(0))
  if is-dictionary(t) {
    return merge-dictionary(..items)
  }
  if is-array(t) {
    return merge-array(..items)
  }
}


#let is-even(n) = {
  return calc.rem(n, 2) == 0
}

#let is-odd(n) = {
  return calc.rem(n, 2) != 0
}

#let step(..args) = {
  let a = args.pos()
  let start = 1
  let end = a.at(0)
  let step = 1
  let arg-length = a.len()
  if arg-length == 2 {
    start = a.at(0)
    end = a.at(1)
  }
  else if arg-length == 3 {
    start = a.at(0)
    end = a.at(1)
    step = a.at(2)
  }
  return range(start, end + 1, step: step)
}

#let split-twice(s) = {
    let len = s.len()
    if len == 1 {
        return (s, s)
    }
    else if is-odd(len) {
        panic("cant be odd len")
    }
    else {
        let halfway-point = int(len / 2)
        let a = s.slice(0, halfway-point)
        let b = s.slice(halfway-point)
        return (a, b)
    }
}
#let wrap(x, symbol: " ") = {
  return split-twice(symbol).join(x)
}

#let is-last(x, ref) = {
    if not is-number(x) {
        x = x.index
    }
    if is-number(ref) {
        return x == ref
    }

    if is-object(ref) {
        return x == ref
    }

    if is-array(ref) {
        return x == len(ref) - 1
    }
}


#let sum(..args) = {
  let c = 0
  for n in args.pos() {
    c += n
  }
  return c
}


#let multiply(..args) = {
  let c = 1
  for n in args.pos() {
    c *= n
  }
  return c
}

#let resolve-color(color) = {
    let colors = (:)
    return if is-string(color) { colors.at(color, default: green) } else { color }
}

#let split-singles(s) = {
    let store = ()
    for letter in s {
        store.push(letter)
    }
    return store
}
#let fooga(s) = {
    panic(split-singles(s))
}

#let remove-spaces(s) = {
    return str-replace(s, " +", "")
}

#let str-replace(s, r, rep) = {
  return s.replace(regex(r), rep)
}

#let handle-args(a, base: "") = {
    let kwargs = a.named()
    let args = a.pos()
    let master-attrs = {}
    let attrs = merge(kwargs, master-attrs.at(base, default: (:)))
    return (args, attrs)
}

#let test(s, r) = {
  return exists(s.match(regex(r)))
}

#let templater(s, ref, mode: "prose") = {
    let callback(s) = {
        let key = s.text.slice(1)
        if is-string(ref) or is-number(ref) {
            return str(ref)
        }
        return if test(key, "^\d") {
            ref.at(int(key) - 1)
        } else {
            ref.at(key)
        }


    }
    let value =  str-replace(s, "\$\w+", callback)
    return if mode == "math" { eval(value, mode: mode) } else { value }
}


#let markup(s) = {
    return eval(s, mode: "markup")
}

#let fill(symbol, count) = {
    let items = range(count).map((i) => symbol)
    return items.join("  ")
    let grid-attrs = (
      
    )
    return grid(..grid-attrs, items)
}


#let reverse(x) = {
    if is-string(x) {
        return x.rev()
    }
    return x.rev()
    panic("not done yet")
}



#let ordinal(n) = {
    return str(n)
}

#let mathdown(s, ..sink) = {
    let scope = sink.named()
    return eval(s, mode: "math", scope: scope)
}
