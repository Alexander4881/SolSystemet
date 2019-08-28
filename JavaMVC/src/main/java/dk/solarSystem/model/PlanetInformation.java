package dk.solarSystem.model;

public class PlanetInformation extends Planet {

    private Double mass;
    private String massMeasuringUnit;
    private String massFullMeasuringUnit;
    private String massMeasuringUnitDescription;
    private Double circumference;
    private String circumferenceMeasuringUnit;
    private String circumferenceFullMeasuringUnit;
    private String circumferenceMeasuringUnitDescription;
    private Double diameter;
    private String diameterMeasuringUnit;
    private String diameterFullMeasuringUnit;
    private String diameterMeasuringUnitDescription;
    private String diameterDescription;

    // constructor
    public PlanetInformation(String name, String type, String description, Double mass, String massMeasuringUnit, String massFullMeasuringUnit, String massMeasuringUnitDescription, Double circumference, String circumferenceMeasuringUnit, String circumferenceFullMeasuringUnit, String circumferenceMeasuringUnitDescription, Double diameter, String diameterMeasuringUnit, String diameterFullMeasuringUnit, String diameterMeasuringUnitDescription, String diameterDescription) {
        super(name, type, description);
        this.mass = mass;
        this.massMeasuringUnit = massMeasuringUnit;
        this.massMeasuringUnitDescription = massMeasuringUnitDescription;
        this.circumference = circumference;
        this.circumferenceMeasuringUnit = circumferenceMeasuringUnit;
        this.circumferenceMeasuringUnitDescription = circumferenceMeasuringUnitDescription;
        this.diameter = diameter;
        this.diameterMeasuringUnit = diameterMeasuringUnit;
        this.diameterMeasuringUnitDescription = diameterMeasuringUnitDescription;
        this.massFullMeasuringUnit = massFullMeasuringUnit;
        this.circumferenceFullMeasuringUnit = circumferenceFullMeasuringUnit;
        this.diameterFullMeasuringUnit = diameterFullMeasuringUnit;
        this.diameterDescription = diameterDescription;
    }

    public Double getMass() {
        return mass;
    }

    public void setMass(Double mass) {
        this.mass = mass;
    }

    public String getMassMeasuringUnit() {
        return massMeasuringUnit;
    }

    public void setMassMeasuringUnit(String massMeasuringUnit) {
        this.massMeasuringUnit = massMeasuringUnit;
    }

    public String getMassMeasuringUnitDescription() {
        return massMeasuringUnitDescription;
    }

    public void setMassMeasuringUnitDescription(String massMeasuringUnitDescription) {
        this.massMeasuringUnitDescription = massMeasuringUnitDescription;
    }

    public Double getCircumference() {
        return circumference;
    }

    public void setCircumference(Double circumference) {
        this.circumference = circumference;
    }

    public String getCircumferenceMeasuringUnit() {
        return circumferenceMeasuringUnit;
    }

    public void setCircumferenceMeasuringUnit(String circumferenceMeasuringUnit) {
        this.circumferenceMeasuringUnit = circumferenceMeasuringUnit;
    }

    public String getCircumferenceMeasuringUnitDescription() {
        return circumferenceMeasuringUnitDescription;
    }

    public void setCircumferenceMeasuringUnitDescription(String circumferenceMeasuringUnitDescription) {
        this.circumferenceMeasuringUnitDescription = circumferenceMeasuringUnitDescription;
    }

    public Double getDiameter() {
        return diameter;
    }

    public void setDiameter(Double diameter) {
        this.diameter = diameter;
    }

    public String getDiameterMeasuringUnit() {
        return diameterMeasuringUnit;
    }

    public void setDiameterMeasuringUnit(String diameterMeasuringUnit) {
        this.diameterMeasuringUnit = diameterMeasuringUnit;
    }

    public String getDiameterMeasuringUnitDescription() {
        return diameterMeasuringUnitDescription;
    }

    public void setDiameterMeasuringUnitDescription(String diameterMeasuringUnitDescription) {
        this.diameterMeasuringUnitDescription = diameterMeasuringUnitDescription;
    }

    public String getMassFullMeasuringUnit() {
        return massFullMeasuringUnit;
    }

    public void setMassFullMeasuringUnit(String massFullMeasuringUnit) {
        this.massFullMeasuringUnit = massFullMeasuringUnit;
    }

    public String getCircumferenceFullMeasuringUnit() {
        return circumferenceFullMeasuringUnit;
    }

    public void setCircumferenceFullMeasuringUnit(String circumferenceFullMeasuringUnit) {
        this.circumferenceFullMeasuringUnit = circumferenceFullMeasuringUnit;
    }

    public String getDiameterFullMeasuringUnit() {
        return diameterFullMeasuringUnit;
    }

    public void setDiameterFullMeasuringUnit(String diameterFullMeasuringUnit) {
        this.diameterFullMeasuringUnit = diameterFullMeasuringUnit;
    }

    public String getDiameterDescription() {
        return diameterDescription;
    }

    public void setDiameterDescription(String diameterDescription) {
        this.diameterDescription = diameterDescription;
    }
}
