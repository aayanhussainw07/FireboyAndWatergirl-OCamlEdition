type character =
  | Fireboy
  | Watergirl

type player = {
  x : float;
  y : float;
  vx : float;
  vy : float;
  on_ground : bool;
  character : character;
  alive : bool;
}
