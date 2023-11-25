package controller;
import exceptions.CustomExceptions;
import repository.IRepository;
import model.Item;

import java.util.ArrayList;
import java.util.List;

public class Controller {
    private IRepository repository;
    public Controller(IRepository repository){this.repository=repository;}
    public void addToRepo(Item item) throws CustomExceptions {repository.add(item);}
    public void removeFromRepo(Item item){repository.remove(item);}
    public Item[] getAll(){return repository.getAll();}
    public List<Item> filterRepo(int minVolume){

        List<Item> result = new ArrayList<>();
        Item[] all = repository.getAll();
        for(int i = 0; i < repository.size(); i++)
        {
            Item item = all[i];
            if(item.getVolume() > minVolume)
                result.add(item);
        }
        return result;
    }
}
