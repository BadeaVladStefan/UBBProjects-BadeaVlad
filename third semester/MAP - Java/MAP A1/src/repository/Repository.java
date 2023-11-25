package repository;
import model.Item;
import exceptions.DuplicateIdException;
import exceptions.CustomExceptions;


public class Repository implements IRepository{
    private Item[] items;
    private int size;
    public Repository(){
        items = new Item[100];
        size = 0;
    }
    @Override
    public void add(Item item) throws CustomExceptions {
        for (int i = 0; i < this.size; i++) {
            if (this.items[i] != null && this.items[i].getId() == item.getId()) {
                throw new DuplicateIdException("Item with ID " + item.getId() + " already exists.");
            }
        }
        items[size++] = item;
    }
    @Override
    public void remove(Item item)
    {
        for(int i = 0 ; i < this.size;i++)
        {
            if(this.items[i] != null && this.items[i].getId() == item.getId()) {
                for (int j = i; j < this.size - 1; j++) {
                    this.items[j] = this.items[j + 1];
                }
                this.items[this.size-1] = null;
                this.size--;
                break;
            }
        }
    }

    @Override
    public Item[] getAll(){return this.items;}
    @Override
    public int size(){return this.size;}

}
