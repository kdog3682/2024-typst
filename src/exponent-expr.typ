#import "/home/kdog3682/2024/base-utils.typ": *

#let exponent-expr(interval) = {
    let store = ()
    let numbers = ()
    for n in step(..interval) {
        let palette = (red, blue, green, green, red, blue)
        let exp = colored(n, palette.at(n - 1))

        store.push(exp)
        numbers.push(n)

        $x^#exp$
        // the exp is colored by the palette

        let ref = (
          "plus": (
            "delimiter": "",
            "aggregator": sum,
          ),
          "times": (
            "delimiter": "exp",
            "aggregator": multiply,
          ),
        )

        let key = "plus"
        let (delimiter, aggregator) = ref.at(key)
        if (is-last(n, interval.at(1))) {
            let expr-value = wrap(store.join([$space #delimiter space$]), "()")
            $space = space x^#expr-value$
            $space = space x^#aggregator(..numbers)$
        } else {
            wrap($dot$, " ")
        }
    }
}

#panic(exponent-expr((5, 7)))

