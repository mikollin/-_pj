package domain;

import java.sql.Timestamp;

public class Comments {
    private Integer commentId;
    private Integer imageId;
    private Integer uid;
    private String comment;
    private Timestamp commentDate;
    private Integer favoredNum;

    public Comments(){}


    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public Timestamp getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Timestamp commentDate) {
        this.commentDate = commentDate;
    }

    public Integer getFavoredNum() {
        return favoredNum;
    }

    public void setFavoredNum(Integer favoredNum) {
        this.favoredNum = favoredNum;
    }
}
