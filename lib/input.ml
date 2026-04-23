type keys = {
  left : bool;
  right : bool;
  jump : bool;
}

let last_seen = Hashtbl.create 10
let frame = ref 0

let drain () =
  incr frame;
  while Graphics.key_pressed () do
    let k = Graphics.read_key () in
    Hashtbl.replace last_seen k !frame
  done

let is_held k =
  match Hashtbl.find_opt last_seen k with
  | Some f when !frame - f <= 30 -> true
  | _ -> false

let poll_fireboy () =
  { left = is_held 'j'; right = is_held 'l'; jump = is_held 'i' }
