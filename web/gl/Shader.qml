Object {
	constructor: {
		if (!this.parent || !this.parent.gl) {
			log("Place 'VertexShader' in 'GlContext'")
			return
		}

		this._gl = gl = this.parent.gl
	}

	createImpl(sourceCode, type): {
		var gl = this._gl
		var shader = gl.createShader(type)
		gl.shaderSource(shader, sourceCode)
		gl.compileShader(shader)

		if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
			var info = gl.getShaderInfoLog(shader)
			throw 'Could not compile WebGL program: ' + info
		}
		return shader
	}
}