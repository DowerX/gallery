package main

import (
	"net/http"
	"path"

	"github.com/gorilla/mux"
)

var router *mux.Router

func Host(address string) {
	router = mux.NewRouter()
	router.PathPrefix("/").HandlerFunc(handleAny)
	http.ListenAndServe(address, router)
}

func handleAny(w http.ResponseWriter, r *http.Request) {
	w.Write(ListDirectory(path.Join(conf.Root, r.URL.Path), conf.WebRoot, conf.StaticRoot, conf.ThumbnailRoot).ToXML(conf.XMLHeader))
}
