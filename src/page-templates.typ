#import "base-utils.typ": *

#let fixables = (
    page: (
        index-card: (
            width: 6in,
            height: 4in,
        ),
        small-index-card: (
            width: 5in,
            height: 3in,
        ),
    )
)

#let fix(attrs, fixable) = {
    if fixable != none {
        for (k, v) in attrs {
            if is-string(v) and v in fixable {
                attrs.remove(k)
                // panic(fixable.at(v))
                for (a, b) in fixable.at(v) {
                    attrs.insert(a, b)
                }
                // panic(attrs)
            }
        }
    }
    // panic(attrs)
    return attrs
}
#let theMainImportantWrapper(base, key, kwargs) = {
    let ref = base.at(key, default: none)
    if ref == none {
        return 
    }

    let edits = kwargs.at(key, default: none)
    let fixable = fixables.at(key, default: none)
    ref = assign(ref, edits)
    ref = fix(ref, fixable)
    return ref
}
#let default-marker-func(n) = {
    // color the marker as blue
    // you could theoretically have the marker be anything
    if calc.even(n) {
        text(fill: blue, [•])
    } else {
        [--]
    }
}

#let test-show-enum(it) = {
    // this will be used for lists ...
    set align(center)
    set text(size: 16pt)
    it
    // [\~ #it.body \~ #counter(list).display() ]
}

#let test-show-list(it) = {
    set text(fill: green)
    set align(center)
    it
}

#let test-show-heading(it) = {
    set align(center)
    set text(size: 16pt)
    // all the sizes are normalized to 16pt
    [\~ #it.body \~ #counter(heading).display() ]
}

#let base-ref = (
    default: (
        page: (
            paper: "us-letter",
            margin: (
                // top: 0.65in,
                // left: 0.65in,
                // right: 0.65in,
                // bottom: 0.5in,
                top: 0.85in,
                left: 1in,
                right: 1in,
                bottom: 0.7in,
            ),
        ),
        text: (
            size: 12pt,
            font: "Crimson Pro",
        ),
    ),

    test: (
        page: (
            paper: "index-card",
            // background: cetz-background(),
            margin: (
                top: 0.65in,
                left: 0.65in,
                right: 0.65in,
                bottom: 0.65in,
            ),
        ),
        text: (
            size: 20pt,
            fill: red,
        ),
        enum: (
            numbering: "1 a .",
        ),
        list: (
            // marker: ([•], [--]),
            marker: default-marker-func,
        ),

        // show-heading: test-show-heading,
        show-list: test-show-list,
        // show-enum: test-show-enum,
    ),
)

#let base(doc, ..sink) = {

    let kwargs = sink.named()
    let key = kwargs.at("key", default: "default")
    let attrs = base-ref.at(key)

    let page-attrs = theMainImportantWrapper(attrs, "page", kwargs)
    let text-attrs = theMainImportantWrapper(attrs, "text", kwargs)
    let list-attrs = theMainImportantWrapper(attrs, "list", kwargs)
    let enum-attrs = theMainImportantWrapper(attrs, "enum", kwargs)

    let show-enum = mdg("show-enum", kwargs, attrs, fallback: identity)
    let show-list = mdg("show-list", kwargs, attrs, fallback: identity)
    let show-heading = mdg("show-heading", kwargs, attrs, fallback: identity)

    set page(..page-attrs) if has-value(page-attrs)
    set text(..text-attrs) if has-value(text-attrs)
    set list(..list-attrs) if has-value(list-attrs)
    set enum(..enum-attrs) if has-value(enum-attrs)

    show heading: show-heading
    show list: show-list
    show enum: show-enum

    doc
}

#let test = base.with(key: "test")
#let dialogue = base.with(key: "default")
