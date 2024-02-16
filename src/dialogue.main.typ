#import "dialogue.header.typ": header
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

