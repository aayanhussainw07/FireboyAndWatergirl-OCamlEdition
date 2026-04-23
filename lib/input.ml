type keys = {
  left : bool;
  right : bool;
  jump : bool;
}

let rec drain acc =
  if Graphics.key_pressed () then drain (Graphics.read_key () :: acc) else acc

let poll_fireboy held =
  {
    left = List.mem 'j' held;
    right = List.mem 'l' held;
    jump = List.mem 'i' held;
  }
