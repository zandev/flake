package flake.errors
{
  public class RemoteOperationError extends Error
  {
    public function RemoteOperationError(message:String="The result of the remote operation is unexpected", id:int=0)
    {
      super(message, id);
    }
    
  }
}