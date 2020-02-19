package model

// Version model
type Version struct {
	Version string `json:"version" example:"v0.0.1" format:"string"`
	Build string `json:"build" example:"e669585-20200218215640" format:"string"`
}
