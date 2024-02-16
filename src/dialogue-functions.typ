#import "base-utils.typ": *
#import "designer.typ"
// clip.typ

#let dialogue-item(content, speaker-width: 100pt, speaker: "Sam") = {
    let columns = (speaker-width, auto)
    let align = (left, left)
    let speakerContent = bold(speaker)
    // let rightContent = content + place(dy: 10pt, designer.line())
    let rightContent = content
    let tableContent = table(stroke: none, columns: columns, align: align, inset: 0pt, speakerContent, rightContent)
    block(below: 30pt, tableContent)
}
