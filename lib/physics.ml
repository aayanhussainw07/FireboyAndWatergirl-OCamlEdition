open Player
open Input
open Level

let reference_fps = 60.0
let gravity = 0.5 *. reference_fps *. reference_fps
let jump_force = 12.0 *. reference_fps
let speed = 2.0 *. reference_fps
let friction = 0.3 *. reference_fps *. reference_fps

let tile_size = 40.
let player_w = 20.
let player_h = 30.

let apply_friction vx dt =
  let drag = friction *. dt in
  if vx > drag then vx -. drag
  else if vx < -.drag then vx +. drag
  else 0.0

let is_solid = function
  | Empty -> false
  | _ -> true

let tile_at (level : Level.t) tx ty =
  if ty < 0 || ty >= Array.length level.grid then Wall
  else if tx < 0 || tx >= Array.length level.grid.(ty) then Wall
  else level.grid.(ty).(tx)

let collides level x y =
  let left = int_of_float (x /. tile_size) in
  let right = int_of_float ((x +. player_w -. 1.) /. tile_size) in
  let bottom = int_of_float (y /. tile_size) in
  let top = int_of_float ((y +. player_h -. 1.) /. tile_size) in

  is_solid (tile_at level left bottom)
  || is_solid (tile_at level right bottom)
  || is_solid (tile_at level left top)
  || is_solid (tile_at level right top)

let update dt level (p : player) (k : keys) : player =
  let vx =
    if k.right && not k.left then speed
    else if k.left && not k.right then -.speed
    else if not p.on_ground then p.vx
    else apply_friction p.vx dt
  in

  (* Horizontal movement *)
  let new_x = p.x +. (vx *. dt) in
  let x, vx =
    if collides level new_x p.y then p.x, 0.
    else new_x, vx
  in

  (* Vertical movement *)
  let vy =
    if k.jump_pressed && p.on_ground then jump_force
    else p.vy
  in
  let vy = vy -. (gravity *. dt) in
  let new_y = p.y +. (vy *. dt) in

  let y, vy, on_ground =
    if collides level x new_y then
      if vy < 0. then
        (* landing on top of a tile *)
        let tile_y = Float.floor (new_y /. tile_size) in
        ((tile_y +. 1.) *. tile_size, 0., true)
      else
        (* hitting ceiling *)
        (p.y, 0., false)
    else
      (new_y, vy, false)
  in

  { p with x; y; vx; vy; on_ground }