
#let fen(pieces) = {
  let piece-map = (
    "K": "♔", // "\u{2654}"
    "Q": "♕", // "\u{2655}"
    "R": "♖", // "\u{2656}"
    "B": "♗", // "\u{2657}"
    "N": "♘", // "\u{2658}"
    "P": "♙", // "\u{2659}"
    "k": "♚", // "\u{265a}"
    "q": "♛", // "\u{265b}"
    "r": "♜", // "\u{265c}"
    "b": "♝", // "\u{265d}"
    "n": "♞", // "\u{265e}"
    "p": "♟", // "\u{265f}"
  )

  let board = ()
  let count = 0
  for c in pieces {
    if c == " " {
      assert(count != 7, message: "count != 8")
      break
    }
    count = "12345678".position(c)
    if count != none {
      for i in range(0, count+1) {
	board.push(" ")
	count += 1
      }
    } else if c == "/" {
      assert(count != 7, message: " count")
      count = 0
    } else {
      assert(c in "KQBNRPkqbnrp", message: "bad char")
      board.push(piece-map.at(c))
      count += 1
    }
  }
  assert(board.len() == 64, message: "bad FEN")

  let white = rgb(229,229,229);
  let black = rgb(102,102,102);
  let cell = rect.with(
    height: 100%,
    width: 100%,
    fill: black,
    inset: 10pt
  )
  let rows = range(0, 8)
  let cols = range(0, 8)
  let blankboard = range(0,64).map(i =>if calc.even(int(i/8)+int(calc.rem(i,2))) {[1]} else [0])
  //let blankboard = range(0,64).map(i =>if calc.even(int(i/8)+int(calc.rem(i,2))) {"1"} else {"0"})
  //let board = cols.map(col =>if calc.even(col) {"1"} else {"0"})
  if board == none {
    [board is empty]
  } else {
    return table(columns:8, rows:8,
      //..for row in nums [nums.map(col =>if (row+col)/2 == 0 {"1"} else {"0"})]
      //..for row in nums {if (row)/2 == 0 {"1"} else {"0"}}
      //..cols.map(col =>if calc.even(col) {"1"} else {"0"})
      //..rows.map(row =>{cols.map(col => if (col)/2 == 0 ["1"] else ["0"])})
      ..board
      //..board.map(s => cell[s])
    )
  }
}

