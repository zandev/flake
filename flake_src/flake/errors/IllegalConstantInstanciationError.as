package flake.errors
{
  public class IllegalConstantInstanciationError extends Error
  {
    public function IllegalConstantInstanciationError(message:String="", id:int=0)
    {
      super(message, id);
    }
    
  }
}