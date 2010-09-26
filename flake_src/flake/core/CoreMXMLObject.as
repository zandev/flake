package flake.core
{
  import mx.core.IMXMLObject;

  public class CoreMXMLObject extends CoreBindableObject implements IMXMLObject
  {
    
    private var _document:Object;
    public function initialized(document:Object, id:String):void
    {
      _document = document;
    }
    
  }
}