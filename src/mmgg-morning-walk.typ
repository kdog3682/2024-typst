#import "mmgg-template.typ": mmgg-template
#import "base-utils.typ": *
#import "pinyin-sentence-layout.typ": zhuyin-sentence, zhuyin-atom

#let zhuyin-sentence-2(o) = {
  // jsondata via chatgpt
  // 
  let spacer-punctuation = h(0.1em)
  let spacer-word = h(0.2em)

  // if o.pinyin.len() != o.chinese.len() {
    // panic(o)
  // }
  for (i, pinyin) in o.pinyin.enumerate() {
    let chinese = o.chinese.at(i)
    if empty(pinyin) {
        chinese // it is punctuation
        if i == 0 {
            continue
        }
        else if not is-last(i, o.pinyin) {
            spacer-punctuation
        }
    } else {
        zhuyin-atom(pinyin, chinese)
        if not is-last(i, o.pinyin) {
            spacer-word
        }
    }
  }
}

// lx (x) =>
// inoreab <buffer>77 &&
// inoreab <buffer>pe +=
// look up the templates ... and the similarities ...
// xp5pxp6 ab
// evaluate the text as you write it ...
// because seeing it makes a big difference
#let zhuyin-wrapper(sentence, width: 75) = {
    let a = block(sentence, width: (width) * 1%)
    let b = block(sentence, width: (width + 20) * 1%)
    style(styles => {
        let measurement-a = measure(a, styles)
        let measurement-b = measure(b, styles)
        if measurement-a.height == measurement-b.height {
            a
        } else {
            b
        }
    })
}
#let create(file, title: none) = {
    if empty(title) {
        title = "早晨散步"
    }
    let zhuyin-chunk(o) = {
        zhuyin-wrapper(zhuyin-sentence-2(o), width: 65)

        if has(o, "break") {
            v(15pt)
            let dotted = (
              stroke: (
                  thickness: 0.5pt,
                  dash: "loosely-dotted",
              )
            )
            align(center, line(length: 100%, ..dotted))
        }
    }
    let lines = json(file)
    let spacer = v(14pt)
    let main = block(lines.map(zhuyin-chunk).join(spacer))

    mmgg-template(main, title: title)
}

#let file = "/home/kdog3682/2024/clip2.json"
#create(file)

// 1706121027 /home/kdog3682/PYTHON/jieba_script.py
// #import "pinyin-sentence-layout.typ": zhuyin-sentence
// /home/kdog3682/2024-typst/src/mmgg-template.typ

// process:
// jieba processes the chinese lines (preserving breaks)
// it is then passed over here
// zhuyin sentence is the core worker




// so it is correct to do it via chatgpt ...
// it is just much more accurate?
// but what about pagebreaks
// what about pagebreaks ...
