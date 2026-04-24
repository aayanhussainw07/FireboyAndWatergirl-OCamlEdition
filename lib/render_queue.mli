type draw_call = unit -> unit

val clear : unit -> unit
val add : draw_call -> unit
val flush : unit -> unit