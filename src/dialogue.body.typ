// #import "base-utils.typ": *
// #import "classroom.typ"
// #import "designer.typ"

#import "dialogue.header.typ": header
#import "dialogue.problemset.typ": problemset 
#import "dialogue.clip.typ": body 
#import "page-templates.typ"

#show: page-templates.dialogue

#let header-data = (
    student-group: "ravenclaw",
    title: "Multiplying Exponents",
    topic: "Exponents I",
)
#let problemset-data = (
    foo: "bar",
)

#header(..header-data)
#body()
// #problemset(..problemset-data)

