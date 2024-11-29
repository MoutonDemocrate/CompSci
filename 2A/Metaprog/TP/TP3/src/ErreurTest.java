/** ErreurTest est un programme de test qui d_finit trois m_thodes de test
  * dont une provoque une erreur.
  */
public class ErreurTest {
	
	public void tester1() {
	}

	public void tester2() {
		Assert.assertTrue(false);
	}

	public void tester3() {
		Assert.assertTrue(true);
	}

}
