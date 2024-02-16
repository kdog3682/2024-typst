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
#let is-nested-array(x) = { type(x) == "array" and type(x.at(0)) == array }
#let is-dict(x) = { type(x) == "dictionary" }
#let is-dictionary(x) = { type(x) == "dictionary" }
#let OPERATOR_PADDING = h(4pt)
#let is-object(x) = { type(x) == "dictionary" }
#let is-integer(x) = { type(x) == "integer" }
#let is-number(x) = { type(x) == "integer" }
#let is-length(x) = { type(x) == "length" }
#let is-function(x) = { type(x) == "function" }
#let is-string(x) = { type(x) == "string" }

#let get-sink(sink, fallback) = {
    let args = sink.pos()
    return if args.len() == 0 { fallback } else if args.len() == 1 { args.first() } else { args }
}

#let map(args, fn) = {
    return args.enumerate().map(((index, arg)) => fn(arg, index, args))
}

#let empty(x) = {
    return x == none
}


#let wrap-math-operator(s, ..sink) = {
    let padding = get-sink(sink, OPERATOR_PADDING)
    padding
    s
    padding
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
  return text(fill: resolve-color(color), resolve-content(x))
}

#let array-to-dict(aa) = {
    let store = (:)
    for (a,b) in aa {
        store.at(a) = b
    }
    return store
}

#let assign-fresh(a, b) = {
    for (k, v) in b {
        if k not in a {
            a.insert(k, v)
        }
    }
    return a
}

#let assign(a, b) = {
    if has-value(b) {
        for (k, v) in b {
            a.insert(k, v)
        }
    }
    return a
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
  align(center, content)
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
  return x * 1pt
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
#let wrap(x, ..sink) = {
    let symbol = get-sink(sink, " ")
    if is-content(symbol) {
        symbol
        x
        symbol
    } else {
        split-twice(symbol).join(x)
    }
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

#let get-match(x) = {
    let length = x.captures.len()
    if length > 1 {
        return x.captures
    }
    else if length == 1 {
        return x.captures.first()
    }
    else {
        return x.text
    }
}

#let backslash(s) = {
    return "\\" + s
}

#let re-wrap(ref, template) = {
    let escapables = (
        "*",
        "(",
        ")",
        "[",
        "]",
        "{",
        "}",
    )

    let escape(s) = {
        return if s in escapables {
            backslash(s)
        } else {
            s
        }
    }

    let s = ref.keys().map(escape).join("|")
    return template.replace("$1", s)
}

#let dreplace(s, ref, template: "(?:$1)") = {
    let replacer(x) = {
        return ref.at(get-match(x))
    }
    let r = re-wrap(ref, template)
    return s.replace(regex(r), replacer)
}

#let transmute-exponents(m) = {
    let store = ()
    let children = m.body.children
    for child in children {
        let fields = child.fields()
        if fields.len() <= 1 {
            store.push(child)
        } else if "denom" in fields {
            store.push(mathup(fields.num.text + "/" + fields.denom.text))
        } else {
            panic(fields)
            store.push(mathup(fields.base.text + "/" + fields.t.text))
        }
    }
    return store.join()

    block0Gsdfsdf(sdfsdf)
    block0Gasd
    blocksfd
    blocksfd
    blocksfd
}

#let redact(text, fill: black, height: 1em) = {
  box(rect(fill: fill, height: height)[#hide(text)])
}

#let align-figure-caption = (it) => layout(size => style(styles => {
    // taken from typst snippet examples
    // 
    let text-size = measure(
      it.supplement + it.separator + it.body,
      styles,
    )

    let alignment = if text-size.width < size.width {
      center
    } else {
      left
    }
    align(alignment, it)

}))

#let dfrac(a, b) = $display(frac(#resolve-content(a), #resolve-content(b)))$


#let coerce-array(x) = {
    if is-array(x) {
        x
    } else {
        (x,)
    }
}



#let identity(x) = {
    return x
}


#let reduce(x, ..sink) = {
    let fn = get-sink(sink, identity)
    let store = (:)
    for item in x {
        if item == none {
            continue
        }
        let (a, b) = item
        let value = fn(b)
        if value == none {
            continue
        }
        store.insert(a, value)
    }
    return store
}

#let walk(x, fn, delete-on-none: true) = {

    let runner(x, key: none) = {
        if is-string(x) {
            return fn(x, key)
        } else if is-number(x) {
            return fn(x, key)
        } else if is-array(x) {
            return x.map((x) => runner(x, key: key))
        } else if is-object(x) {
            let create((k, v)) = {
                let value = runner(v, key: k)
                if value == none and delete-on-none == true {
                    return 
                }
                return (k, value)
            }
            return reduce(x.pairs().map(create))
        }
    }
    return runner(x)
}


#let render-kwargs(kwargs, ref) = {
    let create(v, k) = {
        if k in ref {
            return ref.at(k)(v)
        }
        return str(v)
        // return the item as a string
        // walk only transforms strings and numbers
        // while walking thru objects
    }
    return walk(kwargs, create)
}

#let justify-space-between(arg, i, a) = {
    if i == 0 {
        return align(left, arg)
    }
    else if i == len(a) - 1 {
        return align(right, arg)
    }
    else {
        return align(center, arg)
    }
}

#let justify-ref = (
    space-between: (
        justify: justify-space-between,
        attrs: (
            column-gutter: 1fr
        ),
        container: grid,
    ),

    centered-space-between: (
        justify: justify-space-between,
        attrs: (
            column-gutter: 1fr,
            stroke: none,
            align: horizon,
        ),
        container: table,
    ),
)
#let flex(..sink) = {

    let opts = sink.named()
    let padding = opts.at("padding", default: none)
    // pads the arg inside of fn:prepare
    let debug = opts.at("debug", default: none)
    // draws a red rectangle around the arg
    // uses a block wrapper around the final payload

    let wrapper(value) = {
        let width = opts.at("width", default: none)
        let margin = opts.at("margin", default: 10pt)
        let block-attrs = (:)

        if margin != none {
            block-attrs.insert("above", margin)
            block-attrs.insert("below", margin)
        }
        if width != none {
            block-attrs.insert("width", resolve-pt(width))
        }
        if has-value(block-attrs) {
            return block(..block-attrs, value)
        }
        return value
    }

    let prepare(arg) = {
        if debug != none {
            arg = rect(stroke: red, arg)
        }
        if padding != none {
            arg = pad(padding, arg)
        }
        return arg
    }

    let args = sink.pos().map(prepare)
    let columns = args.len()

    let top-attrs = (
        columns: columns,
    )
    let justify-content = opts.at("justify-content", default: none)
    if justify-content != none {
        let (
            justify,
            container,
            attrs,
        ) = justify-ref.at(justify-content)
        let payload = container(..attrs, ..top-attrs, ..map(args, justify))
        return wrapper(payload)
    }
    // we prepare the args with padding because
    // prose almost always needs padding
    // place all the paddings in one place

    let table-attrs = (
        stroke: (
            paint: black,
            thickness: 0.5pt,
            dash: "dotted",
        ),
        // stroke: none,
        row-gutter: auto,
        rows: auto,
        column-gutter: auto,
        align: auto,
    )
    let block-attrs = (
        below: 0pt,
        above: 0pt,
        fill: yellow.lighten(90%),
        radius: 5pt,
        inset: 5pt,
        width: 400pt, // the width does control it
        height: auto,
        outset: 0pt,
    )
    block(..block-attrs, table(..table-attrs, columns: columns, ..args))
}

#let resolve-dict(ref, key) = {
    if is-object(key) {
        return key
    }
    return ref.at(key, default: none)
}


#let typst-line = line
#let typst-circle = circle
#let typst-rect = rect

// #centered(block(width: 400pt, flex(lorem(100), lorem(15), justify-content: "start")))

#let alphabet = "ABCDEFGHIJKL"
#let bold-numbering-func(it) = [ *#it.* ]
#let bold-numbering-letter-func(it) = [ *#alphabet.at(it - 1).* ]

#let merge-existing(a, b) = {
    let c = (:)
    for (k,v) in a {
        if k in b {
            c.insert(k, b.at(k))
        } else {
            c.insert(k, v)
        }
    }
    return c
}

#let mdg(key, ..sink) = {
    let kwargs = sink.named()
    let fallback = kwargs.at("fallback", default: none)
    let refs = sink.pos()
    for ref in refs {
        if key in ref {
            return ref.at(key)
        }
    }
    return fallback
}

#let colored-text(fill: none, s) = {
  text(fill: fill, resolve-content(s))
}

#let xblue = colored-text.with(fill: blue)
#let xred = colored-text.with(fill: red)
#let xgreen = colored-text.with(fill: green)



#let resolve-inches(x) = {
    let t = type(x)
    if t == length {
        return float(x.inches())
    }
    if t == int or t == float {
        return x
    }
    panic("do not know how to resolve inches for", x)
}

#let assert-array(body) = {
    assert(
        type(body) == array,
        message: "Incorrect type for body: " + repr(type(body)),
    )
}


#let map-names(x) = {
    return x.name
}

#let colon(a, b) = {
    return [*#a:* #b]
}

#let copy(x) = {
    if is-array(x) {
        return x.map(copy)
    }
    if is-object(x) {
        let store = (:)
        for (a, b) in x {
            store.insert(a, copy(b))
        }
    }
    return x
}

#let get-longest(items) = {
    let highest = 0
    for item in items {
        let l = item.len()
        if l > highest {
            highest = l
        }
    }
    return highest
}


#let removeStartingDollars(s) = {
    if s.starts-with("$") == true {
        return s.slice(1, -1) 
    }
    return s
}
#let doubleQuote(s) = {
    if s.starts-with("\"") == true {
        return s
    }
    return "\"" + s + "\""
}

// #panic("$abc".starts-with("$"))
// #panic(mathup("\"asd\" dot x^3"))


#let bigger(c) = {
    return text(size: 1.1em, c)
}

#let xplus() = {
    return wrap(sym.plus, h(3pt))
}


#let sink-attrs(sink, key) = {
    let canvas-attrs = (
        length: 1in
    )
    return sink.named()
}

#let inline-canvas(fn, baseline: -0.15em, ..sink) = {
    import "@preview/cetz:0.2.0"
    let canvas-attrs = sink-attrs(sink, "canvas")
    let c = cetz.canvas(..canvas-attrs, fn(cetz.draw))
    let box-attrs = (
        // stroke: black,
        // inset: 3pt,
        radius: 0pt,
        fill: none,
        outset: 0pt,
        baseline: baseline,
    )
    return box(..box-attrs, c)
}

#let xarrow() = {
    // return wrap(sym.arrow.r.filled, OPERATOR_PADDING)
    let create(draw) = {
        let mark = (
            width: 3,
            length: 3,
            end: ">",
            fill: black,
        )
        let y = 0
        draw.line((0, y), (15, y), mark: mark)
    }

    h(6pt)
    inline-canvas(create, length: 1pt, baseline: -0.15em)
    h(7pt)
}


#let xequal = wrap-math-operator.with([=])
#let xdot = wrap-math-operator.with(sym.circle.filled.tiny)









#let mathup(s, ..sink) = {

    let default-scope = (
      blue: xblue,
      red: xred,
      green: xgreen,
      xdot: xdot,
      xequal: xequal,
      xarrow: xarrow,
    )
    let scope = if sink.pos().len() > 0 { sink.pos().first() } else { default-scope }
    let kwargs = sink.named()
    let ref = (
      "*": " #xdot() ",
      "=": " #xequal() ",
    )

    let expr = dreplace(s, ref)
    assert(test(expr, "^\$") != true, message: "no dollars allowed: " + expr + "\n\noriginal:\n\n" + "[" + s + "]")
    let value = eval(expr, mode: "math", scope: scope)
    let size = kwargs.at("size", default: none)
    if size != none {
        value = text(size: size, value)
    }

    let label = kwargs.at("label", default: none)
    if label != none {
        let labelContent = bold(label)
        return stack(dir: ltr, spacing: 10pt, labelContent, value)
    }
    return value

}

#let resolve-math-content(x) = {
    if is-string(x) {
        x = removeStartingDollars(x)
        return mathup(x)
    }
    return x
}

#let create-icon(name, fill: none, size: 20, key: none, ext: "svg", baseline: 0.85em) = {
    assert(key != none, message: "a key is required to access the correct asset directory")
    let root = "../"
    let url = root + key + "-assets/" + name + "." + ext
    size = resolve-pt(size)
    let attrs = (
      width: size,
      height: size,
    )
    let box-attrs = (
        // stroke: black,
        inset: 3pt,
        radius: 0pt,
        fill: none,
        outset: 0pt,
        // baseline: baseline,
        baseline: 50%,
    )
    return box(..box-attrs, image(url, ..attrs))
    return box(..box-attrs, image(url, ..attrs))
    return image(url, ..attrs)
}

#let emoji-icon = create-icon.with(key: "emoji", ext: "svg", baseline: 2em)

// #let a=[hi guys #emoji-icon("smile") bye guys]
// #let b=rect()
// #table(columns: 2, a, b)
