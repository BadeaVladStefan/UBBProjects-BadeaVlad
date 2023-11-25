import controller.Controller;
import exceptions.CustomExceptions;
import repository.*;
import view.*;

public class Main {
    public static void main(String[] args) throws CustomExceptions {
        UI ui = new UI(new Controller(new Repository()));
        ui.run();
    }
}