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
