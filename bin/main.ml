open Teamproject

let () =
  (* Define's fireboy*)
  let fireboy =
    ref
      {
        Player.x = 100.;
        y = 100.;
        vx = 0.;
        vy = 0.;
        on_ground = false;
        character = Player.Fireboy;
        alive = true;
      }
  in

  (* Opens up a window. *)
  Graphics.open_graph " 1200x700";
  Graphics.set_window_title "Fireboy & Watergirl";
  Graphics.auto_synchronize false;
  let running = ref true in
  while !running do
    Graphics.clear_graph ();
    Input.drain ();

    let fb_keys = Input.poll_fireboy () in
    fireboy := Physics.update !fireboy fb_keys;

    Render.draw_player !fireboy;

    Graphics.synchronize ();

    if Input.is_held 'q' then running := false
  done
