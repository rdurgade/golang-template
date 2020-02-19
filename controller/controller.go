package controller

// Controller example
type Controller struct {
}

// NewController example
func NewController() *Controller {
	return &Controller{}
}

// Message example
type Message struct {
	Message string `json:"message" example:"message"`
}

// Ver Version number set by main.go
var version = "Undefined"

// Bld Build number set by main.go
var build = "Undefined"

// SetBldVer sets the build and version variables
func (c *Controller) SetBldVer(ver, bld string) {
	version = ver
	build = bld
}
