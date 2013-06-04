// ------------------------------------------------------------------------------
// Copyright &copy; 2013 the original author or authors. All Rights Reserved.
//
// NOTICE: You are permitted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// ------------------------------------------------------------------------------
package robotlegs.bender.demos.simpleapp.model.impl {
	import robotlegs.bender.demos.simpleapp.model.api.IApplicationModel;

	import flash.utils.Dictionary;

	/**
	 * @playerversion			Adobe Flashplayer 11.1 or higher
	 * @langversion				Actionscript 3.0
	 * @author					Aziz Zaynutdinov (aziz.zaynutdinoff at gmail.com)
	 */
	public class ApplicationModel implements IApplicationModel {
		private var _model : Dictionary = new Dictionary();
		private var _list : Vector.<String> = new Vector.<String>();

		/**
		 * @inheritDoc
		 */
		public function setVariable(variableName : String, value : *) : void {
			this._list.push(variableName);
			this._model[variableName] = value;
		}

		/**
		 * @inheritDoc
		 */
		public function getVariable(variableName : String) : * {
			return this._model[variableName];
		}

		/**
		 * @inheritDoc
		 */
		public function removeVariable(variableName : String) : Boolean {
			var result : Boolean = (this._model[variableName] != undefined || this._model[variableName] != null);
			var index : int = this._list.indexOf(variableName);
			if (index > 0) {
				this._list.splice(index, 1);
				delete this._model[variableName];
			}
			return result;
		}

		/**
		 * @inheritDoc
		 */
		public function get variables() : Vector.<String> {
			return this._list;
		}
	}
}
