open Teamproject

let () =
  let target_frame_time = 1. /. 60. in
  let max_dt = 1. /. 20. in

  Graphics.open_graph " 1200x700";
  Graphics.set_window_title "Fireboy & Watergirl";
  Graphics.auto_synchronize false;

  let game = ref (Game.init Level.sample_level) in
  let last_frame = ref (Unix.gettimeofday ()) in
  let running = ref true in

  while !running do
    let frame_start = Unix.gettimeofday () in
    let dt = Float.min (frame_start -. !last_frame) max_dt in
    last_frame := frame_start;

    Graphics.clear_graph ();
    Input.drain ();

    let fb_keys = Input.poll_fireboy () in
    let wg_keys = Input.poll_watergirl () in
    game := Game.tick dt !game fb_keys wg_keys;

    Game.render !game;

    Graphics.synchronize ();

    if Input.is_held 'q' then running := false;

    let frame_elapsed = Unix.gettimeofday () -. frame_start in
    if frame_elapsed < target_frame_time then
      Unix.sleepf (target_frame_time -. frame_elapsed)
  done