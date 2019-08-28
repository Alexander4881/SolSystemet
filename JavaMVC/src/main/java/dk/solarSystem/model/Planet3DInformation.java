package dk.solarSystem.model;

import java.util.ArrayList;

public class Planet3DInformation extends PlanetInformation {

    private String textureSrc;
    private Double size;
    private Double distanceFromCenter;
    private Double orbitRate;
    private Double rotationSpeed;
    private ArrayList<Moon3DInformation> moons;

    // constructor
    public Planet3DInformation(String name, String type, String description, Double mass, String massMeasuringUnit, String massFullMeasuringUnit, String massMeasuringUnitDescription, Double circumference, String circumferenceMeasuringUnit, String circumferenceFullMeasuringUnit, String circumferenceMeasuringUnitDescription, Double diameter, String diameterMeasuringUnit, String diameterFullMeasuringUnit, String diameterMeasuringUnitDescription, String diameterDescription, String textureSrc, Double size, Double distanceFromCenter, Double orbitRate, Double rotationSpeed) {
        super(name, type, description, mass, massMeasuringUnit, massFullMeasuringUnit, massMeasuringUnitDescription, circumference, circumferenceMeasuringUnit, circumferenceFullMeasuringUnit, circumferenceMeasuringUnitDescription, diameter, diameterMeasuringUnit, diameterFullMeasuringUnit, diameterMeasuringUnitDescription, diameterDescription);
        this.textureSrc = textureSrc;
        this.size = size;
        this.distanceFromCenter = distanceFromCenter;
        this.orbitRate = orbitRate;
        this.rotationSpeed = rotationSpeed;
    }

    public String getTextureSrc() {
        return textureSrc;
    }

    public void setTextureSrc(String textureSrc) {
        this.textureSrc = textureSrc;
    }

    public Double getSize() {
        return size;
    }

    public void setSize(Double size) {
        this.size = size;
    }

    public Double getDistanceFromCenter() {
        return distanceFromCenter;
    }

    public void setDistanceFromCenter(Double distanceFromCenter) {
        this.distanceFromCenter = distanceFromCenter;
    }

    public Double getOrbitRate() {
        return orbitRate;
    }

    public void setOrbitRate(Double orbitRate) {
        this.orbitRate = orbitRate;
    }

    public Double getRotationSpeed() {
        return rotationSpeed;
    }

    public void setRotationSpeed(Double rotationSpeed) {
        this.rotationSpeed = rotationSpeed;
    }

    public ArrayList<Moon3DInformation> getMoons() {
        return moons;
    }

    public void setMoons(ArrayList<Moon3DInformation> moons) {
        this.moons = moons;
    }
}
