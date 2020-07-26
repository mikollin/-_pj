package domain;

import java.sql.Timestamp;

public class Invitation {
    private Integer invitationId;
    private Integer senderId;
    private Integer receiverId;
    private String invitationState;
    private Timestamp sendDate;

    public Invitation(){

    }


    public Integer getInvitationId() {
        return invitationId;
    }

    public void setInvitationId(Integer invitationId) {
        this.invitationId = invitationId;
    }

    public Integer getSenderId() {
        return senderId;
    }

    public void setSenderId(Integer senderId) {
        this.senderId = senderId;
    }


    public Integer getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(Integer receiverId) {
        this.receiverId = receiverId;
    }

    public String getInvitationState() {
        return invitationState;
    }

    public void setInvitationState(String invitationState) {
        this.invitationState = invitationState;
    }

    public Timestamp getSendDate() {
        return sendDate;
    }

    public void setSendDate(Timestamp sendDate) {
        this.sendDate = sendDate;
    }
}
