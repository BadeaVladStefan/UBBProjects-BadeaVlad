package model;
import exceptions.CustomExceptions;


public class Cube implements Item{
    private int id;
    private int sideLength;
    public Cube(int id,int sideLength) throws CustomExceptions{
        if(sideLength <= 0)
            throw new CustomExceptions("Side Length cant be less then zero");
        this.id = id;
        this.sideLength = sideLength;
    }
    @Override
    public double getVolume(){
        return this.sideLength*this.sideLength*this.sideLength;
    }
    @Override
    public String toString(){
        return "Cube with the id : " + this.id +" and the volume: " + this.getVolume();
    }
    @Override
    public int getId(){return this.id;}


}
