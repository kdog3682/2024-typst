#import "@preview/cetz:0.1.2"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree
  tree.tree(
    spread:3,
    grow:4,
    ([root],[A],[B]),
    draw-node: (node, parentnode) => {
      content((),text(4pt,[#node]),padding:.1,name:"content")
      rect("content.top-left","content.bottom-right")
    }
  )
})

---
#let pinyin(doc) = {
  doc
}

#let zhuyin(doc, ruby, scale: 0.7, gutter: 0.3em, delimiter: none, spacing: none) = {
  if delimiter == none {
   return box(align(
      bottom,
      table(
        columns: (auto, ),
        align: (center, ),
        inset: 0pt,
        stroke: none,
        row-gutter: gutter,
        text(1em * scale, pinyin(ruby)), 
        doc,
      ),
    ));
  }

  let extract-text(thing) = if type(thing) == "string" { thing } else { thing.text };
  let chars = extract-text(doc).split(delimiter);
  let aboves = extract-text(ruby).split(delimiter);

  if chars.len() != aboves.len() {
    error("count of character and zhuyin is different")
  }

  chars.zip(aboves).map(((c, above)) => [#zhuyin(scale: scale)[#c][#above]]).join(if spacing != none [#h(spacing)])
}



#set text(
   lang: "zh", region: "cn",
   font: "Noto Sans CJK HK",
   fallback: false,
)
#let per-char(f) = [#f(delimiter: "|")[汉|语|拼|音][ha4n|yu3|pi1n|yi1n]]
#let per-word(f) = [#f(delimiter: "|")[汉语|拼音][ha4nyu3|pi1nyi1n]]
#let all-in-one(f) = [#f[汉语拼音][ha4nyu3pi1nyi1n]]
#let example(f) = (per-char(f), per-word(f), all-in-one(f))

// argument of scale and spacing
#let arguments = ((0.5, none), (0.7, none), (0.7, 0.1em), (1.0, none), (1.0, 0.2em))

#table(
  columns: (auto, auto, auto, auto),
  align: (center + horizon, center, center, center),
  [arguments], [per char], [per word], [all in one],
  ..arguments.map(((scale, spacing)) => (
    text(font: "Crimson Pro", size: 0.9em)[#scale,#repr(spacing)], 
    ..example(zhuyin.with(scale: scale, spacing: spacing))
  )).flatten(),
)


