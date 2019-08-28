package dk.solarSystem.model;

public class Moon {
    private String name;
    private String planetName;

    // constructor
    public Moon(String name, String planetName) {
        this.name = name;
        this.planetName = planetName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPlanetName() {
        return planetName;
    }

    public void setPlanetName(String planetName) {
        this.planetName = planetName;
    }
}
