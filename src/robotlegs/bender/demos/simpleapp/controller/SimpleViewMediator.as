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
package robotlegs.bender.demos.simpleapp.controller {
	import robotlegs.bender.demos.simpleapp.view.api.ISimpleView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediator;

	import flash.events.MouseEvent;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class SimpleViewMediator implements IMediator {
		[Inject]
		public var example : ISimpleView;

		public function initialize() : void {
			// subscribe to 'click' event of <code>ISimpleView</code>'s addBubbleButton instance
			this.example.addBubbleButton.addEventListener(MouseEvent.CLICK, this.onAddBubbleClickHandler);
		}

		public function destroy() : void {
			// Don't forget to unsubscribe, when view component destroying
			this.example.addBubbleButton.removeEventListener(MouseEvent.CLICK, this.onAddBubbleClickHandler);
			this.example.dispose();
			this.example = null;
		}

		// Handlers
		/**
		 * @eventType flash.events.MouseEvent.CLICK
		 */
		private function onAddBubbleClickHandler(event : MouseEvent) : void {
			this.example.createBubble();
		}
	}
}
