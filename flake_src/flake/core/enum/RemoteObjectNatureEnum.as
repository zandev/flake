package flake.core.enum
{
  import flake.errors.IllegalConstantInstanciationError;
  
  public class RemoteObjectNatureEnum extends SafeEnum
  {
    public static const AMF:RemoteObjectNatureEnum = new RemoteObjectNatureEnum('AMF');
    public static const XML:RemoteObjectNatureEnum = new RemoteObjectNatureEnum('XML');
    
    { _lock = true }
    private static var _lock:Boolean;
    public function RemoteObjectNatureEnum(identifier:String)
    {
      super(identifier);
      if (_lock) throw new IllegalConstantInstanciationError();
    }
  }
}