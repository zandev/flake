package flake.errors{

	public class ArchitectureError extends Error
  {
    public function ArchitectureError(message:String="", id:int=0)
    {
      super(message, id);
    }
    
  }
}