package main

import (
	"log"
	"syscall/js"
)

func InstallJSFunc(m *Manager) {
	g := js.Global().Get("window")
	g.Set(
		callbackName,
		js.FuncOf(
			func(this js.Value, args []js.Value) interface{} {
				log.Printf("Called: %v(%v)", this, args)
				log.Printf("Called: %v(%v), but why", this, args)
				m.isLoggedIn = true
				m.Update()
				return nil
			}))
}
