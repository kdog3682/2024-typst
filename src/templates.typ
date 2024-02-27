
#let chatgpt(doc, ..sink) = {
    let options = sink.named()
    set text(fill: blue)
    doc
}

#let hawaii-theme = (
    
)

#let get(key, theme: none) = {
    let ref = (
        chatgpt: chatgpt
    )
    let themes = (
        "hawaii": hawaii-theme
    )
    let fn = ref.at(key)
    if theme != none {
        fn = fn.with(..themes.at(theme))
    }
    return fn
}

