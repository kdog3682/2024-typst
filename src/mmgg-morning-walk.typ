#import "mmgg-template.typ": mmgg-template
#import "base-utils.typ": *
#import "pinyin-sentence-layout.typ": zhuyin-atom, zhuyin-sentence, zhuyin-wrapper, zhuyin-sentence-chunk

#let main(file) = {
    let options = (
        blockSpacing: 15,
        englishNameSizing: 0.85,
        sentence: (
            k: 0.50,
            leading: 0.95em,
        )
    )
    let (sentences, title) = json(file)
    let spacer = v(options.blockSpacing * 1pt)
    let mapper = zhuyin-sentence-chunk.with(..options.sentence)
    let main = block(sentences.map(mapper).join(spacer))
    mmgg-template(main, title: title, englishNameSizing: options.englishNameSizing)
}

#let file = "/home/kdog3682/2023/clip.js"
#main(file)
// #main("/home/kdog3682/2023/clip.js")
