#let main() = {
  circle((0, 0), name: "circle", radius: 1)
  let pos = (name: "circle", anchor: "west")
    
  content(pos, [A], anchor: "south-east", name: "A")
  content(pos, [B], anchor: "center", name: "B")

  circle("A", radius: 0.5)
  circle("B", radius: 0.5)

  // The initial pos sets the position of the content.
  // The anchor then further anchors the position relative to the initial
  // the coordinate system seems backwards.
  content(pos, 
  // in the cetz library,
  // everything has a coordinate position.
  // the coordinate system itself shifts to accomodate all the positions

  // all the anchors are accessible inside the same scope
}
  
  
//content((name: "circle", anchor: 160deg), box(fill: white)[160deg], anchor: "south-east")
  

  let origin = (0,0)
  let a44 = (4, 4)
  //circle(origin, radius: 1, fill: none, stroke: (dash: "loosely-dotted", paint: white))
  let mark = (
    // symbol: ">", 
    // mark-style: (stroke: blue, fill: black), 
    // mark-size: 1,
    // doesnt do anything
    width: 0.2,
    length: 0.3,
    start: ">",
    end: ">",
    fill: black,
  )
  /*
  let line1 = line(origin, (4,0), mark: mark, name: "l1")
  line1

  let vline(n, height: 0.15) = {
    let x1 = n
    let x2 = n
    let y1 = -height
    let y2 = height
    line((x1, y1), (x2, y2))
    content((x1, y1 - 0.5), text(str(n)))
  }
  for i in range(0, 9) {
    if (i == 3) {
      circle((2,0.5), fill: black, radius: 0.1,
      name: "point"
    )
    content("point.north", [hi])
    }
    if i == 0 or i == 8 or i == 1 or i == 7{
      continue
    }
    vline(i / 2)
  }
  
  //circle((-3,-3), radius: 1, fill: yellow)
  //grid(origin, a44)

// box and whisker ...
// right now ... it doesnt work from my computer ...
// loading a template file
// loading generated files




