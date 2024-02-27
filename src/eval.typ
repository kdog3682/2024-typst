#import "base-utils.typ": *
#let mathup(s, ..sink) = {

    let default-scope = (
      blue: xblue,
      red: xred,
      green: xgreen,
      xdot: xdot,
      xequal: xequal,
      xarrow: xarrow,
    )
    let scope = if sink.pos().len() > 0 { sink.pos().first() } else { default-scope }
    let kwargs = sink.named()
    let ref = (
      "*": " #xdot() ",
      "=": " #xequal() ",
    )

    let expr = dreplace(s, ref)
    assert(test(expr, "^\$") != true, message: "no dollars allowed: " + expr + "\n\noriginal:\n\n" + "[" + s + "]")
    let value = eval(expr, mode: "math", scope: scope)
    let size = kwargs.at("size", default: none)
    if size != none {
        value = text(size: size, value)
    }

    let label = kwargs.at("label", default: none)
    if label != none {
        let labelContent = bold(label)
        return stack(dir: ltr, spacing: 10pt, labelContent, value)
    }
    return value

}

#let resolve-math-content(x) = {
    if is-string(x) {
        x = removeStartingDollars(x)
        return mathup(x)
    }
    return x
}


#let mathdown(s, ..sink) = {
    let scope = sink.named()
    return eval(s, mode: "math", scope: scope)
}
#let markup(..sink) = {
    let s = sink.pos().first()
    let scope = sink.named().at("scope", default: (:))
    let b = eval(s, mode: "markup", scope: scope)
    return b
}
