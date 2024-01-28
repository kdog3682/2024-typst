// /home/kdog3682/2024/foo.pdf
0
// /home/kdog3682/2024/test.pdf
// /home/kdog3682/2023/test.pdf
// /home/kdog3682/2023/fs-watch.js
// /home/kdog3682/2023/fs-watch.html
#set page(width: 120pt, height: 200pt, margin: 5pt)
#set text(size: 6pt)
howdy 1
howdy 1
howdy 1
howdy 1

documentation:
  there is live polling every second to retrieve the state from the test.pdf

  it is necessary for some reason to use /abc for localhost. otherwise it bugs out
setting up a local pdf server
"end of line
// #let a = [#box(width: 2pt, [hi])].fields().body.fields()
let wrap(content, wrapping: " ") = {
  let a = [ ]
  a + [#content] + a
}

#let colored(x, fill: blue) = {
  return text(fill , weight: "bold", str(x))
}
for i in step(1, 5) {
  let palette = (red, blue, green, green, red, blue)
  let exp = colored(i, fill: palette.at(i))
  $x^#exp$
  if (i < 5) {
    wrap($dot$)
  } else {

  }
}


let hide_answer(it) = {
  let test = true
  if test {
    show "answer": ""
    it
  } else {
    it
  }
  // is there a way to access a count?
}
show: hide_answer
parbreak()
[answer]


}


#set page(width: 200pt, height: 400pt, margin: 10pt)

#let center-title(name) = {
  let content = align(left)[*#name*]
  return align(center, heading(content))
}

#center-title("Ivy's Cakes")

#line(length: 180pt, stroke: 0.1pt)



#{
  let resolve-pt(n) = {
    if type(n) == "integer" {
      return eval(str(n) + "pt")
    }
    return n
  }
  let rec(w, h, ..) = {
    let opts = (fill: yellow, stroke: black)
    rect(width: resolve-pt(w), height: resolve-pt(h), ..opts)
  }
  let typst-place = place
  let place(x, y, content) = {
    return typst-place(dx: resolve-pt(x), dy: resolve-pt(y), content)
  }
  let r1 = rec(30, 40)
  place(0,0, r1)
  place(50,50, r1)
}

// sdf
// sasd
// asd
// 
// 
// 















// 
// 
// 
// 
// 
// 
// 
// 



if foo{
}
if foo {
}

if foo  
if foo  
if fo {
    asdasd
    for item in items {
        
    }
}
if fo {

}
G


        call input(string("aaa"))
/a=/ 

m

do
dp

dp
dp
