package classes;
import java.io.Serializable;
import java.rmi.Remote;
import java.rmi.RemoteException;

public interface DeliveryPointInterface extends Remote {
    public DeliveryPoint sortAndSaveUnique(DeliveryPoint deliveryPoint) throws RemoteException;
}
