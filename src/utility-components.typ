#import "base-utils.typ": *

#let answer-box(x, label: none) = {

    let math-content = resolve-math-content(x)
    let expr = [*#label #xequal() #math-content*]

    let box-attrs = (
        inset: 5pt,
        baseline: 25%,
        radius: 3pt,
        stroke: black + 0.5pt,
    )

    h(2pt) 
    box(..box-attrs, expr)
}

#let answer-key-wrapper(content) = {
    set text(size: 12pt)
    let block-attrs = (
        inset: 5pt,
    )
    rotate(180deg, block(..block-attrs, content))
}



#let code-table(..sink) = {
    let args = sink.pos()
    let columns = args.len()
    let opts = sink.named()
    table(columns: 1, rows: columns, ..args.map((x) => raw(..opts, x.text)))
}

#let wde(x) = {
    let box-attrs = (
        stroke: none,
        inset: 0pt,
        radius: 0pt,
        fill: none,
        outset: 0pt,
    )
    let math-content = resolve-math-content(x)
    [#h(4pt) *What does #h(2pt) #math-content equal?*]
    // box(..box-attrs,
}

#let findx(x, target: "x") = {
    let math-content = resolve-math-content(x)
    [*Find $#target$.* #h(4pt) #math-content.]
}


// #findx("a^1 * a^2 * a^3 = a^(x/2)")

#let answerx(x, answer) = {
    let math-content = resolve-math-content(x)
    [#math-content.  #h(5pt) *$x$ equals #answer.*]
}

#let give-answer(x, target: "x") = {
    let math-content = resolve-math-content(x)
    let box-attrs = (
        stroke: black,
        inset: 5pt,
        radius: 3pt,
        fill: none,
        outset: 0pt,
        baseline: 25%,
    )
    [The answer is #h(3pt) #box(..box-attrs, [*#target #xequal(h(1pt)) #math-content*])]
    
}

// #answerx($1 + 2 + 3 = display(x/2)$, 12)

// #give-answer("a^(3x)", target: "b")


#let boxed(x) = {
    let box-attrs = (
        stroke: 0.25pt + black,
        inset: (
            x: 5pt,
            y: 5pt,
        ),
        radius: 3pt,
        baseline: 25%,
    )
    let math-content = resolve-content(x)

    h(5pt)
    box(..box-attrs, math-content)
    h(5pt)
}

// The only way to make $a^(#xblue($4x$))$ is if $b$ has a base of an exponent of $#xblue($3x$)$.


// $
    // x + 1 = & 33 && "howdy"\
    // x + 1111 = & 33111 && "bowdddddy"
// $
