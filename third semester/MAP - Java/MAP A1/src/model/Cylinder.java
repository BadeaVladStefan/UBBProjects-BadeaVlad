package model;
import java.lang.Math.*;
import exceptions.CustomExceptions;

public class Cylinder implements Item{
    private int id;
    private int radius;
    private int heigth;
    public Cylinder(int id,int height,int radius) throws CustomExceptions{
        if(height<=0 || radius <=0)
            throw new CustomExceptions("Height or radius cant be less then zero");
        this.id = id;
        this.heigth = height;
        this.radius = radius;
    }
    @Override
    public double getVolume(){
        return Math.PI*this.radius*this.radius*this.heigth;
    }
    @Override
    public String toString(){
        return "Cylinder with the id: " + this.id+ " and the volume: " + this.getVolume();
    }
    @Override
    public int getId(){return this.id;}
}
