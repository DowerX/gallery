package main

import (
	"encoding/xml"
	"io/ioutil"
)

type Element struct {
	StaticPath    string    `xml:"staticpath,attr"`
	WebPath       string    `xml:"webpath,attr"`
	ThumbnailPath string    `xml:"thumbnailpath,attr"`
	Type          string    `xml:"type,attr"`
	Children      []Element `xml:"Element"`
}

func (dir Element) ToXML(header string) []byte {
	data, err := xml.MarshalIndent(dir, "", "\t")
	if err != nil {
		panic(err)
	}
	return append([]byte(header), data...)
}

func ListDirectory(path string, webroot string, staticroot string, thumbnailroot string) Element {
	if path[len(path)-1] != '/' {
		path += "/"
	}

	dir := Element{
		StaticPath: "",
		WebPath:    "/" + path,
		Type:       "dir",
	}
	nodes, err := ioutil.ReadDir(path)
	if err != nil {
		return Element{}
	}
	for _, node := range nodes {
		tmp := Element{}
		if node.IsDir() {
			tmp.Type = "dir"
			tmp.WebPath = webroot + path + node.Name()

		} else {
			tmp.Type = "file"
			tmp.StaticPath = staticroot + path + node.Name()
			tmp.ThumbnailPath = thumbnailroot + path + node.Name()
		}
		dir.Children = append(dir.Children, tmp)
	}
	return dir
}
