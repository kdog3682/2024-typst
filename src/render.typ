#import "base-utils.typ": *
#import "@preview/cetz:0.2.0"
#import "render-functions.typ": render-functions
#import "canvas-functions.typ": canvas-functions
#import "@preview/splash:0.0.1": tailwind
// generating a bar code ...
// apple is doing something on a completely different level.


#let render-canvas(..sink) = {
    let kwargs = sink.named()
    let items = sink.pos()
    cetz.canvas(..kwargs, {
      for item in items {
        let handler = item.at("handler")
        let kwargs = transform-kwargs(item.at("kwargs", default: (:)))
        let args = item.at("args", default: ())
        canvas-functions.at(handler)(..args, ..kwargs)
      }
    })
}
#render-canvas(readjson())

#let transform-kwargs(kwargs) = {
    
    let scope-ref = render-functions
    let color-ref = tailwind

    let pmwh-ref = (
      "5pt": 5pt,
      "10pt": 10pt,
    )
    let master = (
      "fill": color-ref,
      "stroke": color-ref,
      "scope": scope-ref,
      "x": pmwh-ref,
      "inset": pmwh-ref,
      "radius": pmwh-ref,
    )

    for key in master.keys() {
        if has(kwargs, key) {
            if key == "scope" {
                let ref = kwargs.at(key)
                for (k, v) in ref.pairs() {
                    ref.insert(k, scope-ref.at(v))
                    // panic(ref)
                }
                kwargs.insert(key, ref)
                continue
            }
            kwargs.insert(key, master.at(key).at(kwargs.at(key)))
        }
    }
    return kwargs
}

#let render(data) = {

    let container(..sink) = {
        let kwargs = sink.named()
        let contents = sink.pos()
        block(..kwargs, contents.join())
    }

    let handler = data.at("handler", default: none)
    let fn = if handler == "block" { container } else if handler == "canvas" { render-canvas } else { render-functions.at(handler) }
    let value = data.at("value", default: none)
    let kwargs = transform-kwargs(data.at("kwargs", default: (:)))

    if is-defined(value) {
        fn(..kwargs, value)
    } else {
        let args = data.at("args", default: ())
        fn(..kwargs, ..args.map(render))
    }
}

// #render(readjson())
// #box(width: 3em, height: 1em, fill: xcolor.dandelion)
/home/kdog3682/2024-typst/.gitignore
