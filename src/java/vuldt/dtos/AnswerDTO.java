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
public class AnswerDTO {

    String answerID;
    String answerContent;
    boolean answerCorrect;
    String questionID;
    boolean status;

    public AnswerDTO() {

    }

    public AnswerDTO(String answerID, String answerContent, boolean answerCorrect, String questionID, boolean status) {
        this.answerID = answerID;
        this.answerContent = answerContent;
        this.answerCorrect = answerCorrect;
        this.questionID = questionID;
        this.status = status;
    }

    public String getAnswerID() {
        return answerID;
    }

    public void setAnswerID(String answerID) {
        this.answerID = answerID;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    public boolean isAnswerCorrect() {
        return answerCorrect;
    }

    public void setAnswerCorrect(boolean answerCorrect) {
        this.answerCorrect = answerCorrect;
    }

    public String getQuestionID() {
        return questionID;
    }

    public void setQuestionID(String questionID) {
        this.questionID = questionID;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
