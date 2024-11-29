/** L'exception Echec permet de signaler l'erreur fonctionnelle d'un test.
 * @author	Xavier Cr_gut
 * @version	$Revision: 1.1 $
 */
public class Echec extends Error {
	public Echec() {
		super("condition non v_rifi_e");
	}
	public Echec(String message) {
		super(message);
	}
}
