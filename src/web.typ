// stroke: black, fill: white, radius: 5pt, 
nnoremap <buffer> mf :call TypstShuntController()<CR>
nnoremap <buffer> mv :call TypstMove()<CR>
inoreab <buffer> <silent> <expr> r SmartReturn()
#set page(width: 300pt, height: auto)

#let is-content(x) = { type(x) == "content" }
#let is-array(x) = { type(x) == "array" }
#let is-dict(x) = { type(x) == "dictionary" }
#let is-integer(x) = { type(x) == "integer" }
#let is-length(x) = { type(x) == "length" }
#let is-function(x) = { type(x) == "function" }
#let is-string(x) = { type(x) == "string" }
// content array dict integer length
  

#let resolve-text(x) = {
  if is-string(x) {
    return x
  }
  return x.text
}
#let resolve-content(x) = {
  if is-content(x) {
      return x
  }
  return str(x)
}
#{

  let enumerate(arr) = {
    let f = (i) => i + 1
    let indexes = range(arr.len()).map(f)
    return indexes
  }
  let len(x) = {
    return x.len()
  }
  let table_index_helper(a, ..formatter) = {
    let fn = formatter.pos().first()
    let store = ()
    for i in range(len(a)) {
      store.push(fn([#(i + 1)]))
      store.push(a.at(i))
    }
    return store
  }
  let bold(x) = {
    return [*#resolve-content(x)*]
  }
  
  let sum(..numbers) = {
    let c = 1
    for n in numbers.pos() {
      c += n
    }
    return c
  }
  let mult(..numbers) = {
    let c = 1
    for n in numbers.pos() {
      c *= n
    }
    return c
  }
  let foo(content) = {
    set text(fill: blue)
    content
  }
  let redd(content, color) = {
    set text(fill: color)
    content
  }
  let numbers = range(2, 6, step: 1)
  let items = numbers.map((n) => {
    let k = 2
    let twos = range(1, n + 1)
    let expr = twos.map(str).join(" times ")
    let value = mult(..twos)
    let aaa = foo(eval(expr, mode: "math"))
    return [
      #aaa  
      $=$
      *#value*
    ]
    // let bbb = eval(expr, mode: "code")
  })

  let pooba(color: red) = {
    show regex("="): set text(fill: color)
  }
  
  pooba()
  // is there a way to programatically 
  // show regex("\d"): set text(fill: red)


  {
    show regex("="): set text(fill: red)
    for item in items {
      item
      parbreak()
    }
  }

  line(length: 100pt)
  let formatter(content) = {
    show regex("item"): set text(fill: blue)
    [item *#text(content, fill: red)*]
  }
  let args = table_index_helper(items, formatter)
  table(columns: 2, inset: 10pt, ..args)
  
  /*
  [
    $2 times 2= 4$
    hi \
    lets go to the store
  ]
  */
  /*
  for n in numbers {
    [
      #n is the answer to: *$x^#n$*
    
    ]
    it is more 
  }
  */

}


/*
  // cool demonstration of embedded maths
  let prev_x = 3
  for n in range(10) {
    let x = 2 - 1 / prev_x
    $x_#n = 2 - 1 / x_#(n - 1) = #x$
    parbreak()
    prev_x = x
  }

*/



#let format(body) = {
  let (mant, expon) = body.split("e")
  [ $#mant times 10 ^ #expon$ ]
}

#show regex("\\b[\\-]?\\d+(\\.\\d+)?e[\\-]?\\d+\\b"): it => format(it.text)

Hello 4.32e5, test 3e-12.
-4e43 is a Number: 0e0 and 1e-1...

#set enum(numbering: "I.A.1.")
+ arrowheads
  + arrowheads
  + arrowheads
    + arrowheads
+ arrowheads




// page numbering

#set page(footer: locate(loc => {
  // left and right
  let alignment = if calc.odd(counter(page).at(loc).last()) {
    left
  } else {
    right
  }
  align(alignment, counter(page).display())
}))

#set page(height: 2in)
#lorem(100)
#pagebreak()
#lorem(100)

// labelling grids

// We use `rect` to emphasize the
// area of cells.
#set rect(
  inset: 8pt,
  fill: rgb("e4e5ea"),
  width: 100%,
)

#grid(
  columns: (60pt, 1fr, 2fr),
  rows: (auto, 60pt),
  gutter: 3pt,
  rect[Fixed width, auto height],
  rect[1/3 of the remains],
  rect[2/3 of the remains],
  rect(height: 100%)[Fixed height],
  [#figure(
    image("tiger.jpg", height: 100%),
    caption: "Tiger1",
  ) <Tiger1>],
  [#figure(
    image("tiger.jpg", height: 100%),
    caption: "Tiger2",
  ) <Tiger2>]
)


// cetz riemann

#import "@preview/cetz:0.1.2": *


#align(center)[#canvas(length: 0.4in, {
  // Function
  let f = x => 16 - x * x

  // Plot
  plot.plot(size: (6, 6),
    x-grid: true,
    y-grid: true,
    x-tick-step: 1,
    y-tick-step: 4,
    {
      plot.add(
        domain: (0, 6),
        x => f(x))
    }
  )

  // Left-hand Riemann sum
  let barColor = color.green
  let fixedOffset = 3.34
  for i in (0, 1, 2, 3, 4, 5) {
    let height = f(i)
    if (f(i) < 0) {
      barColor = color.red
    }
    // draw.fill(barColor.lighten(70%).darken(8%))




    draw.fill(rgb(barColor.lighten(70%).darken(8%).to-hex() + "66"))
    draw.stroke(barColor.darken(30%))
    draw.rect(
      (i, fixedOffset),
      (i + 1, (height / 6) + fixedOffset),
    )
  }
})]


// notes:
// usefuls

#set list(marker: ([•], [--]))

// today


#set page(width: 300pt, height: 300pt, background: rect(fill: white, width: 100%, height: 100%))

#let text-frac(top, bottom) = style(styles => {
  let a = align(left)[#top]
    let b = [#bottom]

    let items = (a, b)
    let lengths = items.map(el => measure(el, styles).width)
    let box-width = calc.max(..lengths)
    let el = stack(items.first(), line(length: box-width), items.last(), spacing: 4pt) //ext
    let a = box(align(center, el))
    return a
    a
})

#let username-and-icon(name) = {
  let image = rect(height: 20pt)
  let pic = box(baseline: 50% - 1em, image)
  let pic = "HI"
  let val = box([#name #pic])
  return val
}

#let four-corners(..args) = {

  let corners = (
    top + left, top + right, bottom + left, bottom + right
  )
  set text(weight: "bold")
  set box(stroke: 2pt)
  let Corners = corners.enumerate().map(((i, corner)) => {
    let arg = str(args.pos().at(i))
      let white = white
      return place(corner, box(inset: 5pt, clip: true, outset: 0pt, width: 20pt, height: 20pt, stroke: white, fill: blue, align(center + horizon, text(fill: white, arg))))
      // it may surpass the alotted length
  })
  let CornerContent = Corners.at(0)
  let base = block.with(height: 60pt, width: 60pt, fill: none, stroke: black)
  let ranger(items) = { //name: display-array
    for item in items {
      item
    }
  }
  base(ranger(Corners))

}
#{
  // text-frac([*aaa*], [bbbbbbbb])
  let a = username-and-icon("sam")

  let base2 = block.with(height: 100%, width: 50%, fill: yellow, stroke: black)
  base2()[

    #place(top + right, four-corners(1,2,3,4))
  ]
}


// today

#set page(

#let hash-tags(tags) = {
  let tag(key) = {
    let content = align(text(size: 0.6em, fill: color, weight: "bold", key))
    rect(styles.tag, content)
  }
  let content = tags.map(tag)
  stack(dir: ltr, spacing: 5pt, ..content)
}
#let title(s) = {
  let left = box(fill: none)[
    #heading(s)
  ]
  // let right = tags(("percentages", "fiibar"))
  // stack(dir: ltr, left, right)
  left
  line(length: 100%)
}
#title("Dumplings")

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

HaoXiang makes 14 dumpings. If Alvin makes 50% more than HaoXiang, how many dumplings do they make together?

_50% more than hx_

#let centered(content) = {
  align(center + horizon, content)
}
#let small-black-circle(_, radius: 3pt) = {
  circle(radius: radius, fill: black)
}

#let merge-dictionary(a, b, overwrite: true) = {
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

#let get-type(x) = {
  return type(x)
}
#let merge(..args) = {
  let items = args.pos()
  let t = get-type(items.at(0))
  if t == "dictionary" {
    return merge-dictionary(..items)
  }
}
#let flex-item(..args) = {
  let opts = args.named()
  let base-opts = (gap: 7pt)
  let (gap,) = merge(base-opts, opts)
  let items = args.pos()
  let stroke = 0.3pt
  let stroke = 0.3pt
  let align = center + horizon
  let align=auto
   table(column-gutter: gap, columns: items.len(), stroke: stroke, align: align, inset: 0pt, ..items)
}

#let dialogue-item(speaker, c) = {
  let Speaker = text(weight: "bold", speaker)
  let inset = (x: 0pt, top: 0pt, bottom: 10pt)
  let Content = box(inset: inset, align(left, c))
  // padding for the content
  flex-item(Speaker, Content)
  
}
#let dialogue-table(..args) = {
  let opts = args.named()
  let base-opts = (gap: 7pt)
  let (gap,) = merge(base-opts, opts)
  let items = args.pos()
  let stroke = 0.3pt
  let stroke = 0.3pt
  let align = center + horizon
  let align=auto

  let mapper((a,b)) = {
    let Speaker = text(weight: "bold", a)
    let inset = (x: 0pt, top: 0pt, bottom: 10pt)
    let Content = b
    return (Speaker, Content)
    // let Content = box(inset: inset, align(alignment.left, b))
  }
  let contents = items.map(mapper).flatten()
  
   // grid(row-gutter: 30pt, column-gutter: gap, columns: 2, ..contents)
   table(row-gutter: 10pt, column-gutter: gap, columns: 2, stroke: stroke, align: align, inset: 0pt, ..contents)
}
#let bob-content-1 = [
  howdy

  bye
]
#{
  let numbers = step(14)
  let circles = numbers.map(small-black-circle)
  let bob-content-0 = "aaa\nbbbsdfsdfsdfsd"
  box(inset: 10pt, fill: yellow.lighten(90%), grid(gutter: 5pt, columns: 7, ..circles))
  let item1 = ("sam", bob-content-1)
  dialogue-table(item1, item1)
}

a way to move across pages




foo asd




#{
  let replace(s, r, rep) = {
    return s.replace(regex(r), rep)
  }
  let exists(x) = {
    return x != none
  }
  let test(s, r) = {
    return exists(s.match(regex(r)))
  }
  let is-str-number(x) = {
    return test(x, "^\d+$")
  }

  let templater(s, ref) = {
    let callback(x) = {
      let key = x.captures.first()
      if is-array(ref) {
        return str(ref.at(key))
      } else {
        return str(ref.at(key))
      }
    }
    return replace(s, "\$(\w+)", callback)
  }
  let ref = ("1": 123, "2": 123)
  repr(templater("$1 $2", ref))
}
