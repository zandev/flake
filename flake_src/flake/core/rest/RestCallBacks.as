package flake.core.rest
{
	import mx.rpc.events.ResultEvent;
	
	public interface RestCallBacks
	{
		function beforeIndex():void
		function beforeShow():void
		function beforeUpdate():void
		function beforeDestroy():void
		function beforeCreate():void
		
		function afterIndex(event:ResultEvent):void
		function afterShow(event:ResultEvent):void
		function afterUpdate(event:ResultEvent):void
		function afterDestroy(event:ResultEvent):void
		function afterCreate(event:ResultEvent):void
	}
}