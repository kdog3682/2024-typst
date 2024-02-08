// https://typst.app/project/pts91Veybk4FG5vSt7FKVk
// patterns is how you make a chessboard
// fill can be a pattern ... but strokes can also be a pattern
// 


// todo:
// 
// applications: chess-board ... from FEN
// given a position ... find the next best position
// typst will take over typesetting
// it is the modern way of doing pdfs
// best practices will emerge over time
// javascript to typ ? rotational geometries
// 


#let pattern-factory(fn, ..sink) = {
    // do the sizes
    // even an image can be a pattern
    // this is such an amazing language and tool
}

#let pat = pattern(relative: "parent", size: (30pt, 30pt), {
  place(line(start: (0%, 0%), end: (100%, 100%)))
})

//#rect(fill: pat, width: 30pt, height: 30pt, stroke: 1pt)
#let pat = pattern(size: (30pt, 30pt))[
  #let n = 10
  #for i in range(-n, n) {
    let unit = 5

    // points to the southeast (y = -1x)
    // let start = (0% + unit * i * 1pt, 0%)
    // let end = (100% + i * unit * 1pt, 100%)

    // points to the northwest (y = 1x)
    let start = (0% + unit * i * 1pt, 100%)
    let end = (100% + i * unit * 1pt, 0%)
    place(line(start: start, end: end))

    // different unit types can be merged together ... amazing
    // 
  }
]

#let size = 30
#rect(fill: pat, width: size * 1pt, height: size * 1pt, stroke: 1pt)
