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
public class HistoryDTO {

    String takeQuizID;
    String quizID;
    String email;
    float total;
    String makeQuizDate;
    boolean status;

    public HistoryDTO() {

    }

    public HistoryDTO(String takeQuizID, String quizID, String email, float total, String makeQuizDate, boolean status) {
        this.takeQuizID = takeQuizID;
        this.quizID = quizID;
        this.email = email;
        this.total = total;
        this.makeQuizDate = makeQuizDate;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getMakeQuizDate() {
        return makeQuizDate;
    }

    public void setMakeQuizDate(String makeQuizDate) {
        this.makeQuizDate = makeQuizDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
