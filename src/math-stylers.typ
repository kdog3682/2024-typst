

#import "base-utils.typ": *

#let styled-exponent(mc, fill: blue) = {

    let runner(body) = {
        let t = body.t
        let top = text(fill: fill, t)
        return math.attach(body.base, t: top)
    }

    let fields = mc.fields()
    if "body" in fields {
        if "base" in fields.body.fields() {
            return runner(mc.body)
        } else {
            return mc
        }
    } else {
        if "base" not in fields {
            return mc
        } else {
            return runner(mc)
        }
    }
}

#let style-all-exponents(mc, ..sink) = {
     let transform = styled-exponent.with(..sink.named())
     if has-children(mc) {
         let children = mc.body.children
         return children.map(transform).join()
     }
     return transform(mc, style: style)
}
#let styled-fraction(mc, top: none, bottom: none) = {
    let runner(body) = {
        let num = xblue(body.num)
        let denom = xred(body.denom)
        return math.display(math.frac(num, denom))
    }

    let fields = mc.fields()
    // panic(fields)
    // fields
        
    if "body" in fields {
        if "num" in fields.body.fields() {
            return runner(mc.body)
        } else {
            return mc
        }
    } else {
        if "num" in fields {
            return runner(mc)
        } else {
            return mc
        }
    }
}


#let style-all-fractions(mc, ..sink) = {
     let transform = styled-fraction.with(..sink.named())
     if has-children(mc) {
         let children = mc.body.children
         return children.map(transform).join()
     }
     return transform(mc)
}



#let works() = {
    let a = $2^3 + 2^(3/4)$
    style-all-exponents(a)
}

#let works() = {
    let a = $5/6 + 5/6$
    style-all-fractions(a)
}
