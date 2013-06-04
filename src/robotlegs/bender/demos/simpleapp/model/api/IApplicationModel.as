// ------------------------------------------------------------------------------
// Copyright &copy; 2013 the original author or authors. All Rights Reserved.
//
// NOTICE: You are permitted to use, modify, and distribute this file
// in accordance with the terms of the license agreement accompanying it.
// ------------------------------------------------------------------------------
package robotlegs.bender.demos.simpleapp.model.api {
	/**
	 * @playerversion			Adobe Flashplayer 11.1 or higher
	 * @langversion				Actionscript 3.0
	 * @author					Aziz Zaynutdinov (aziz.zaynutdinoff at gmail.com)
	 */
	public interface IApplicationModel {
		/**
		 * Adds varibale to model by name
		 * @param variableName name of the varibale
		 * @param value value of the varibale
		 * @return void
		 */
		function setVariable(variableName : String, value : *) : void;

		/**
		 * Returns varible value by name
		 * @param variableName name of the varibale
		 * @return value for <code>variableName</code>
		 */
		function getVariable(variableName : String) : *;

		/**
		 * Removes varibale from model by name
		 * @param variableName name of the varibale
		 * @return <code>true</code>, if removing was successful
		 */
		function removeVariable(variableName : String) : Boolean;

		function get variables() : Vector.<String>;
	}
}
