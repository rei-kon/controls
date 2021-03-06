///placeholder adjustment object for inputs
Object {
	property string text;			///< inner text placeholder
	property Color color;			///< placeholder color
	property Font font: PlaceholderFont { }	///< placeholder font

	///@private
	constructor: { this._placeholderClass = '' }

	///@private
	onTextChanged: { this.parent.element.setAttribute('placeholder', value) }

	///@private
	onColorChanged: { this.setPlaceholderColor(value) }

	///@private
	function getClass() {
		var cls
		if (!this._placeholderClass) {
			cls = this._placeholderClass = this._context.stylesheet.allocateClass('input')
			this.parent.element.addClass(cls)
		}
		else
			cls = this._placeholderClass
		return cls
	}

	///@private
	function setPlaceholderColor(color) {
		var cls = this.getClass()

		var rgba = new _globals.core.Color(color).rgba()
		//fixme: port to modernizr
		var selectors = ['::-webkit-input-placeholder', '::-moz-placeholder', ':-moz-placeholder', ':-ms-input-placeholder']
		selectors.forEach(function(selector) {
			try {
				this._context.stylesheet._addRule('.' + cls + selector, 'color: ' + rgba)
				log('added rule for .' + cls + selector)
			} catch(ex) {
				//log(ex)
			}
		}.bind(this))
	}
}
