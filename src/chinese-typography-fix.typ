#let sample = [“大家你好。”我想吃一点烦。“aaa？”Okay！”” ]
#let test() = {
  let nihao = "你好"
  let symbols = "。？；：【】｛｝（）"
}



#let periodMark = box(
    inset: (left: 1pt, right: 0.5pt),
    circle(radius: 1.2pt, stroke: 0.3pt, fill: red)
)

#let exclamMark = box( inset: (left: 0.1em, right: 0.1em), text(size: 1.05em, font: "TeX Gyre Schola Math", [!]) )
#let questionMark = box( inset: (left: 0.1em, right: 0.1em), text(size: 1.05em, font: "TeX Gyre Schola Math", [?]) )
//#let questionMark = box(inset: (left: 0.2em, right: 0.2em), text(weight: "bold", size: 1.1em, font: "New Computer Modern Math", [?]))

#let func(doc) = {
  show "。": periodMark
  show "？": questionMark
  show "！": exclamMark

  set smartquote(enabled: false)
  set text(lang: "zn", font: "Noto Serif CJK HK")
  set par(leading: 0.85em)
  show par: set block(spacing: 1.2em)

  doc
}


#func(sample)
