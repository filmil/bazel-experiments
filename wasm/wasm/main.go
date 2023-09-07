// main based on https://github.com/grahamjenson/bazel-golang-wasm-proto
package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"strconv"
	"time"

	"github.com/maxence-charriere/go-app/v9/pkg/app"
	"golang.org/x/oauth2"
	_ "golang.org/x/oauth2/google"
	"google.golang.org/api/option"
	"google.golang.org/api/sheets/v4"
)

var (
	bootstrapLoc = flag.String("bootstrap-css-path", "", "path to the bootstrap.css file")
	wasmLoc      = flag.String("wasm-path", "", "path to the web app wasm file")
	iconLoc      = flag.String("icon-path", "", "path to the icon")
	port         = flag.Int("port", 7000, "default port to use")
)

type Manager struct {
	app.Compo

	Token string
}

const (
	clientID     = `841378387526-qn3965fuan6b08os2pf33ul3lqr800dn.apps.googleusercontent.com`
	callbackName = "sigCallback"

	httpURL = `https://accounts.google.com/o/oauth2/v2/auth`

	sheetScope = `https://www.googleapis.com/auth/spreadsheets.readonly`

	redirURL = `http://localhost:7000/foobar`
	//redirURL = `urn:ietf:wg:oauth:2.0:oob`

	sheet = `1C9FSpbNYMX-7MsP5IDhmmIMqCDoHwClvY6dVWMIk1ic`
)

func (m *Manager) Render() app.UI {
	u, _ := url.Parse(httpURL)
	q := u.Query()
	q.Set("client_id", clientID)
	q.Set("response_type", "token")
	q.Set("scope", sheetScope)
	q.Set("state", "imsayingsomething")
	q.Set("redirect_uri", redirURL)
	u.RawQuery = q.Encode()
	return app.Main().Body(
		app.Hr(),
		app.If(
			m.Token == "",
			app.A().
				Text("Log In").
				Href(u.String()),
		).Else(
			app.A().
				Text(fmt.Sprintf("Logged In: %v", m.Token)),
		),
		app.Hr(),
	)
}

func (m *Manager) OnMount(ctx app.Context) {
	ctx.ObserveState("/login").Value(&m.Token)
	t := m.Token
	config := &oauth2.Config{}
	sheetsService, err := sheets.NewService(ctx, option.WithTokenSource(config.TokenSource(ctx, t)))
	if err != nil {
		log.Printf("this is an error: %v", err)
	}
}

type Login struct {
	app.Compo
}

func (l *Login) Render() app.UI {
	return app.Main()
}

func (l *Login) OnMount(ctx app.Context) {
	w := app.Window()
	v, _ := url.ParseQuery(w.URL().Fragment)
	re, _ := strconv.Atoi(v.Get("expires_in"))
	exp := time.Duration(re) * time.Second
	t := v.Get("access_token")
	log.Printf("OnMount: re: %v, t: %v", re, t)
	ctx.SetState("/login", t, app.ExpiresIn(exp))
	ctx.Navigate("/")
}

type Header struct {
	name  string
	value string
}

func main() {
	app.RouteFunc("/foobar", func() app.Composer {
		return &Login{}
	})
	app.RouteFunc("/", func() app.Composer {
		return &Manager{}
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
