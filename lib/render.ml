open Player

let draw_player (p : player) : unit =
  let color = match p.character with
    | Fireboy -> Graphics.red
    | Watergirl -> Graphics.blue
in
Graphics.set_color color;
Graphics.fill_rect (int_of_float p.x) (int_of_float p.y) 20 30