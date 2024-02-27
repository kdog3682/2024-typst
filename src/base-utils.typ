#import "very-base-utils.typ": *
#import "attrs.typ"


#let align-apart(col, row, length: none) = {
    if col == 0 {
        left  + horizon
    } else if col == length - 1 {
        right + horizon
    } else {
        center + horizon
    }
}

#let justify-space-between(arg, i, a) = {
    if i == 0 {
        return align(left, arg)
    }
    else if i == len(a) - 1 {
        return align(right, arg)
    }
    else {
        return align(center, arg)
    }
}

#let justify-ref = (
    space-between: (
        justify: justify-space-between,
        attrs: (
            column-gutter: 1fr
        ),
        container: grid,
    ),

    centered-space-between: (
        justify: justify-space-between,
        attrs: (
            column-gutter: 1fr,
            stroke: none,
            align: horizon,
        ),
        container: table,
    ),
)

#let resolve-dict(ref, key) = {
    if is-object(key) {
        return key
    }
    return ref.at(key, default: none)
}



// #centered(block(width: 400pt, flex(lorem(100), lorem(15), justify-content: "start")))

#let bold-numbering-func(it) = [ *#it.* ]
#let bold-numbering-letter-func(it) = [ *#alphabet.at(it - 1).* ]


// dunno what this is ...
#let removeStartingDollars(s) = {
    if s.starts-with("$") == true {
        return s.slice(1, -1) 
    }
    return s
}

#let is-exp(o) = {
    return is-dict(o) and "base" in o and "t" in o
}


#let create-icon(name, fill: none, size: 20, key: none, ext: "svg", baseline: 0.85em) = {
    assert(key != none, message: "a key is required to access the correct asset directory")
    let root = "../"
    let url = root + str(key) + "-assets/" + name + "." + ext
    size = resolve-pt(size)
    let attrs = (
      width: size,
      height: size,
    )
    let box-attrs = (
        // stroke: black,
        inset: 3pt,
        radius: 0pt,
        fill: none,
        outset: 0pt,
        // baseline: baseline,
        baseline: 50%,
    )
    return box(..box-attrs, image(url, ..attrs))
    // return box(..box-attrs, image(url, ..attrs))
    // return image(url, ..attrs)
}

#let emoji-icon = create-icon.with(key: "emoji", ext: "svg", baseline: 2em)
#let assert-dict = assert-type.with(kind: "dict")



#let boo(..sink) = {
    return type(sink)
}
#let foo(..sink) = {
    return boo(..sink)
}

