// cetz
// content is positional in cetz
let hline(n, height: 0.15) = {
    // would have to get it inside this function block
    // swap (y1, x1), (y2, x2)

    let x1 = n
    let x2 = n
    let y1 = -height
    let y2 = height
    line((x1, y1), (x2, y2))
    content((x1, y1 - 0.5), text(str(n)))
}

let vline(n, height: 0.15) = {
    let x1 = n
    let x2 = n
    let y1 = -height
    let y2 = height
    line((x1, y1), (x2, y2))
    content((x1, y1 - 0.5), text(str(n)))
}

#let numberline-base(interval) = {
    let mark = (
        // symbol: ">",
        // mark-style: (stroke: blue, fill: black),
        // mark-size: 1,
        // doesnt do anything
        // none of this does anything
        width: 0.2,
        length: 0.3,
        start: ">",
        end: ">",
        fill: black,
  )
  return line((interval.at(0),0), (interval.at(1),0), mark: mark)
}

#let generate-ticks(interval) = {
    // it should come about from the provided data maybe
}


// 
#let numberline(
  range,
  step: 1,
  marks: (:),
) = {
    let (a, b) = range
}

  numberline-base(range)
  generate-ticks(range, step)

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

