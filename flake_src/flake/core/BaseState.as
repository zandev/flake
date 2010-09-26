package flake.core
{
  
  import flake.ObjectUtils;
  import flake.errors.IllegalConstantError;
  
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  
  import mx.core.IMXMLObject;
  
  
  public class BaseState extends EventDispatcher implements IMXMLObject 
  {
    private static var initialState:String;
    protected static function initState(value:String):void
    {
    	initialState = value;
    }
    
    private var _consts:Dictionary;
    
    public function BaseState()
    {
      if (! _consts)
        _consts = ObjectUtils.getConstsNames(this);
    }
    
    private var _document:Object;
    public function initialized(document:Object, id:String):void
    {
      _document = document;
    }
    
    private var _state:String = initialState;
    
    [Bindable('stateChanged')] 
    public function set state(value:String):void
    {
      if (! (value in _consts) )
        throw new IllegalConstantError(value, ObjectUtils.getClass(this) );
//      if (_state != value) 
//      {
        _state = value;
        dispatchEvent(new Event('stateChanged'));
//      }
    }
    
    public function get state():String
    {
      return _state;
    }    
  }
}