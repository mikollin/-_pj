package domain;

import java.sql.Timestamp;

public class Picture {
    private String path;
    private String countryCode;
    private Integer cityCode;
    private String author;
    private String content;
    private String title;
    private String description;
    private String country;
    private String city;
    private Timestamp uploadDate;  //???
    private Integer imageId;
    private Integer authorId;
    private Integer favoredNum;

    public Picture(){

    }
    public Picture(String title,String description,String path,String city,String country,
                   String content,String author){
        this.title=title;
        this.description=description;
        this.path=path;
        this.city=city;
        this.country=country;
        this.content=content;
        this.author=author;
    }


    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }


    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }

    public Integer getCityCode() {
        return cityCode;
    }

    public void setCityCode(Integer cityCode) {
        this.cityCode = cityCode;
    }

    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    public Integer getFavoredNum() {
        return favoredNum;
    }

    public void setFavoredNum(Integer favoredNum) {
        this.favoredNum = favoredNum;
    }
}
