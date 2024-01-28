#import "styles.typ" as sx
#import "util.typ" as ux
#let o = (0,0)
#let p34 = (3, 4)
#import "@preview/cetz:0.2.0"
#import cetz.draw as draw
#set text(size: 20pt)

// early childhood math
// 
// Instructions
// Cards are marked as show or answer
// a show card means 
// visual overload needs to be avoided
// 
#let inline-canvas(content, baseline: 50%) = {
  // why do we have this inset?
  // one item a month for yijie ...
  // paper products 

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

