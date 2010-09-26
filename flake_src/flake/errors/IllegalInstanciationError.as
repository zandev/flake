
package flake.errors
{
	import flash.errors.IllegalOperationError;					

	/**
	 * ...
	 * @author Stéphane Robert Richard, kabnot@gmail.com
	 */
	public class IllegalInstanciationError extends IllegalOperationError {

		
		public function IllegalInstanciationError (message : String = "You can't instanciate this class this way", id : int = 0) {
			super( message, id );
		}
	}
}