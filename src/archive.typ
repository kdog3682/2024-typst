
---------------------------------------------------------------
// a cool way of drawing triangles
// a curved arrow

#inline-canvas({
  import cetz.draw: *
  let curved-arrow(a, b) = {
    let c1x = calc.abs(a.at(0) - b.at(0)) / 2
    let c1y = a.at(1) - 1
    let c1 = (c1x, c1y)
    let c2 = b
    let c = c1
    let d1y = a.at(1) - 1
    let d = (d1y, c1x)
  bezier(a, b, c, d, mark: (end: ">", fill: black))
  }
  grid((-2,-2), (2,2), stroke: (thickness: 0.05pt))
  //curved-arrow((-2,2), (-1, -1))

  set-style(radius: 1)
intersections("i", {
circle((0,0), name: "a")
circle((1,2), name: "b")
// Use a hidden line to find the border intersections
hide(line("a.north", "a.east", "b.center", close: true, fill: none, name: "triangle"))
//line("a.east", "b.center")
//line("a.north", "b.center")
//line("a.north", "a.east")
})
for-each-anchor("i", (name) => {
  set-style(radius: 0.05, fill: black)
  circle("i." + name)
  let s = text(name, size: 5pt)
  // content("i." + name, s, anchor: "west")
})
//arc("a.east", start: 0deg, delta: 90deg, mode: "CLOSE", fill: yellow)
// arc("b.center", start: 220deg, stop: 270deg, mode: "PIE", fill: green)
//mark((0,0), (-1,-1), symbol: ">", scale: 3, fill: black)

})

---------------------------------------------------------------
