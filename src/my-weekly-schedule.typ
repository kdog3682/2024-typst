#import "base-utils.typ": *

#let flex(..sink) = {
    // layout-util
    let args = sink.pos()
    let flat(arg) = {
        if is-array(arg) {
            arg.join()
        } else {
            arg
        }
    }
    let flattened = args.map(flat)
    panic(flattened)
    let length = len(flattened)
    let aligner(col, row) = {
        if col == 0 {
            left  + horizon
        } else if col == length - 1 {
            right + horizon
        } else {
            center + horizon
        }
    }
    let spacer = h(0.5fr)
    let spacer = h(1fr)
    return table(columns: (1fr,) * flattened.len(), align: aligner, stroke: none, ..flattened)
    return flattened.join(spacer)
}


#let my-weekly-schedule(data) = {
  let items = data
  let weekdays = ("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
  let weekdays = "M T W Th F Sat Sun".split(" ")
  let create(s) = {
    return box(width: 20pt, height: 15pt, s)
  }
  let header(s) = {
     return text(size: 12pt, weight: "bold", align(s, horizon))
  }
  let cols = (30pt,) * weekdays.len()
  let cells = (("Todo Item",) + weekdays).map(header) + items

  table(
    align: (col, row) => {
      if row == 0 and col == 0 {
        return left + horizon
      }      

      if row == 0 {
        return center
      }      
      if col == 0 {
        return left + horizon
      }      
      return left + horizon
    },
    inset: (y: 5pt, left: 5pt, right: 5pt), columns: (auto, ) + cols, ..cells)
}

#let additional-entries() = {
    let create(s) = {
        return box(height: 8pt)
    }
    table(columns: (80pt,), ..fill(25, "").map(create))
}
#let wrapper() = {

  let title = "Year 2024 Week 6 - February 5"
  set page(
    footer-descent: 0pt,
    flipped: false, paper: "us-letter", margin: 0.75in)

  show heading: set text(size: 12pt)
  [= #title]
  v(10pt)

    stack(dir: ltr, spacing: 40pt,
        my-weekly-schedule(readjson()),
        additional-entries()
    )
}
#wrapper()
