#import "/home/kdog3682/2024-typst/src/base-utils.typ": *
#import "/home/kdog3682/2024-typst/src/dialogue-functions.typ": *
#import "/home/kdog3682/2024-typst/src/exponent-rules.typ": exponent-rules
#import "/home/kdog3682/2024-typst/src/dialogue.header.typ": header as math-front-matter
#import "/home/kdog3682/2024-typst/src/page-templates.typ"
#import "/home/kdog3682/2024-typst/src/utility-components.typ": *
#let speakers = ("Kloe", "Kaylee")

#let longest = get-longest((speakers))
#let speaker-width = longest * 10pt
#let dialogue-item = dialogue-item.with(speaker-width: speaker-width)
#show math.equation: set text(size: 1.1em)

#show par: set block(spacing: 1.75em)
#set par(leading: 0.68em)

show: page-templates.dialogue
// this calls the function

#show math.equation: (it) => {
  if it.fields().block == true {
    v(10pt)
    set par(leading: 1.5em)
    it
    v(10pt)
  } else {
    it
  }
}


#math-front-matter(
    student-group: "ravenclaw",
    title: "Multiplying Exponents",
    topic: "Exponents I",
)

#dialogue-item(speaker: "Kaylee", [
    $x dot x dot x$ means $x^#xblue(1) dot x^#xblue(1) dot x^#xblue(1)$.
])

#dialogue-item(speaker: "Kloe", [
    And it equals $x^#xblue(3)$.
])

#dialogue-item(speaker: "Kaylee", [
    Look Kloe, $1 + 1 + 1 = #xblue(3)$.
    
    #v(10pt)
    And on the other side, we have $x^#xblue(3)$.
    
    #v(10pt)
    Could this be a concidence?
])

#dialogue-item(speaker: "Kloe", [
    I think not!
    
    #v(10pt)
    Try this question Kaylee: #wde("x^100 * x^1")
])

#dialogue-item(speaker: "Kaylee", [
    Does it equal $display(x^(#xblue(100) #xplus() #xblue(1)) #xarrow() x^#xblue(101))$?
])

#dialogue-item(speaker: "Kloe", [
    It does!\

    You have just discovered the first exponent rule.
    
    #exponent-rules(1)
    
    #v(10pt)
    Give this question a try.
    
    #findx("a^1 * a^2 * a^3 = a^#text(size: 0.65em, $display(x/2)$)")
])

#dialogue-item(speaker: "Kaylee", [
    Multiplying means add.
    
    #answerx($1 + 2 + 3 = display(x/2)$, 12)
])

#dialogue-item(speaker: "Kloe", [

    #emoji-icon("muscle")
    
    Try this one.
    
    #findx("a^x * b = a^(4x)", target: "b")
])

#dialogue-item(speaker: "Kaylee", [
    I dont know Kloe. Can you tell me the answer?
])

#dialogue-item(speaker: "Kloe", [
    #give-answer("a^(3x)", target: "b")
])

#dialogue-item(speaker: "Kaylee", [
    How come?
])

#dialogue-item(speaker: "Kloe", [
    Because $a^#xblue($1x$) #xdot() a^(#xblue($3x$)) #xarrow() a^(#xblue($4x$))$.
    
    #v(10pt)
    $x + 3x = 4x$
])

#dialogue-item(speaker: "Kaylee", [
    Give me another one Kloe!
])

#dialogue-item(speaker: "Kloe", [
    #findx("a^x * b * b = a^(4x)", target: "b")
])

#dialogue-item(speaker: "Kaylee", [
    There's 2 $b$'s this time!
    
    #v(10pt)
    Hmm...
    
    #v(10pt)
    $
        x + b + b &= 4x\
        2b &= 3x\
        b &= display((3x)/2)\
    $
    
    #v(10pt)
    Does $b$ equal #boxed($1.5x$)?
])

#dialogue-item(speaker: "Kloe", [
    With a base of $a$.
])

#dialogue-item(speaker: "Kaylee", [
    The final answer is #answer-box(label: "b", "$a^1.5$")
])

#dialogue-item(speaker: "Kloe", [
    That's perfect Kaylee.

    Sometimes, you're just solving for the power, and you don't need the base.\
    But in this one, you're solving for the whole thing so you do need it.
])

#dialogue-item(speaker: "Kaylee", [
    Kloe.
])

#dialogue-item(speaker: "Kloe", [
    Yes my dear?
])

#dialogue-item(speaker: "Kaylee", [
    Exponents feel easy and hard at the same time.
])

#dialogue-item(speaker: "Kloe", [
    That's because exponents combine together a lot of ideas.\
    Soon we will put fractions into exponents.
])

#dialogue-item(speaker: "Kaylee", [
    Can you do that?
])

#dialogue-item(speaker: "Kloe", [
    And soon we will put exponents into our exponents! #emoji-icon("dancer")
])

#dialogue-item(speaker: "Kaylee", [
    Stop it Kloe!
])

#dialogue-item(speaker: "Kloe", [
    Just wait Kaylee. You are going to really like exponents. #emoji-icon("smile")
])

