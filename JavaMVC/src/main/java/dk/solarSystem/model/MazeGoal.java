package dk.solarSystem.model;

public class MazeGoal {

    private String planetName;
    private String imgSrc;
    private String questionType;
    private String questionText;
    private String answer;

    public MazeGoal(String planetName, String imgSrc, String questionType, String questionText, String answer) {
        this.planetName = planetName;
        this.imgSrc = imgSrc;
        this.questionType = questionType;
        this.questionText = questionText;
        this.answer = answer;
    }

    public String getPlanetName() {
        return planetName;
    }

    public void setPlanetName(String planetName) {
        this.planetName = planetName;
    }

    public String getImgSrc() {
        return imgSrc;
    }

    public void setImgSrc(String imgSrc) {
        this.imgSrc = imgSrc;
    }

    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}

