import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.LinkedList;
import java.util.List;

public class CarnetImpl extends UnicastRemoteObject implements Carnet {
	private List<SFiche> fiches = new LinkedList<SFiche>();
	public String siblingName = "";

	public CarnetImpl() throws RemoteException {}

	public void Ajouter(SFiche sf) throws RemoteException {
		System.out.println("Ajouter Called ("+sf.getNom()+", "+sf.getEmail()+")");
		fiches.add(sf);
	}

	public RFiche Consulter(String n, boolean forward) throws RemoteException {
		System.out.println("Consulter Called ("+n+", "+Boolean.toString(forward)+")");
		SFiche item = fiches.stream()
			.filter((SFiche s) -> s.getNom() == n)
			.findFirst()
			.orElse(null);
			
		if (item != null) {
			RFiche rf = new RFicheImpl(
				item.getNom(), 
				item.getEmail()
				);
			return rf;
		} else {
			if (forward) {
				try {
					System.out.println("Name not found ! Consulting sibling...");
					Carnet sibling = (Carnet) Naming.lookup("//localhost:4000/"+siblingName);
					return sibling.Consulter(n, false);
				} catch (Exception e) {
					System.err.println("Sibling call failed !");
					e.printStackTrace();
					return null;
				}
			}
			else {
				System.out.println("Name not found ! Returning null...");
				return null;
			}
		}
	}


	public SFiche[] GetAll(boolean forward) throws RemoteException {
		System.out.println("GetAll Called ("+Boolean.toString(forward)+")");
		return (SFiche[]) fiches.toArray();
	}

	public String MakeString(boolean forward) throws RemoteException {
		System.out.println("toString Called ("+Boolean.toString(forward)+")");
		return fiches.stream()
			.map((SFiche sf) -> "("+sf.getNom()+","+sf.getEmail()+")")
			.reduce((String accum, String el) -> accum + "\n" + el)
			.orElse("Nothing !");
	}
}
