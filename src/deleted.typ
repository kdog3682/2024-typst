#let create-icon-factory(dir, ext: "png") = {
    // factory-util
    // possibly this is not the way to go.
    // u can straight curry arguments into create-icon

    let create-icon(key, ..sink) = {
        let kwargs = sink.named()
        let url = dir + str(key) + "." + ext
        let size = kwargs.at("size", default: 20)
        let el = image(url)
        if empty(el) {
            panic(url)
        }
        return box(width: size * 1pt, height: size * 1pt, el)
    }
    return create-icon
}
