open Player
open Input

let reference_fps = 60.0
let gravity = 0.5 *. reference_fps *. reference_fps
let jump_force = 12.0 *. reference_fps
let speed = 2.0 *. reference_fps
let friction = 0.3 *. reference_fps *. reference_fps

let apply_friction vx dt =
  let drag = friction *. dt in
  if vx > drag then vx -. drag
  else if vx < -.drag then vx +. drag
  else 0.0

let update dt (p : player) (k : keys) : player =
  (* calculating horizontal velocity *)
  let vx =
    if k.right && not k.left then speed
    else if k.left && not k.right then -.speed
    else if not p.on_ground then p.vx
    else apply_friction p.vx dt
  in
  let x = p.x +. (vx *. dt) in

  (* calculating vertical velocity*)
  let vy = if k.jump_pressed && p.on_ground then jump_force else p.vy in
  let vy = vy -. (gravity *. dt) in
  let y = p.y +. (vy *. dt) in
  let y, vy, on_ground = if y <= 10. then (10., 0., true) else (y, vy, false) in

  { p with x; vx; y; vy; on_ground }
