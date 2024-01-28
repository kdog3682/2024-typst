#set page(width: 200pt, height: auto)
#set enum(numbering: "I.A.1.")
#set page(height: 2in)
#set list(marker: ([•], [--]))
#set page(width: 300pt, height: 300pt, background: rect(fill: white, width: 100%, height: 100%))
#set page(width: auto, height: auto, margin: .5cm)
#set page(width: 120pt, height: 200pt, margin: 5pt)
#set text(size: 6pt)
#set page(width: 200pt, height: 400pt, margin: 10pt)
#set page(..styles.auto-page)

write a vimscript function for colon keypress
when colon is pressed,
search the current line and 5 lines for a function call like table(
if the preceeding word is in the table ref, replace the preceeding word with the value, append a colon, and start a completion function for the possible insertions

example: 

  table(
    word1
    word1
    word1
    h
    h
    replacement1: option2,
    replacement1: option3,
    replacement1: option2,
    replacement1: 
    replacement1: 
    replacement1: 
  )

#{
  let items = step(60)
  table(
    columns 6 rows 6
    columns: 6,
    rows
    r:
  )
  table(
    columns: 6,
    rows: 6,
    **items
  )
}
#{
  let items = 
}

" Dictionary mapping words to their replacements
let g:table_ref = {'word1': 'replacement1', 'word2': 'replacement2'}


inoremap <buffer> <expr> ; CustomColonCommand()
word1
word1
replacement1: option1,
r0
