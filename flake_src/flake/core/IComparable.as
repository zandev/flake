package flake.core
{
  public interface IComparable extends IDumpable
  {
    function equals(comparable:IComparable):Boolean;
  }
}