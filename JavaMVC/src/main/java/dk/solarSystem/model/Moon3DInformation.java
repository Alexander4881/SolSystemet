package dk.solarSystem.model;

public class Moon3DInformation extends Moon {

    private String textureSrc;
    private Double size;
    private Double distanceFromPlanet;
    private Double orbitRate;
    private Double rotationRate;
    private Double orbitSize;
    private Double innerSize;
    private Integer faceRoundness;
    private Integer faceDigRound;
    private String color;

    // constructor
    public Moon3DInformation(String name, String planetName, String textureSrc, Double size, Double distanceFromPlanet, Double orbitRate, Double rotationRate, Double orbitSize, Double innerSize, Integer faceRoundness, Integer faceDigRound, String color) {
        super(name, planetName);
        this.textureSrc = textureSrc;
        this.size = size;
        this.distanceFromPlanet = distanceFromPlanet;
        this.orbitRate = orbitRate;
        this.rotationRate = rotationRate;
        this.innerSize = innerSize;
        this.faceRoundness = faceRoundness;
        this.faceDigRound = faceDigRound;
        this.color = color;
        this.orbitSize = orbitSize;
    }

    public Double getRotationRate() {
        return rotationRate;
    }

    public void setRotationRate(Double rotationRate) {
        this.rotationRate = rotationRate;
    }

    public Double getOrbitRate() {
        return orbitRate;
    }

    public void setOrbitRate(Double orbitRate) {
        this.orbitRate = orbitRate;
    }

    public Double getDistanceFromPlanet() {
        return distanceFromPlanet;
    }

    public void setDistanceFromPlanet(Double distanceFromPlanet) {
        this.distanceFromPlanet = distanceFromPlanet;
    }

    public Double getSize() {
        return size;
    }

    public void setSize(Double size) {
        this.size = size;
    }

    public String getTextureSrc() {
        return textureSrc;
    }

    public void setTextureSrc(String textureSrc) {
        this.textureSrc = textureSrc;
    }

    public Double getInnerSize() {
        return innerSize;
    }

    public void setInnerSize(Double innerSize) {
        this.innerSize = innerSize;
    }

    public Integer getFaceRoundness() {
        return faceRoundness;
    }

    public void setFaceRoundness(Integer faceRoundness) {
        this.faceRoundness = faceRoundness;
    }

    public Integer getFaceDigRound() {
        return faceDigRound;
    }

    public void setFaceDigRound(Integer faceDigRound) {
        this.faceDigRound = faceDigRound;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Double getOrbitSize() {
        return orbitSize;
    }

    public void setOrbitSize(Double orbitSize) {
        this.orbitSize = orbitSize;
    }
}
