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
package robotlegs.bender.demos.simpleapp.view.impl {
	import fl.controls.Button;

	import robotlegs.bender.demos.simpleapp.view.api.ISimpleView;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class SimpleView extends Sprite implements ISimpleView {
		/**
		 * @private if <code>true</code> object is created
		 */
		private var isCreated : Boolean;
		/**
		 * @private bubble container
		 */
		private var _bubbleHolder : Sprite;
		/**
		 * @private button which 
		 */
		private var _addBubbleButton : Button;
		/**
		 * @private some text information holder
		 */
		private var _textfield : TextField;

		public function SimpleView(autoCreate : Boolean = true) {
			autoCreate && this.create();
		}

		/**
		 * @inheritDoc
		 */
		public function create() : void {
			if (!this.isCreated) {
				this._bubbleHolder = new Sprite();

				this.addBubbleButton.label = "Add Bubble";
				this.addBubbleButton.x = this.addBubbleButton.y = this.textfield.y = 10;

				this.textfield.autoSize = TextFieldAutoSize.LEFT;
				this.textfield.wordWrap = false;
				this.textfield.multiline = false;
				this.textfield.x = this.addBubbleButton.x + this.addBubbleButton.width + 10;
				this.textfield.text = "You are using non-debug version";

				this.addChild(this._bubbleHolder);
				this.addChild(this.addBubbleButton);
				this.addChild(this.textfield);
				this.isCreated = true;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function dispose() : void {
			if (this.isCreated) {
				// If <code>this._bubbleHolder</code> exists and has parent,
				// then remove from parent display object container, remove all children
				// and set the value to null
				if (this._bubbleHolder) {
					this.removeParentFrom(this._bubbleHolder);
					while (this._bubbleHolder.numChildren > 0) this._bubbleHolder.removeChildAt(0);
					this._bubbleHolder = null;
				}
				this.removeParentFrom(this.addBubbleButton);
				this.removeParentFrom(this.textfield);
				this._textfield = null;
				this._addBubbleButton = null;
				this.isCreated = false;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function get view() : DisplayObject {
			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function createBubble() : void {
			var bubble : Shape = new Shape();
			bubble.graphics.beginFill(Math.random() * 0xffffff);
			bubble.graphics.drawCircle(0, 0, Math.floor(Math.random() * 15) + 5);
			bubble.x = Math.random() * (this.stage ? this.stage.stageWidth : 400);
			bubble.y = Math.random() * (this.stage ? this.stage.stageHeight : 500);
			this._bubbleHolder.addChild(bubble);
		}

		/**
		 * @inheritDoc
		 */
		public function get addBubbleButton() : Button {
			// lazy instantiation
			return this._addBubbleButton ||= new Button();
		}

		/**
		 * @inheritDoc
		 */
		public function get textfield() : TextField {
			// lazy instantiation
			return this._textfield ||= new TextField();
		}

		/**
		 * @private if passed object not equal to null and has parent, then
		 * method removes object from his parent
		 * @param object
		 * @return void
		 */
		private function removeParentFrom(object : DisplayObject) : void {
			object && object.parent && object.parent.removeChild(object);
		}
	}
}
