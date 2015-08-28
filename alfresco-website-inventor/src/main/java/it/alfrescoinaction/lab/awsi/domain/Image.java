package it.alfrescoinaction.lab.awsi.domain;

public class Image implements Content {

    private String id;
    private String name;
    private String description;
    private String mimeType;
    private String thumbnail;
    private String url;
    private ContentType type  = ContentType.IMAGE;

    public Image (String id, String name, String description, String mimeType) {

        this.id = id;
        this.name = name;
        this.description = description;
        this.mimeType = mimeType;
    }

    @Override
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String getMimeType() {
        return this.mimeType;
    }

    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }

    @Override
    public String getText() {
        return "";
    }

    @Override
    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    @Override
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public ContentType getType() {
        return type;
    }

    public String getType2() {
        return "IMAGE";
    }
}