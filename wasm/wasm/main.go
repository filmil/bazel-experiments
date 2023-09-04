// main based on https://github.com/grahamjenson/bazel-golang-wasm-proto
package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"

	"github.com/maxence-charriere/go-app/v9/pkg/app"
)

var (
	bootstrapLoc = flag.String("bootstrap-css-path", "", "path to the bootstrap.css file")
	wasmLoc      = flag.String("wasm-path", "", "path to the web app wasm file")
	iconLoc      = flag.String("icon-path", "", "path to the icon")
	port         = flag.Int("port", 7000, "default port to use")
)

type Manager struct {
	app.Compo

	isLoggedIn bool
}

const (
	clientID     = `841378387526-qn3965fuan6b08os2pf33ul3lqr800dn.apps.googleusercontent.com`
	callbackName = "sigCallback"
)

func (m *Manager) Render() app.UI {
	return app.Main().Body(
		app.Hr(),
		app.Span().Text(fmt.Sprintf("Hi! isLoggedIn: %v", m.isLoggedIn)),
		app.Hr(),
		app.Div().
			ID("g_id_onload").
			DataSet("client_id", clientID).
			DataSet("context", "signin").
			DataSet("callback", callbackName).
			DataSet("auto_prompt", "true"),
		app.Div().
			Class("g_id_signin").
			DataSet("type", "standard").
			DataSet("shape", "rectangular").
			DataSet("theme", "outline").
			DataSet("text", "signin").
			DataSet("logo_alignment", "left"),
		app.Hr(),
	)
}

type Header struct {
	name  string
	value string
}

func main() {
	app.RouteFunc("/", func() app.Composer {
		m := Manager{}
		InstallJSFunc(&m)
		return &m
	})
	app.RunWhenOnBrowser()
	flag.Parse()
	if *bootstrapLoc == "" {
		log.Fatalf("The flag --bootstrap-css-path is required.")
	}
	if *wasmLoc == "" {
		log.Fatalf("The flag --bootstrap-css-path is required.")
	}
	app := &app.Handler{
		Title:  "Test",
		Author: "A. U. Thor",
		Styles: []string{"/web/bootstrap.css"},
		Icon: app.Icon{
			Default: "/web/icon.png",
		},
		RawHeaders: []string{
			`<script src="https://accounts.google.com/gsi/client" async defer></script>`,
			`<script>
				window.sigCallback = () => {
					console.log("alert!")
				}
			</script>`,
		},
	}

	mux := http.NewServeMux()

	ServeFile(mux, "/web/app.wasm", *wasmLoc)
	ServeFile(mux, "/web/icon.png", *iconLoc)
	ServeFile(mux, "/web/bootstrap.css", *bootstrapLoc,
		Header{name: "Content-Type", value: "text/css"})
	mux.Handle("/", app)
	log.Printf("starting local server on http://localhost:%v\n", *port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%v", *port), mux))
}

func ServeFile(mux *http.ServeMux, servePath string, filePath string, headers ...Header) {
	mux.HandleFunc(servePath, func(w http.ResponseWriter, r *http.Request) {
		log.Printf("handling %v -> %v\n", servePath, filePath)
		for _, h := range headers {
			r.Header.Add(h.name, h.value)
		}
		http.ServeFile(w, r, filePath)
	})
}
