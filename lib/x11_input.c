#include <X11/Xlib.h>

#include <caml/mlvalues.h>

static Display *display = NULL;

static Display *get_display(void) {
  if (display == NULL) {
    display = XOpenDisplay(NULL);
  }
  return display;
}

CAMLprim value teamproject_key_down(value key_value) {
  Display *dpy = get_display();

  if (dpy == NULL) {
    return Val_false;
  }

  unsigned char key = (unsigned char)Int_val(key_value);
  KeyCode code = XKeysymToKeycode(dpy, (KeySym)key);

  if (code == 0) {
    return Val_false;
  }

  char keyboard_state[32];
  XQueryKeymap(dpy, keyboard_state);

  return Val_bool(
      (((unsigned char)keyboard_state[code / 8]) & (1u << (code % 8))) != 0);
}
