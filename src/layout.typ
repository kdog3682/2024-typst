#import "base-utils.typ": *


#let flex(..sink) = {

    let opts = sink.named()
    let padding = opts.at("padding", default: none)
    // pads the arg inside of fn:prepare
    let debug = opts.at("debug", default: none)
    // draws a red rectangle around the arg
    // uses a block wrapper around the final payload

    let wrapper(value) = {
        let width = opts.at("width", default: none)
        let margin = opts.at("margin", default: 10pt)
        let block-attrs = (:)

        if margin != none {
            block-attrs.insert("above", margin)
            block-attrs.insert("below", margin)
        }
        if width != none {
            block-attrs.insert("width", resolve-pt(width))
        }
        if has-value(block-attrs) {
            return block(..block-attrs, value)
        }
        return value
    }

    let prepare(arg) = {
        if debug != none {
            arg = rect(stroke: red, arg)
        }
        if padding != none {
            arg = pad(padding, arg)
        }
        return arg
    }

    let args = sink.pos().map(prepare)
    let columns = args.len()

    let top-attrs = (
        columns: columns,
    )
    let justify-content = opts.at("justify-content", default: none)
    if justify-content != none {
        let (
            justify,
            container,
            attrs,
        ) = justify-ref.at(justify-content)
        let payload = container(..attrs, ..top-attrs, ..map(args, justify))
        return wrapper(payload)
    }
    // we prepare the args with padding because
    // prose almost always needs padding
    // place all the paddings in one place

    let table-attrs = (
        stroke: (
            paint: black,
            thickness: 0.5pt,
            dash: "dotted",
        ),
        // stroke: none,
        row-gutter: auto,
        rows: auto,
        column-gutter: auto,
        align: auto,
    )
    let block-attrs = (
        below: 0pt,
        above: 0pt,
        fill: yellow.lighten(90%),
        radius: 5pt,
        inset: 5pt,
        width: 400pt, // the width does control it
        height: auto,
        outset: 0pt,
    )
    block(..block-attrs, table(..table-attrs, columns: columns, ..args))
}

#let flex-1(..sink) = {
    // layout-util
    let args = sink.pos()

    let flat(arg) = {
        if is-array(arg) {
            arg.join()
        } else {
            arg
        }
    }

    let flattened = args.map(flat)
    let length = len(flattened)
    // let spacer = h(0.5fr) // has a purpose ...
    let spacer = h(1fr)
    return table(columns: (1fr,) * flattened.len(), align: align-apart.with(length: length), stroke: none, ..flattened)
    return flattened.join(spacer)
}
