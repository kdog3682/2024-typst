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
#let is-dictionary(x) = { type(x) == "dictionary" }
#let is-object(x) = { type(x) == "dictionary" }
#let is-integer(x) = { type(x) == "integer" }
#let is-number(x) = { type(x) == "integer" }
#let is-length(x) = { type(x) == "length" }
#let is-function(x) = { type(x) == "function" }
#let is-string(x) = { type(x) == "string" }

#let empty(x) = {
    return x == none
}
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
    if x == none {
        return 
    }
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
  let first = items.first()
  if is-dict(first) {
    return merge-dictionary(..items)
  }
  if is-array(first) {
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


#let get-sink(sink, fallback) = {
    let args = sink.pos()
    return if args.len() == 0 { fallback } else if args.len() == 1 { args.first() } else { args }
}

#let markup(..sink) = {
    let s = sink.pos().first()

    // panic(s, scope)
    let scope = sink.named().at("scope", default: (:))
    let b = eval(s, mode: "markup", scope: scope)
    return b
}

#let fill(count, symbol) = {
    return range(count).map((i) => symbol)
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


#let flex(..sink) = {
    // layout-util
    let args = sink.pos()
    let flat(arg) = {
        if is-array(arg) {
            arg.join()
        } else {
            arg
        }
    }
    let flattened = args.map(flat)
    let length = len(flattened)
    let aligner(col, row) = {
        if col == 0 {
            left  + horizon
        } else if col == length - 1 {
            right + horizon
        } else {
            center + horizon
        }
    }
    let spacer = h(0.5fr)
    let spacer = h(1fr)
    return table(columns: (1fr,) * flattened.len(), align: aligner, stroke: none, ..flattened)
    return flattened.join(spacer)
}


#let create-icon-factory(dir, ext: "png") = {
    // factory-util

    let create-icon(key, ..sink) = {
        let kwargs = sink.named()
        let url = dir + str(key) + "." + ext
        let size = kwargs.at("size", default: 20)
        let el = image(url)
        if empty(el) {
            panic(url)
        }
        return box(width: size * 1pt, height: size * 1pt, el)
    }
    return create-icon
}


#let title(s, style: "buc", before: 1, after: 5) = {
    let text-attrs = (
      weight: "bold",
      size: 18pt,
    )
    align(text(..text-attrs, s), center + horizon)
    v(before * 1pt)
    line(length: 100%)
    v(after * 1pt)
}
#let sm-text(s, size: 8) = {
    return text(size: size * 1pt, resolve-content(s))
}

#let md-text(s, size: 16) = {
    return text(size: size * 1pt, resolve-content(s))
}


#let dialogue-layout(items) = {
  // layout
  let store = ()
  for (index, item) in items.enumerate() {
    // let speaker = get-speaker(index)
    store.push(sm-text(bold(item.speaker), size: 10))
    store.push(item.content)
  }

  let attrs = (
      columns: (auto, 1fr),
      column-gutter: 20pt,
      row-gutter: 40pt,
  )
  grid(..attrs, ..store)
}


#let has(x, y) = {
    return y in x
}


#let tail(file) = {
    return file.split("/").last()
}
#let add-extension(file, ext) = {
    if test(file, "\.\w+$") {
        file
    } else {
        file + "." + ext
    }
}
#let npath(dir, name) = {
    return dir.replace(regex("/$"), "") + "/" + tail(name)
}
#let readjson(..sink) = {
    let name = get-sink(sink, "clip.json")
    let file = npath("/home/kdog3682/2024/", add-extension(name, "json"))
    return json(file)
}
#let is-defined(x) = {
    return x != none
}

#let spacer(n) = {
    return v(n * 1pt)
}
