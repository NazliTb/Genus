package com.esprit.genus.Model;



import java.util.Date;

public class Chat {
private int idChat;
private String topic;
private Date date;
private String username;

public Chat() {

}

    public Chat(int idChat, String topic, Date date, String username) {
        this.idChat = idChat;
        this.topic = topic;
        this.date = date;
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setIdUser(String username) {
        this.username = username;
    }

    public int getIdChat() {
        return idChat;
    }

    public void setIdChat(int idChat) {
        this.idChat = idChat;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
