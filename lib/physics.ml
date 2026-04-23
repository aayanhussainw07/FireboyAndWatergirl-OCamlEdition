open Player
open Input

let gravity = 0.5
let jump_force = 12.0
let speed = 2.0
let friction = 0.3

let update (p : player) (k : keys) : player =
  (* calculating horizontal velocity *)
  let vx =
    if k.right then speed
    else if k.left then -.speed
    else if not p.on_ground then p.vx
    else if p.vx > 0.5 then p.vx -. friction
    else if p.vx < -0.5 then p.vx +. friction
    else 0.
  in
  let x = p.x +. vx in

  (* calculating vertical velocity*)
  let vy = if k.jump && p.on_ground then jump_force else p.vy in
  let vy = vy -. gravity in
  let y = p.y +. vy in
  let y, vy, on_ground = if y <= 10. then (10., 0., true) else (y, vy, false) in

  { p with x; vx; y; vy; on_ground }
