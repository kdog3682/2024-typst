#set page(margin: 0.25in, paper: "us-letter", columns: 2)

#set text(font: "IBM Plex Mono")

#let heading-function(it) = {
    text(size: 12pt, it)
    v(-12pt)
    line(length: 100%)
}

#let create(o) = {
    show heading: heading-function
    let title = o.title
    let body = o.body
    heading(title)
    raw(body)
}


#{
  let data = json("/home/kdog3682/2024/temp.json")
  let items = data.map(create).flatten().join()
  items
}

