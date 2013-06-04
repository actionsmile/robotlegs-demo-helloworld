package robotlegs.bender.demos.simpleapp {
	import robotlegs.bender.bundles.DemoBundle;
	import robotlegs.bender.demos.simpleapp.controller.appconfig.SimpleAppLaunch;
	import robotlegs.bender.demos.simpleapp.controller.appconfig.SimpleAppPrepare;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import flash.display.Sprite;
	import flash.events.Event;

	public class RL2SimpleApplication extends Sprite {
		/**
		 * @private
		 */
		private var context : IContext;
		/**
		 * @private
		 */
		private var appHolder : Sprite;

		public function RL2SimpleApplication() {
			this.stage ? this.init() : this.waitForStage();
		}
		
		/**
		 * @private application initialization
		 * @return void
		 */
		private function init() : void {
			this.appHolder = new Sprite();
			this.context = new	Context().
								install(DemoBundle).
								configure(new ContextView(this.appHolder), SimpleAppPrepare).
								afterInitializing(this.onContextInitedHandler);
			this.context.initialized && this.onContextInitedHandler();
			this.addChild(this.appHolder);
		}
		
		/**
		 * @private waiting for stage
		 * @return void
		 */
		private function waitForStage() : void {
			this.addEventListener(Event.ADDED_TO_STAGE, this.onStageAppearHandler);
		}
		
		//	Handlers
		/**
		 * @eventType flash.events.Event.ADDED_TO_STAGE
		 */
		private function onStageAppearHandler(event : Event) : void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onStageAppearHandler);
			this.init();
		}

		/**
		 * @private <code>IContext</code> inited. Lets launch this app
		 */
		private function onContextInitedHandler() : void {
			this.context.configure(SimpleAppLaunch);
		}
	}
}