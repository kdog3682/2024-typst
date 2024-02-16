#import "base-utils.typ": *
#import "classroom.typ"
#import "designer.typ"
// functions.typ

#let header(student-group: none, title: none, subtitle: none, topic: none) = {
    
    let leftContent = {
        if title != none {
            text(weight: "bold", fill: blue.darken(50%), size: 16pt, title)
            // v(0pt)
        }
        // if subtitle != none {
            // [==== #subtitle]
            // v(5pt)
        // }
    }

    let rightContent = {
        let store = ()
        if topic != none {
            let a = colon("Topic", text(fill: blue, emph(topic)))
            store.push(a)
        }
        if student-group != none {
            let students = classroom.get-student-group(student-group)
            let names = students.map(map-names)
            let first = students.first()
            let grade = first.grade
            let className = first.className
            let b = colon("Student Group", names.join(" | "))
            let c = [*Grade #grade #className Practice*]
            store.push(b)
            store.push(c)
        }
        stack(spacing: 0.95em, ..store)
    }

    let align-func(col, row) = {
        if col == 0 {
            center + horizon
        } else {
            right + horizon
        }
    }

    designer.line(stroke: "soft")
    table(stroke: none, columns: (2fr, 1fr), align: align-func, inset: 0pt, leftContent, rightContent)
    designer.line(stroke: "soft")
    v(10pt)
}

