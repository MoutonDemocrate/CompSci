import java.net.InetAddress;
import java.rmi.*;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public final class Server {
    private Server() {
    }

    /**
     * Says hello to the world.
     * 
     * @param args The arguments of the program.
     */
    public static void main(String[] args) {
        System.out.println("Starting server...");
        try {
            LocateRegistry.createRegistry(4000);
            CarnetImpl carnet1 = new CarnetImpl();
            CarnetImpl carnet2 = new CarnetImpl();
			carnet1.siblingName = "carnet2";
			carnet2.siblingName = "carnet1";
            String host_adress = "localhost"; //InetAddress.getLocalHost().getHostAddress();
            System.out.println("Server is hosted at : " + host_adress + ":4000");
            Naming.rebind("rmi://" + host_adress + ":4000/carnet1", (Remote) carnet1);
            Naming.rebind("rmi://" + host_adress + ":4000/carnet2", (Remote) carnet2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}