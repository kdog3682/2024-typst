#let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

#let alternating-white = (white.darken(5%), white.darken(10%))
#let alternating-black = (black.darken(5%), black.darken(10%))

#let _block = block
#let _frac = block
#let _blue = blue
#let _red = red
#let _green = green
#let _black = black
#let _white = white
#let _circle = circle
#let _line = line
#let _text = text
#let _table = table
#let _heading = heading
#let _lorem = lorem
#let _pad = pad
#let _text = text
#let _rect = rect
#let _image = image
#let _figure = figure
#let _h = h
#let _box = box
#let _enum = enum
#let _list = list
#let typst-line = line
#let typst-circle = circle
#let typst-rect = rect

#let is-content(x) = { type(x) == "content" }
#let is-array(x) = { type(x) == "array" }
#let is-nested-array(x) = { type(x) == "array" and type(x.at(0)) == array }
#let is-dict(x) = { type(x) == "dictionary" }
#let is-dictionary(x) = { type(x) == "dictionary" }
#let is-object(x) = { type(x) == "dictionary" }
#let is-integer(x) = { type(x) == "integer" }
#let is-number(x) = { type(x) == "integer" }
#let is-length(x) = { type(x) == "length" }
#let is-function(x) = { type(x) == "function" }
#let is-string(x) = { type(x) == "string" }


#let identity(x) = {
    return x
}

// doc: retrieves the first arg of sink.pos() or fallback
#let get-sink(sink, fallback) = {
    let args = sink.pos()
    return if args.len() == 0 { fallback } else if args.len() == 1 { args.first() } else { args }
}

#let empty(x) = {
    return x == none
}
#let exists(x) = {
  return x != none and x != false
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
#let colored(x, fill: none) = {
  return text(fill: resolve-color(fill), resolve-content(x))
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

#let merge-fresh(a, b) = {
    let store = ()
    for (k, v) in a {
        let value = if k in b { b.at(k) } else { v }
        store.insert(k, value)
    }
    return store
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



#let is-even(n) = {
  return calc.rem(n, 2) == 0
}

#let is-odd(n) = {
  return calc.rem(n, 2) != 0
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
    if is-number(symbol) {
        let spaces = resolve-point(symbol)
        spaces
        x
        spaces
    } else if is-content(symbol) {
        symbol
        x
        symbol
    } else {
        split-twice(symbol).join(x)
    }
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



#let test(s, r) = {
  return exists(s.match(regex(r)))
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

#let is-defined(x) = {
    return x != none
}

#let coerce-content(x) = {
    if not exists(x) {
        return 
    } else if is-content(x) {
        x
    } else {
        text(x)
    }
}


#let coerce-array(x) = {
    if is-array(x) {
        x
    } else {
        (x,)
    }
}


#let assert-array(body) = {
    assert(
        type(body) == array,
        message: "Incorrect type for body: " + repr(type(body)),
    )
}


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

#let assign(a, b) = {
    if has-value(b) {
        for (k, v) in b {
            a.insert(k, v)
        }
    }
    return a
}

#let centered(content) = {
  align(center, content)
}

#let has-children(content) = {
    if is-content(content) {
        return "children" in content.body.fields()
    }
    return false
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

#let str-replace(s, r, rep) = {
  return s.replace(regex(r), rep)
}

#let remove-spaces(s) = {
    return str-replace(s, " +", "")
}


#let templater(s, ref) = {
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
    return str-replace(s, "\$\w+", callback)
}

#let fill(count, symbol) = {
    return range(count).map((i) => symbol)
}


#let match(s, r) = {
    let m = s.match(regex(r))
    if m != none {
        if len(m.captures) > 0 {
            m.captures
        } else {
            m.text
        }
    }
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
            "\\" + s
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


#let redact(text, fill: black, height: 1em) = {
  box(rect(fill: fill, height: height)[#hide(text)])
}

#let bold(x) = {
    return text(weight: "bold", resolve-content(x))
}

#let assert-type(body, kind: none) = {
    let ref = (
        array: list,
        dict: dictionary,
        number: int,
        string: str,
        str: str,
    )
    let a = type(body)
    let b = ref.at(kind)
    if a == b {
        return 
    }

    let args = (b, a)
    let message = templater("require type: $1. instead got: $2.", args)
    panic(message)
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


#let get-shortest(items) = {
    let lowest = 1000
    for item in items {
        let l = item.len()
        if l < lowest {
            lowest = l
        }
    }
    return lowest
}

#let double-quote(s) = {
    if s.starts-with("\"") == true {
        return s
    }
    return "\"" + s + "\""
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

#let reduce(iterable, fn) = {
    if is-object(iterable) {
        iterable = iterable.pairs()
    }
    assert(is-array(iterable.first()))

    let store = (:)
    for item in iterable {
        if item != none {
            let (k, v) = item
            let value = fn(v, k)
            if value != none {
                store.insert(k, value)
            }
        }
    }
    return store
}

#let walk(o, fn) = {
    let runner(o, key: none) = {
        if is-array(o) {
            return o.map(runner.with(key: key))
        } else if is-object(o) {
            let store = (:)
            for (k, v) in o.pairs() {
                let value = runner(v, key: k)
                store.insert(k, value)
            }
            return store
        } else {
            return fn(o, key)
        }
    }
    return runner(o)
}

#let square(size, ..sink) = {
  rect(width: size, height: size, ..sink)
}

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

#let untouchable() = {
    panic("this should never be reached")
}

#let todo(..sink) = {
    panic("todo", get-sink(sink, ""))
}

#let is-last(index, items) = {
    return index == len(items) - 1
}

