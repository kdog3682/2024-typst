// #panic(split-twice("aaaa"))

#let stroke-builder(s) = {
    let items = split(s, " +")
    return black
}
pan colored("a")


#set page(margin: 0.5in, paper: "us-letter", numbering: "page 1")

#show heading: (it) => {
  it
  let level = it.level
  let re
  if level == 1 {
    v(10pt)
  }

}
= Sample Curriculum for First 2 Weeks

hi


#let render-attrs(o) = {
    if o.line { line(o.line) }
    if o.margin-bottom { v(o.margin-bottom) }
}

ref
    name: standard-line
    level: 1
    margin-bottom:
    line
        length: 100%
        stroke:
            dash: loosely-dotted
            thickness: 0.5pt


#let dynamic-heading-function(it) = {
    it
    // place the element before everything else

    let attrs = ref.at(it.level)
    render-attrs(attrs)
    // perhaps render a line
    // perhaps render vertical spacing
}

#locate(loc => [ #loc.position()! ])



#let dynamic-block-function(it) = {
    // access the children and reshape them
}
#let boxy-align(..items) = {
    return box({
        for item in items {
            align(center, item)
        }
    })
    // this is better than using a show rule
    // to artific

}
// can use the measurer to get 


