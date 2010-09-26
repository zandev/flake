package flake.core.rest
{
	import flash.errors.IllegalOperationError;
	
	public class Rest
	{
		/**
	    * 
	    * CRUD REST
	    * 
	    */
	    
	    public static const INDEX   :String = "index";
	    public static const SHOW    :String = "show";
	    public static const CREATE  :String = "create";
	    public static const UPDATE  :String = "update";
	    public static const DESTROY :String = "destroy";
	    
	    public static const ACTIONS :Array  = [INDEX, SHOW, CREATE, UPDATE, DESTROY];
		
		public static function validateAction(action:String):void
	    {
	      if (ACTIONS.indexOf(action) == -1) throw new IllegalOperationError(action + " is not a know REST action. Currently supported actions are " + ACTIONS.toString() );
	    }
	}
}