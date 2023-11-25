package repository;
import model.Item;
import exceptions.DuplicateIdException;
import exceptions.CustomExceptions;

public interface IRepository {

    void add(Item item) throws CustomExceptions;

    void remove(Item item);
    Item[] getAll();
    int size();
}
