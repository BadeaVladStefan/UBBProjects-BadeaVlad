package model;
import exceptions.CustomExceptions;

public class Sphere implements Item{
    private int id;
    private int radius;
    public Sphere(int id,int radius) throws CustomExceptions{
        if(radius <= 0)
            throw new CustomExceptions("Radius cant be less the zero");
        this.id = id;
        this.radius = radius;}
    @Override
    public double getVolume(){
        return ((double) 3 /4)*Math.PI*this.radius*this.radius*this.radius;
    }
    @Override
    public String toString(){
        return "Sphere with the id: " + this.id+ " and the volume: "+ this.getVolume();
    }
    @Override
    public int getId(){return this.id;}
}
