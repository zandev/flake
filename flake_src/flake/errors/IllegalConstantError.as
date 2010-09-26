package flake.errors
{
  import flash.utils.getQualifiedClassName;
  
  public class IllegalConstantError extends Error
  {
    public function IllegalConstantError(value:String, klass:Class)
    {
      var message:String = "Wrong const " + value + " in " + getQualifiedClassName(klass);
      super(message);
    }
  }
}