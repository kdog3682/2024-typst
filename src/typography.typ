#import "base-utils.typ": *
#import "classes.typ": classes

#let line(class: "") = {
    let base = classes.at(class).at("line")
    let value = ""
    let line-attrs = base.line
    value = _line(..line-attrs)
    if "spacing" in base {
        v(resolve-pt(base.spacing.above))
        value
        v(resolve-pt(base.spacing.below))
    }
}

#let text(s, class: "") = {
    let content = resolve-content(s)
    if class in classes.default {
        let text-attrs = classes.default.at(class)
        return _text(..text-attrs, content)
    } 
    let base = classes.at(class).at("text")
    let text-attrs = base.at("text", default: none)
    let value =  _text(..text-attrs, content)
    let align-arg = base.at("align", default: none)
    if align-arg != none {
        value = align(align-arg, value)
    }
    return value
}


#let title(s, class: "hawaii") = {
    text(s, class: class)
    line(class: class)
}

#let header(s) = {
    
}

#let footer(s) = {
    
}

#let bold    = text.with(class: "bold")
#let md-text = text.with(class: "md-text")
#let sm-text = text.with(class: "sm-text")
#let lg-text = text.with(class: "lg-text")
