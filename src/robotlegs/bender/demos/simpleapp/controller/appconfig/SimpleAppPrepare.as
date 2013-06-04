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
package robotlegs.bender.demos.simpleapp.controller.appconfig {
	import me.scriptor.mvc.model.api.IApplicationModel;
	import me.scriptor.mvc.model.impl.ApplicationModel;

	import robotlegs.bender.demos.simpleapp.controller.DebugSimpleViewMediator;
	import robotlegs.bender.demos.simpleapp.controller.SimpleViewMediator;
	import robotlegs.bender.demos.simpleapp.controller.commands.InitStageOptions;
	import robotlegs.bender.demos.simpleapp.controller.commands.LaunchApplication;
	import robotlegs.bender.demos.simpleapp.controller.commands.guards.OnlyIfDebugVersionLaunched;
	import robotlegs.bender.demos.simpleapp.controller.commands.hooks.CreateBubbleHash;
	import robotlegs.bender.demos.simpleapp.events.DemoAppEvent;
	import robotlegs.bender.demos.simpleapp.view.api.ISimpleView;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.matching.TypeMatcher;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IContext;

	import flash.display.Stage;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class SimpleAppPrepare {
		[Inject]
		public var context : IContext;
		[Inject]
		public var contextView : ContextView;
		[Inject]
		public var commandMap : IEventCommandMap;
		[Inject]
		public var mediatorMap : IMediatorMap;

		[PostConstruct]
		public function init() : void {
			// Everytime you want to get <code>IApplicationModel</code>,
			// an instance of ApplicationModel will provides by <code>Injector</code>
			this.context.injector.map(IApplicationModel).toSingleton(ApplicationModel);

			// on <code>IContext</code> initialization application has <code>Stage</code> object, cause
			// we using <code>StageSyncExtension</code>, which invokes <code>context.initialize()</code> method
			// when context view addd to stage.
			this.context.initialized ? this.injectApplicationStage() : this.context.afterInitializing(this.injectApplicationStage);

			// Mapping events to command classes
			// Launching application is require to be handled just once.
			// After 'once' event dispatched, commandMap will automatically unmap it from command class.
			this.commandMap.map(DemoAppEvent.LAUNCH).toCommand(LaunchApplication).once();

			// Mapping view class to mediator. I often use <code>mapMatcher</code> method, cause it more flexible,
			// you don't need to include view class in your application.
			var matcher : TypeMatcher = new TypeMatcher().anyOf(ISimpleView);
			// Hooks are very usefull, they are starts right before command/mediator class execution.
			// I prefer use hooks to create variables, which I'm gonna use in command/mediator class
			this.mediatorMap.mapMatcher(matcher).toMediator(SimpleViewMediator).withHooks(CreateBubbleHash);
			// Another usefull feature is 'guards'. According 'approve'-method return value commandMap/mediatorMap
			// decides to invoke execute/initialize method or not. You can specify conditions for handling
			// event/view. For example, you want to mediate view with logging debug information,
			// only if current player type is debugger.
			this.mediatorMap.mapMatcher(matcher).toMediator(DebugSimpleViewMediator).withGuards(OnlyIfDebugVersionLaunched);
		}

		/**
		 * @private injecting <code>Stage</code> object
		 * @return void
		 */
		private function injectApplicationStage() : void {
			// You can use <code>Injector</code> for mapping classes to specific values (instances of
			// mapped class). Which means, every time you injecting mapped class, specific value will be
			// provided by <code>Injector</code>.
			// Also, you can use named injections. If you pass 'name' for mapping class, you'll be able
			// to access mapped value by named injection. See usage example in <code>InitStageOptions</code> command class
			this.context.injector.map(Stage, "applicationStage").toValue(this.contextView.view.stage);
			
			// Now, when <code>stage</code> object is mapped, we can handle stage initializtion.
			// Otherwise, we'll get a 'missing a mapping' error, thrown by <code>Injector</code> 
			// Initializing <code>Stage</code> object. We need to do it just once
			this.commandMap.map(DemoAppEvent.INIT_STAGE).toCommand(InitStageOptions).once();
		}
	}
}
