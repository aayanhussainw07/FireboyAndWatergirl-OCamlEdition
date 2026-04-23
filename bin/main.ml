let () =
    (* Opens up a window. *)
    Graphics.open_graph " 1200x700";
    Graphics.set_window_title "Fireboy & Watergirl";
    Graphics.auto_synchronize false;
    let running = ref true in
    while !running do
        Graphics.clear_graph ();

        (* Draw game objects. *)
        Graphics.set_color Graphics.red;
        Graphics.fill_rect 100 100 50 50;

        Graphics.synchronize ();
        if Graphics.key_pressed () then
            match Graphics.read_key () with
            (* Closes window with q *)
            | 'q' -> running := false
            | _ -> ()
    done