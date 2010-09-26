
package flake.core.enum
{
  import flake.ObjectUtils;
  import flake.core.CoreObject;
  
	public class SafeEnum extends CoreObject implements ISafeEnum {

		public function SafeEnum (identifier : String) {
			_identifier = identifier;
		}

		private var _identifier : String;
		
		public function get identifier():String
		{
		  return _identifier;
		}
	}
}
