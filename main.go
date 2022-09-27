package main

import (
	"${{values.component_id}}/controller"
	"${{values.component_id}}/docs"

	"github.com/gin-gonic/gin"

	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

// ServiceName is changed during build
var ServiceName = "undefined"

// Version is changed during build
var Version = "undefined"

// Build is changed during build
var Build = "undefined"

// BasePath is changed during build
var BasePath = "/api"

// SwaggerPath is changed during build
var SwaggerPath = "/swagger"

// Port is changed during build
var Port = "8080"

func main() {
	r := gin.Default()
	setupSwagger()
	setupRoutes(r)
	r.Run(":" + Port)
}

func setupRoutes(r *gin.Engine) {
	c := controller.NewController()

	// Initialize Version abd Build variables of controller
	c.SetBldVer(Version, Build, ServiceName)

	v1 := r.Group(BasePath)
	{
		version := v1.Group("/version")
		{
			version.GET("", c.Version)
		}
	}
	r.NoRoute(func(c *gin.Context) {
		rPath := c.Request.URL.String()
		rMethod := c.Request.Method
		redirectTo := SwaggerPath + "/index.html"
		c.Writer.Write([]byte(get404message(rPath, rMethod, redirectTo)))
	})
	r.GET(SwaggerPath+"/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
}

func setupSwagger() {
	docs.SwaggerInfo.Version = Version
	docs.SwaggerInfo.BasePath = BasePath
}
func get404message(rPath, rMethod, redirectTo string) (rtrn string) {
	rtrn = `<!DOCTYPE html>
    <html lang="en">
    <head>
		<title>${{values.component_id}}</title>
		<script>
		var i = 5;
		var inv = setInterval(function() {
			if(i > 1) {
				document.getElementById("counter").innerHTML = --i;
			}
			else {
				clearInterval(inv);
				window.location.href = '` + redirectTo + `';
			}
		}, 1000);
		</script>
        <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
			width: 100%;
			background-color: lightblue;
        }

        body {
            display: table;
        }

        .msg {
            text-align: center;
            display: table-cell;
            vertical-align: middle;
        }
        </style>
    </head>
	<body>

    <div class="msg">
	<p style="font-size:3vw;"> 404
	<p style="font-size:2vw;"> Path "` + rPath + `" with method "` + rMethod + `" Not Configured</p>
	<p style="font-size:2vw;"> Redirecting to api documentation in <span><span id="counter">5</span> seconds </p>
    </div>
    </body>
</html>`
	return
}

// @title API Docs
// @description This is a ${{values.component_id}} API server.
