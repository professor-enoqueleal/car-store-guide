package br.com.carstore.model;

public class Car {

    private String id;
    private String name;
    private String image;

    public Car(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public Car(String id, String name, String image) {
        this.id = id;
        this.name = name;
        this.image = image;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getImage() {
        return image;
    }

}
