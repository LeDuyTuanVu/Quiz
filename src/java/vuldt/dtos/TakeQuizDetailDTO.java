/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vuldt.dtos;

/**
 *
 * @author Le Duy Tuan Vu
 */
public class TakeQuizDetailDTO {

    String takeQuizID;
    String quizID;
    String questionID;
    String ansFinal;
    String ansRight;
    boolean status;

    public TakeQuizDetailDTO() {

    }

    public TakeQuizDetailDTO(String takeQuizID, String quizID, String questionID, String ansFinal, String ansRight, boolean status) {
        this.takeQuizID = takeQuizID;
        this.quizID = quizID;
        this.questionID = questionID;
        this.ansFinal = ansFinal;
        this.ansRight = ansRight;
        this.status = status;
    }

    public String getTakeQuizID() {
        return takeQuizID;
    }

    public void setTakeQuizID(String takeQuizID) {
        this.takeQuizID = takeQuizID;
    }

    public String getQuizID() {
        return quizID;
    }

    public void setQuizID(String quizID) {
        this.quizID = quizID;
    }

    public String getQuestionID() {
        return questionID;
    }

    public void setQuestionID(String questionID) {
        this.questionID = questionID;
    }

    public String getAnsFinal() {
        return ansFinal;
    }

    public void setAnsFinal(String ansFinal) {
        this.ansFinal = ansFinal;
    }

    public String getAnsRight() {
        return ansRight;
    }

    public void setAnsRight(String ansRight) {
        this.ansRight = ansRight;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
