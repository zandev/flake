package flake.core.rest
{
	import app.controllers.ApplicationController;
	import app.locators.Locators;
	
	import flake.core.BaseState;
	import flake.core.Inflector;
	
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.rpc.AsyncResponder;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;
	
	[AbstractClass]
	public class BaseController extends EventDispatcher implements RestCallBacks
	{

		/**
		 *  remoteModel
		 */
		private var _remoteModel:RemoteObject;

		protected function get remoteModel():RemoteObject
		{
			!_remoteModel ? _remoteModel = Locators.services[modelName.toLowerCase()] : null;
			return _remoteModel;
		}

		/**
		 *  localModel
		 */
		protected function get localModel():Object
		{
			return Locators.models[modelName.toLowerCase()];
		}

		protected function set localModel(value:Object):void
		{
			Locators.models[modelName.toLowerCase()] = value;
		}

		/**
		 *  localModels
		 */
		protected function get localModels():ArrayCollection
		{
			return Locators.models[Inflector.pluralize(modelName).toLowerCase()];
		}

		protected function set localModels(value:ArrayCollection):void
		{
			Locators.models[Inflector.pluralize(modelName).toLowerCase()] = value;
		}

		/**
		 * 	stateInstance
		 */
		private var _stateInstance:BaseState;

		protected function get stateInstance():BaseState
		{
			!_stateInstance ? _stateInstance = Locators.states[Inflector.pluralize(modelName.toLowerCase())] : null;
			return _stateInstance;
		}

		/**
		 * 	stateClass
		 */
		private var _stateClass:Class;

		protected function get stateClass():Class
		{
			!_stateClass ? _stateClass = getDefinitionByName('app.states.' + Inflector.pluralize(modelName) + 'State')as Class : null;
			return _stateClass;
		}

		private function applicationComplete(e:FlexEvent):void
		{
			try
			{
				_remoteModel = Locators.services[modelName.toLowerCase()];
			}
			catch (e:ReferenceError)
			{
				if (this is ApplicationController)
					return ;
				else
					throw e;
			}
		}

		/**
		 * 	controllerName
		 */
		private var _controllerName:String;

		public function get controllerName():String
		{
			if (!_controllerName)
			{
				_controllerName = getQualifiedClassName(this).split("::")[1]as String;
			}
			return _controllerName;
		}

		/**
		 * 	modelName
		 */
		private var _modelName:String;

		public function get modelName():String
		{
			if (!_modelName)
			{
				_modelName = Inflector.singularize(controllerName.split('Controller')[0]);
			}
			return _modelName;
		}

		/**
		 * 	modelClass
		 */
		private var _modelClass:Class;

		public function get modelClass():Class
		{
			if (!_modelClass)
			{
				_modelClass = getDefinitionByName('app.models.' + modelName)as Class;
			}
			return _modelClass;
		}

		/**
		 * 	Actions
		 */
		protected function sendAction(action:String, params:Object, responder:IResponder):void
		{
			Rest.validateAction(action);
			Operation(remoteModel[action]).send(params).addResponder(responder);
		}

		/**
		 *
		 * INDEX
		 *
		 * */
		protected var indexResponder:IResponder;

		public function index(params:Object = null, responder:IResponder = null):void
		{
			indexResponder = new AsyncResponder(indexResultHandler, indexFaultHandler);
			beforeIndex();
			sendAction(Rest.INDEX, params, responder ? responder : indexResponder);
		}

		protected function indexResultHandler(result:Object, token:Object = null):void
		{
			localModels = ResultEvent(result).result as ArrayCollection;
		}

		protected function indexFaultHandler(error:Object, token:Object = null):void
		{
		//Log it
		}

		/**
		 *
		 * SHOW
		 *
		 * */
		protected var showResponder:IResponder;

		public function show(params:Object = null, responder:IResponder = null):void
		{
			showResponder = new AsyncResponder(showResultHandler, showFaultHandler);
			beforeShow();
			sendAction(Rest.SHOW, params, responder ? responder : showResponder);
		}

		protected function showResultHandler(result:Object, token:Object = null):void
		{
			localModel = ResultEvent(result).result as modelClass;
		}

		protected function showFaultHandler(error:Object, token:Object = null):void
		{
		//Log it
		}

		/**
		 *
		 * CREATE
		 *
		 * */
		protected var createResponder:IResponder;

		public function create(params:Object = null, responder:IResponder = null):void
		{
			createResponder = new AsyncResponder(createResultHandler, createFaultHandler);
			beforeCreate();
			sendAction(Rest.CREATE, params, responder ? responder : createResponder);
		}

		protected function createResultHandler(result:Object, token:Object = null):void
		{
			localModel = ResultEvent(result).result as modelClass;
		}

		protected function createFaultHandler(error:Object, token:Object = null):void
		{
		//Log it
		}

		/**
		 *
		 * UPDATE
		 *
		 * */
		protected var updateResponder:IResponder;

		public function update(params:Object = null, responder:IResponder = null):void
		{
			updateResponder = new AsyncResponder(updateResultHandler, updateFaultHandler);
			beforeUpdate()
			sendAction(Rest.UPDATE, params, responder ? responder : updateResponder);
		}

		protected function updateResultHandler(result:Object, token:Object = null):void
		{
			localModel = ResultEvent(result).result as modelClass;
		}

		protected function updateFaultHandler(error:Object, token:Object = null):void
		{
		//Log it
		}

		/**
		 *
		 * DESTROY
		 *
		 * */
		protected var destroyResponder:IResponder;

		public function destroy(params:Object = null, responder:IResponder = null):void
		{
			destroyResponder = new AsyncResponder(destroyResultHandler, destroyFaultHandler);
			beforeDestroy()
			sendAction(Rest.DESTROY, params, responder ? responder : destroyResponder);
		}

		protected function destroyResultHandler(result:Object, token:Object = null):void
		{
			localModel = ResultEvent(result).result as modelClass;
		}

		protected function destroyFaultHandler(error:Object, token:Object = null):void
		{
		//Log it
		}

		/**
		 *
		 * Local models
		 *
		 */

		public function clearModel():void
		{
			localModel = new modelClass();
		}

		public function clearModels():void
		{
			localModels = new ArrayCollection();
		}

		/**
		 *
		 * CallBacks
		 *
		 */

		public function beforeIndex():void
		{

		}

		public function afterIndex(event:ResultEvent):void
		{
			stateInstance.state = Rest.INDEX;
		}

		public function beforeShow():void
		{

		}

		public function afterShow(event:ResultEvent):void
		{
			stateInstance.state = Rest.SHOW;
		}


		public function beforeCreate():void
		{

		}

		public function afterCreate(event:ResultEvent):void
		{

		}

		public function beforeUpdate():void
		{

		}

		public function afterUpdate(event:ResultEvent):void
		{

		}

		public function beforeDestroy():void
		{

		}

		public function afterDestroy(event:ResultEvent):void
		{

		}

	}
}
