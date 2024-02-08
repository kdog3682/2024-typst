#import "base-utils.typ": *
#set page(width: 400pt, height: 300pt)

// 400 to 300 represents 4:3 aspect ratio
// which is the ratio for ipad mini2

#let url = "../chess-assets/interview-demo-tactics/"
#let create-image = create-icon-factory(url)
#let create(n) = {
    let img-item = create-image(n, size: 300 - 50)
    return align(center + horizon, img-item)

    // let label-item = "hi"
    // return flex.with(vertical: true)(img-item, label-item)
    // need to implement vertical flex
}

#let items = step(12).map(create).join(pagebreak())
#items
