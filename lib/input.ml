type keys = {
  left : bool;
  right : bool;
  jump_pressed : bool;
}

external key_down : char -> bool = "teamproject_key_down"

type snapshot = {
  left : bool;
  right : bool;
  jump : bool;
  quit : bool;
}

let empty = { left = false; right = false; jump = false; quit = false }

let current = ref empty
let previous = ref empty

let sample () =
  {
    left = key_down 'j';
    right = key_down 'l';
    jump = key_down 'i';
    quit = key_down 'q';
  }

let drain () =
  previous := !current;
  while Graphics.key_pressed () do
    ignore (Graphics.read_key ())
  done;
  current := sample ()

let is_held k =
  match k with
  | 'j' -> !current.left
  | 'l' -> !current.right
  | 'i' -> !current.jump
  | 'q' -> !current.quit
  | _ -> false

let poll_fireboy () =
  {
    left = !current.left;
    right = !current.right;
    jump_pressed = !current.jump && not !previous.jump;
  }
