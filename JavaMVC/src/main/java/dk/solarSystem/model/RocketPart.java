package dk.solarSystem.model;

public class RocketPart {

    private String name;
    private String objPath;
    private String mtlPath;
    private Integer power;
    private Double positionY;
    private Double positionX;
    private Double positionZ;
    private String rocketPartType;

    public RocketPart(String name, String objPath, String mtlPath, Integer power, Double positionY, Double positionX, Double positionZ, String rocketPartType) {
        this.name = name;
        this.objPath = objPath;
        this.mtlPath = mtlPath;
        this.power = power;
        this.positionY = positionY;
        this.positionX = positionX;
        this.positionZ = positionZ;
        this.rocketPartType = rocketPartType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getObjPath() {
        return objPath;
    }

    public void setObjPath(String objPath) {
        this.objPath = objPath;
    }

    public String getMtlPath() {
        return mtlPath;
    }

    public void setMtlPath(String mtlPath) {
        this.mtlPath = mtlPath;
    }

    public Integer getPower() {
        return power;
    }

    public void setPower(Integer power) {
        this.power = power;
    }

    public Double getPositionY() {
        return positionY;
    }

    public void setPositionY(Double positionY) {
        this.positionY = positionY;
    }

    public Double getPositionX() {
        return positionX;
    }

    public void setPositionX(Double positionX) {
        this.positionX = positionX;
    }

    public Double getPositionZ() {
        return positionZ;
    }

    public void setPositionZ(Double positionZ) {
        this.positionZ = positionZ;
    }

    public String getRocketPartType() {
        return rocketPartType;
    }

    public void setRocketPartType(String rocketPartType) {
        this.rocketPartType = rocketPartType;
    }
}
