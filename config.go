package main

import "github.com/namsral/flag"

type Config struct {
	Root          string
	WebRoot       string
	StaticRoot    string
	ThumbnailRoot string
	Address       string
	XMLHeader     string
}

var conf Config

func (c *Config) Parse() {
	flag.StringVar(&conf.Address, "address", ":8741", "address")
	flag.StringVar(&conf.Root, "root", "./", "galleryroot")
	flag.StringVar(&conf.WebRoot, "webroot", "/", "webroot")
	flag.StringVar(&conf.StaticRoot, "staticroot", "/static/", "staticroot")
	flag.StringVar(&conf.ThumbnailRoot, "thumbnailroot", "/static/.thumbnail/", "thumbnailroot")
	flag.StringVar(&conf.XMLHeader, "xmlheader", "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<?xml-stylesheet type=\"text/xsl\" href=\"listing.xsl\"?>\n", "XML Header")
	flag.Parse()
}
