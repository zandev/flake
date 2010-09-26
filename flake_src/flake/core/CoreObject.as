package flake.core
{
  import flake.ObjectUtils;
  
  import flash.events.EventDispatcher;
  
  public class CoreObject extends EventDispatcher implements IComparable
  {
    
    public function dump():String
    {
      return ObjectUtils.dumpObject(this);
    }
    
    public function equals(comparable:IComparable):Boolean
    {
      if (! comparable) return false;
      if (comparable === this) return true;
      return (comparable as CoreObject).dump() == dump();
    }
    
    public function clone():CoreObject
    {
      return ObjectUtils.clone(this);
    }
    
  }
}