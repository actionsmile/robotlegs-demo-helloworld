/**
 * Copyright (c) 2009-2013 the original author or authors
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package robotlegs.bender.demos.simpleapp.view.api {
	import flash.text.TextField;
	import fl.controls.Button;

	import flash.display.DisplayObject;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public interface ISimpleView {
		/**
		 * Creates all nessesary environment for proper object lifecycle, if it not created yet
		 * @return void
		 * @see #dispose()
		 */
		function create() : void;
		
		/**
		 * Prepare object for garbage collector by destroying all created variables
		 * @return void
		 * @see #create()
		 */
		function dispose() : void;
		
		/**
		 * Return display object, that will be added to application holder display list
		 */
		function get view() : DisplayObject;
		
		/**
		 * Return button instance. Mediator subscribes to 'click' event, and invokes <code>createBubble();</code> method
		 */
		function get addBubbleButton() : Button;
		
		/**
		 * Return textfield instance. Debug mediator will change it default text (which says,
		 * that you're using non-debug version of app) to reveal, that <code>OnlyIfDebugVersionLaunched</code> guard
		 * approved mediatong of <code>ISimpleView</code>
		 */
		function get textfield() : TextField;
		
		/**
		 * Creates bubble with random radius and random position
		 * @return void
		 */
		function createBubble() : void;
	}
}
