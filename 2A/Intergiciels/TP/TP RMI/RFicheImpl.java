import java.rmi.*;

public class RFicheImpl implements RFiche {

	private String nom;
	private String email;

	public RFicheImpl(String n, String e) {
		this.nom = n;
		this.email = e;
	}

	public String getNom () throws RemoteException {
		return this.nom;
	}
	public String getEmail () throws RemoteException {
		return this.email;
	}
}



