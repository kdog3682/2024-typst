// setlocal statusline=%f\ %=%{expand('%:t')}\ %l,%c%V\ %P
// setlocal statusline=%{MyCustomStatusLine()}

#import "styles.typ"

#let chess-icon(color, piece, size: 10) = {
    let url = "../chess-assets/" + color + "-" + piece + ".svg"
    size = size * 1pt
    let attrs = (
      width: size,
      height: size,
    )
    return circle(fill: black, radius: size / 2)
    return image(url, ..attrs)
}

#{
    let pawn = chess-icon("white", "pawn")
    let pieces = (pawn, pawn, pawn)
    table(columns: 8, rows: 8, align: center, ..pieces)
}
