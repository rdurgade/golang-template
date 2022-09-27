package controller

import (
	"${{values.component_id}}/model"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Version godoc
// @Summary version
// @Description Ge Version Information
// @Tags version
// @Accept json
// @Produce json
// @Success 200 {object} model.Version
// @Router /version [get]
func (c *Controller) Version(ctx *gin.Context) {
	V := model.Version{}
	V.Version = version         // Version Variable of controller
	V.Build = build             // Build Variable of controller
	V.ServiceName = serviceName // Name of this REST API Service
	ctx.JSON(http.StatusOK, V)
	return
}
