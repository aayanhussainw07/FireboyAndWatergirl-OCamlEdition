open Player
open Input

let gravity = 0.5
let jump_force = 12.0

let update (p : player) (k : keys) : player =
  let vy = if k.jump && p.on_ground then jump_force else p.vy in
  let vy = vy -. gravity in
  let y = p.y +. vy in
  let y, vy, on_ground = if y <= 10. then (10., 0., true) else (y, vy, false) in
  { p with y; vy; on_ground }
