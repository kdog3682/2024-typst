#import "mmgg-template.typ": mmgg-template
#import "base-utils.typ": *
#import "pinyin-sentence-layout.typ": zhuyin-sentence


#let speaker-factory(..sink) = {
    let speakers = sink.pos()
    let length = speakers.len()
    let kwargs = sink.named()
    let mode = kwargs.at("mode", default: "pair")
    let count = state("count", 0)
    
    let get-speaker(i) = {
        let index = calc.rem(i, length)
        count.update((x) => x + 1)
        return speakers.at(index)
    }
    return get-speaker
}

#let dialogue-layout(items) = {
  // simple declarative sentences ...
  // sentences that end with an exclamation mark
  // sentences
  let store = ()
  // let get-speaker = speaker-factory("Dad", "Norah", mode: "pair")
  for (index, item) in items.enumerate() {
    // let speaker = get-speaker(index)
    store.push(sm-text(bold(item.speaker), size: 10))
    store.push(item.content)
  }

  let attrs = (
      columns: (auto, 1fr),
      column-gutter: 20pt,
      row-gutter: 40pt,
  )
  grid(..attrs, ..store)
}


#let zhuyin-chunk(o) = {
    for line in o.lines {
        zhuyin-sentence(line.parts)
        if line.break {
            v(20pt)
        } else {
            v(10pt)
        }
    }
}

#let create(file) = {
    let data = json(file)
    let data = (
        body: data,
        title: "aaa",
    )

    let chunks = data.body.map(zhuyin-chunk)
    let main = dialogue-layout(chunks)
    mmgg-template(main, title: data.title)
}


#let file = "/home/kdog3682/2023/clip.json"
#create(file)

// 1706121027 /home/kdog3682/PYTHON/jieba_script.py
// #import "pinyin-sentence-layout.typ": zhuyin-sentence
// /home/kdog3682/2024-typst/src/mmgg-template.typ
