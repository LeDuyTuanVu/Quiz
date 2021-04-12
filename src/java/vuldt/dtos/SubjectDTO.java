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
public class SubjectDTO {

    String subjectID;
    String subjectName;
    int numberQuuestion;
    int minute;
    boolean status;

    public SubjectDTO() {

    }

    public SubjectDTO(String subjectID, String subjectName, int numberQuuestion, int minute, boolean status) {
        this.subjectID = subjectID;
        this.subjectName = subjectName;
        this.numberQuuestion = numberQuuestion;
        this.minute = minute;
        this.status = status;
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public int getNumberQuuestion() {
        return numberQuuestion;
    }

    public void setNumberQuuestion(int numberQuuestion) {
        this.numberQuuestion = numberQuuestion;
    }

    public int getMinute() {
        return minute;
    }

    public void setMinute(int minute) {
        this.minute = minute;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
