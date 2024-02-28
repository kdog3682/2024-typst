// implementing decimals would take some time.
// not impossible ... just simply taking some time.

#import "@preview/cetz:0.2.0"

#cetz.canvas({
  import cetz.draw: *
   // awesome! thank you.
   // :)
  let min = -3
  let max = 4
  let (a, b) = ((0,0), (7,0))
 
  line((rel: (-1,0), to: a),
       (rel: (1,0), to: b),
       mark: (fill: black, end: "stealth", start: "stealth"), name: "line")
    
  // Place labels
  let labels = (
    (-2.0, $O$),
    (0.5, $O$),
    (1.5, $S$),
    (2.1, $E$),
  )

  let len = cetz.vector.dist(a, b)
  for (position, label) in labels {
    let pos = cetz.vector.lerp(a, b, (position - min) / (max - min))
    content(pos, label, anchor: "south", padding: (bottom: .50))
    group({
      set-origin(pos)
      scale(.1)
      circle((0, 0), fill: black)
      line((0, 0), (0, 4))
      rect((-2,4), (2, 8))
    })
  }

  // Place ticks
  for maj in range(min, max + 1) {
    move-to(cetz.vector.lerp(a, b, (maj - min) / (max - min)))
    line((rel: (0, 0.1)), (rel: (0, -.2)))
    content((rel: (0, -.1)), $maj$, anchor: "north")
  }
})
