// 
#let generate-key(name) = {
    let dirs = directions.map((alias, dir) => (alias, name + "." + dir))
    let dirs = l2d(dirs)
    return (
      label: name,
      dirs: dirs
    )
}
#let foo(name, k-factor: 2) = {
    let key = generate-key(name)
    circle((0,0), name: key.label, radius: k-factor, fill: yellow.lighten(20%))
    let keys = (
      "sam.east", 
      "sam.north-west",
      "sam.west",
      "sam.south-west",
    )
    let middle = ("sam.west", "sam.east")
    line(..keys, close: true, fill: white)
    line(..middle, stroke: (thickness: 0.5pt, paint: blue, dash: "dotted"))
      cetz.angle.angle("sam.west", "sam.north-west", "sam.east", label: {
        text(size: 12pt, "hi")
      },
      label-radius: 65%,
      radius: 0.95,
      inner: true,
      name: "western-angle",
      mark: (fill: blue, stroke: none),
    )
}
