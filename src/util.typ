#import "styles.typ"
#import "regexes.typ"

#let style-text(x, key) = {
  let style = styles.at(key)
  return text(..style, resolve-content(x))
}


#let sum(..args) = {
  let c = 1
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


#let is-str-number(x) = {
  return test(x, "^\d+$")
}


#let test(s, r) = {
  return exists(s.match(regex(r)))
}


#let exists(x) = {
  return x != none
}


#let replace(s, r, rep) = {
  return s.replace(regex(r), rep)
}


#let templater(s, ref) = {
  let callback(x) = {
    let key = x.captures.first()
    let k = if is-array(ref) { int(key) } else { key }
    return str(ref.at(k))
  }
  return replace(s, "\$(\w+)", callback)
}


#let split(s, r) = {
  return s.split(regex(r)).map(trim).filter(exists)
}

#let dash-split(s) = {
  return split(s, regexes.dashed-line)
}

#let content-templater(s, ref) = {
  let items = split(s, "\$(\w+)")
  let store = ()
  let get(item, ref) = {
    return ref.at(item)
  }
  for (i, item) in items.enumerate() {
      if is-even(i) {
          if exists(item) {
              store.push(i)
          }
      } else {
          store.push(get(item, ref))
      }
  }
  return store
}



#let cr-flex-row(..args) = {
  let items = args.pos()
  let opts = args.named()
  let style = merge(styles.flex-row-layout, opts)
  table(..style, columns: items.len(), ..items)
}

#let cr-dialogue-item(speaker, content) = {
  let a = bold(speaker)
  let b = box(styles.dialogue-right, align(left, content))
  cr-flex-row(a, b)
}

#let cr-hash-tags(tags) = {
  let tag(key) = {
    let content = align(text(..styles.hash-tag-text, key))
    rect(..styles.hash-tag-rect, content)
  }
  let content = tags.map(tag)
  stack(dir: ltr, spacing: styles.hash-tag-spacing, ..content)
}

#let nth(s, sup: bool) = {
  let ordinal-str = resolve-str(s)
  let ordinal-suffix = if ordinal-str.ends-with(regex("1[0-9]")) {
    "th"
  } else if ordinal-str.last() == "1" {
    "st"
  } else if ordinal-str.last() == "2" {
    "nd"
  } else if ordinal-str.last() == "3" {
    "rd"
  } else {
    "th"
  }

  if sup == true {
    return ordinal-str + super(ordinal-suffix)
  } else {
    return ordinal-str + ordinal-suffix
  }
}

#set page(..styles.auto-page)



#let do-abc(title, data) = {
  // important to not place the item yet
  // because we may want to wrap it later
  // everything in the ref should not immediately place
  let t = [*#title*]
  let items = data.map(contentify)
  // doing this will place the items ... and i am not sure it is a good idea
  t
  items
  // this will place it
}


#let recursive-renderer(state) = {
  let functions = (
    abc: do-abc
  )
  let main(state) = {
    // this is a piece of content
    // everything that main returns should be content

    if state.mode == "eval" {
        // state.value should always be a string
        return eval(state.value, mode: "markup")
    }

    if state.mode == "function" {
        // state.value can be nearly anything
        return functions.at(state.fn-key, state.value)
    }
  }

  let runner(state) = {
    if has(state, 'children') {
       let children = state.children.map(runner)
       if has(state, 'style') {
           return state.wrap(..children)
       }
       if has(state, 'wrap') {
           return state.wrap(..children)
       }
    } else {
        let child = main(state)
        return child

    }
    return main-item
  }

  return runner(state)
}



#let render-dialogue(dialogue) = {
    for item in dialogue {
        
    }
}

#let render-frontmatter(conf) = {
    display-title(conf)
}
#let display-title(s) = {
    text(
        size: 16pt,
        weight: "bold",
    s)
    line(length: 100%, do)
}


#{


#let numbered-wrapper(content, itemnumber, style: 'default') = {
    itemnumber
    content
}

#let render-dialogue-question(lines) = {
    let text-style = (:)

    let visual-key = lines.first().at('visual')
    if visual-key {
        return stack(
          dir: ltr,
          spacing: 2pt
        )
    }

    // so this line has a comment
    // so the next line automatically gets highlighting on enter
    // 
    
    visual = global-visuals.at(visual-key)

    par(leading: 0.75)
    for line in lines {
        text(..text-style, line.text)
        linebreak()
    }
}

#let spacer(..args) = {
    let x = args.pos().first()
    return v(eval(str(x) + "pt"))
}

// rendering via ... need to get the styles
// 
#let render-choices-deprecated(choices) = {
    let store = ()
    let runner(index, choice) = {
        let s = resolve-text(choice)
        let a = text(weight: "bold", index)
        let b = text(s)
        store.push(a)
        store.push(b)
    }
    choices.enumerate().map(runner)
    let attrs = (columns: 2, column-gutter: 5pt, stroke: none)
    return table(..attrs ..store)
}

let enum-mcq-choices = (
    number-align: left,
    numbering: "A)",
    tight: false,
)

#let render-choices(choices) = {
    return enum(styles.enum-mcq-choices, ..choices)
}


#let render-mcq(o) = {
    let question = render-dialogue-question(o.question)
    let enum-choice = render-choices(o.choices)

    return block(
      question,
      choice-block
    )
}

#let eval-as-markup(s, scope: (:)) = {
    return eval(s, mode: "markup", scope)
}

#let square(size, fill) = {
  size = resolve-pt(size)
  rect(width: size, height: size, fill: resolve-color(fill))
}
