package flake.core
{
  import flake.ObjectUtils;
  
  import mx.events.PropertyChangeEvent;
  
  public class CoreBindableObject extends CoreObject
  {
    
    /**
    *   checkEquals
    */
    private var _checkEquals:Boolean = false;
    
    public function set checkEquals(value:Boolean):void
    {
      _checkEquals = value;
      if (_checkEquals)
      {
        removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, _onPropertyChange);
        addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, _onPropertyChange, false, 0xFFFFFF);
      }
      else
      {
        removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, _onPropertyChange);
      }
    }
    public function get checkEquals():Boolean
    {
      return _checkEquals;
    }
    
    private function _onPropertyChange(e:PropertyChangeEvent):void
    {
      if (_dumpObject(e.oldValue) == _dumpObject(e.newValue) )
        e.stopImmediatePropagation();
    }
    
    private function _dumpObject(o:*):String
    {
      return ObjectUtils.dumpObject(o);
    }
  }
}