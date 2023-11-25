package view;
import controller.Controller;
import exceptions.CustomExceptions;
import model.*;
import exceptions.DuplicateIdException;
import java.util.List;
import java.util.Scanner;

public class UI {
    private Controller controller;
    public UI(Controller controller) {this.controller = controller;}
    public void printMenu(){
        System.out.println("1.Add shape");
        System.out.println("2.Remove shape");
        System.out.println("3.Get all shapes");
        System.out.println("4.Filter shapes");
        System.out.println("5.Add some shapes");
        System.out.println("0.Quit");
    }

    public void printSubmenu(){
        System.out.println("1.Cube");
        System.out.println("2.Cylinder");
        System.out.println("3.Sphere");
    }
    public void run() throws CustomExceptions {
        int choice = 0;
        Scanner sc = new Scanner(System.in);
        do{
            this.printMenu();
            choice = sc.nextInt();
            switch (choice)
            {
                default:
                    System.out.println("Error");
                    break;
                case 0:
                    break;
                case 1:
                    printSubmenu();
                    int addChoice =  sc.nextInt();
                    if(addChoice == 1)
                    {
                        try{
                            System.out.println("Id:");
                            int id = sc.nextInt();
                            Item[] allItems = controller.getAll();
                            for (Item item : allItems) {
                                if (item != null && item.getId() == id) {
                                    throw new DuplicateIdException("Item with ID " + id + " already exists.");
                                }
                            }
                            System.out.println("Side length:");
                            int sl = sc.nextInt();
                            Cube cube = new Cube(id,sl);
                            controller.addToRepo(cube);
                            System.out.println("Added!");
                        } catch (CustomExceptions  e) {
                                System.out.println(e.getMessage());
                        }

                    }
                    else if(addChoice == 2)
                    {
                        try{
                            System.out.println("Id:");
                            int id = sc.nextInt();
                            Item[] allItems = controller.getAll();
                            for (Item item : allItems) {
                                if (item != null && item.getId() == id) {
                                    throw new DuplicateIdException("Item with ID " + id + " already exists.");
                                }
                            }
                            System.out.println("Height:");
                            int ht = sc.nextInt();
                            System.out.println("Radius:");
                            int rad = sc.nextInt();
                            Cylinder cylinder = new Cylinder(id,ht,rad);
                            controller.addToRepo(cylinder);
                            System.out.println("Added!");
                        }catch (CustomExceptions e){
                            System.out.println(e.getMessage());
                        }
                    }
                    else if(addChoice == 3)
                    {
                        try {
                            System.out.println("Id:");
                            int id = sc.nextInt();
                            Item[] allItems = controller.getAll();
                            for (Item item : allItems) {
                                if (item != null && item.getId() == id) {
                                    throw new DuplicateIdException("Item with ID " + id + " already exists.");
                                }
                            }
                            System.out.println("Radius:");
                            int rad = sc.nextInt();
                            Sphere sphere = new Sphere(id,rad);
                            controller.addToRepo(sphere);
                            System.out.println("Added!");
                        }catch(CustomExceptions e){
                            System.out.println(e.getMessage());
                        }
                    }else System.out.println("Error");
                    break;
                case 2:
                    System.out.println("Id for the Item that is to be removed:");
                    int id = sc.nextInt();
                    boolean ok = false;
                    Item[] allItems = controller.getAll();
                    for(int i = 0; i < allItems.length; i++) {
                        if(allItems[i] != null && allItems[i].getId() == id) {
                            controller.removeFromRepo(allItems[i]);
                            System.out.println("Item removed!");
                            ok = true;
                            break;

                        }
                    }
                    if(ok == false)
                        System.out.println("Item with the given id not found!");
                    break;


                case 3:
                    Item[] all =controller.getAll();
                    for(Item item : all)
                        if(item != null)
                            System.out.println(item.toString());
                        else continue;
                        break;

                case 4:
                    int volume = 25;
                    List<Item> result = controller.filterRepo(volume);
                    for(Item item : result)
                        System.out.println(item.toString());
                    System.out.println("Filtered Items");
                    break;
                case 5:
                    Sphere sphere = new Sphere(1,5);
                    Cylinder cylinder = new Cylinder(2,5,5);
                    Cube cube = new Cube(3,2);
                    controller.addToRepo(sphere);
                    controller.addToRepo(cylinder);
                    controller.addToRepo(cube);
                    System.out.println("Shapes added!");
                    break;

            }
        }while(choice!=0);
        sc.close();
    }
}