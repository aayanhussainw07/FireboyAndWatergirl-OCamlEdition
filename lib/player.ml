type character =
  | Fireboy
  | Watergirl

type player = {
  x : float;
  y : float;
  on_ground : bool;
  character : character;
  alive : bool;
}
