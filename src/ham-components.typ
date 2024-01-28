#import "util.typ": *

#let ham-title-1(s, tags: none) = {
  if exists(tags) {
    cr-flex-row(
        heading(s),
        cr-hash-tags(tags)
    )
    line(length: 100%)
  } 

  else if exists(tags) {
      
  } 

  else {
    heading(s)
    line(length: 100%)
  }
}

