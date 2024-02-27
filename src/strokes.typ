#let dashes = ("solid", "dotted", "densely-dotted", "loosely-dotted", "dashed", "densely-dashed", "loosely-dashed", "dash-dotted", "densely-dash-dotted", "loosely-dash-dotted")
#let caps = ("butt", "round", "square")

#let ref = (
  soft: (dash: "loosely-dotted", thickness: 0.5pt, paint: black),
  gentle: (dash: "loosely-dotted", thickness: 0.45pt, paint: blue),
  fierce: (dash: "loosely-dotted", thickness: 0.45pt, paint: blue),
  thin: (dash: "loosely-dotted", thickness: 0.5pt, paint: black),
  dashed: (dash: "loosely-dash-dotted", thickness: 0.5pt, paint: black),
  hard: (dash: "solid", thickness: 0.5pt, paint: black),
  thick: (dash: "solid", thickness: 2.5pt, paint: black),
)
#let soft = ref.soft

#let get(key, paint: none, cap: none) = {
    let value = ref.at(key)

    if paint != none {
        value.insert("paint", paint)
    }

    if cap != none {
        value.insert("cap", cap)
    }

    return value
}

// #panic(get("thin", paint: blue))
