type draw_call = unit -> unit

let queue : draw_call list ref = ref []

let clear () =
  queue := []

let add f =
  queue := f :: !queue

let flush () =
  !queue
  |> List.rev
  |> List.iter (fun draw -> draw ())