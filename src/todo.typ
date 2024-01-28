#import "styles.typ" as sx
#import "util.typ" as ux
#let o = (0,0)
#let p34 = (3, 4)
#import "@preview/cetz:0.2.0"
#import cetz.draw as draw
#set text(size: 20pt)

#let block-stack(n) = {
  box({
    cetz.canvas({
      let size = 20pt
      for i in range(-n, n) {
        draw.rect((0, i * size), (size, i * size))
      }
    })
  })
}


#let inline-canvas(content, baseline: 50%) = {
  if type(baseline) == "none" {
    baseline = 0pt
  }
  box(baseline: baseline, inset: (x: 10%), {
    cetz.canvas({
      content
    })
  })
}


#let block-stack2(n, baseline: 50%) = inline-canvas(baseline: baseline, {
    let size = 1
    for i in range(n) {
        let start = (0, i * size)      
        let end = (size, (i + 1) * size)
        draw.rect(start, end, fill: yellow)
    }
})

// $#block-stack2(3) plus #block-stack2(3) = #block-stack2(8, baseline: 18.75%)$ // take the 50% baseline and cut it in half to makae it align
// this works pretty well
//$#block-stack(3) space + space #block-stack(3) space = space #block-stack(6)$

// it takes time  



#let artboard(frames, ..) = cetz.canvas({
  // merge in styles
  // you can parse it ... via a string
  // you can also parse it via html ...
  // to create stringbuilder like shenannigans
  // calculations can be made before hand
  // coordinates
  // styles
  // shortcuts
  // to do everything thru it ... and update
  // collect all the various styles
  // it is an amazing product
})


//#type(json("abc.json").a)
//#artboard(1)

#let block-math(integers) = {
  let store = ()
  for (index, integer) in integers.enumerate() {
    let block = block-stack2(integer, baseline: none)
    store.push(block)
    if ux.is-last(index, integers) {
      let sum = block-stack2(ux.sum(..integers), baseline: none)
      store.push(box(baseline: -50%, $=$))
      store.push(sum)
    } else {
      store.push(box(baseline: -50%, $+$))
    }
  }
  return store
}

#block-math((1,1,3)).join(" ")



/*
#import "@preview/cetz:0.2.0"


#let margin = 0.5in
#set page(margin: 0.5in, paper: "us-letter")

#{
  cetz.canvas({
    import cetz.draw: *
    import cetz.chart
    let coordinates = ((0,0), (5,5))
    // line((0,0), (1,1), stroke: red)
    //cetz.decorations.flat-brace((0,0),(2,2), stroke: red, curves: 30)
    //grid(..coordinates)
    line((0,0), (0,3), name: "a")
line((0,0), (2,0), name: "b")
// Draw an angle between the two lines
cetz.angle.right-angle("a.start", "a.end", "b.end",
radius: 1)
let data = (("A", 10), ("B", 200), ("C", 13))
group(name: "a", {
  let style = (
axes: (
tick: (length: 3),
grid: (stroke: (dash: "dotted")),
),
bar-width: 2,
x-inset: 1,
)
  set-style(..style)
chart.columnchart(ticks: 100, bar-width: 20,size: (3, 6), data, bar-style: cetz.palette.gray(70), )
})
  })
}

#let square(size, fill) = {
  rect(width: size, height: size, fill: fill)
}
#{

  let width = 20pt
  let green-square = square(width, green)
  place(dx: -0.5in, dy: -0.5in, green-square)
  layout(x => {
    place(dx: x.width + margin - width, dy: -margin, green-square)
  })

  let b = [aaa]
  rect(width: 256pt, height: auto, fill: yellow.lighten(60%))
}
*/
