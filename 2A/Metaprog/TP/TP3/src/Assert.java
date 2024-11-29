/** La classe Assert d_finit des m_thodes de v_rification.  Pour l'instant, la
 * seule m_thode de v_rification est assertTrue mais d'autres pourraient _tre
 * d_finies (voir JUnit).
 *
 * @author	Xavier Cr_gut
 * @version	$Revision: 1.1 $
 */
abstract public class Assert {

	/** V_rifier que la condition est vraie.
	 * @param condition la condition _ v_rifier
	 */
	static public void assertTrue(boolean condition) {
		if (! condition) {
			throw new Echec();
		}
	}

}
