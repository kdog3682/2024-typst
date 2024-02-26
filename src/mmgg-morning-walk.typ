#import "mmgg-template.typ": mmgg-template
#import "base-utils.typ": *
#import "pinyin-sentence-layout.typ": zhuyin-atom, zhuyin-sentence, zhuyin-wrapper, zhuyin-sentence-chunk


#let main(file, title: none) = {
    if empty(title) {
        title = "早晨散步"
        title = "早晨散步"
    }

    let sentences = json(file)
    let spacer = v(15pt)
    let main = block(sentences.map(zhuyin-sentence-chunk).join(spacer))

    // let sentences = json(file)
    // let main = block(sentences.map(zhuyin-sentence-chunk).join())

    mmgg-template(main, title: title)
}

#let file = "/home/kdog3682/2023/clip.js"
#main(file)

// 1706121027 /home/kdog3682/PYTHON/jieba_script2.py // produces the raw
// #import "pinyin-sentence-layout.typ": zhuyin-sentence
// /home/kdog3682/2024-typst/src/mmgg-template.typ

