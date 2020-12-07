package com.esprit.genus.Model;

import java.util.Date;

public class Message {

    private int idMessage;
    private String contentMsg;
    private Date date;
    private int idUser;
    private int idChat;
    private boolean isSelf;

    public Message() {
    }

    public Message(int idMessage, String contentMsg, Date date, int idUser, int idChat, boolean isSelf) {
        this.idMessage = idMessage;
        this.contentMsg = contentMsg;
        this.date = date;
        this.idUser = idUser;
        this.idChat = idChat;
        this.isSelf = isSelf;
    }

    public int getIdMessage() {
        return idMessage;
    }

    public void setIdMessage(int idMessage) {
        this.idMessage = idMessage;
    }

    public String getContentMsg() {
        return contentMsg;
    }

    public void setContentMsg(String contentMsg) {
        this.contentMsg = contentMsg;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdChat() {
        return idChat;
    }

    public void setIdChat(int idChat) {
        this.idChat = idChat;
    }

    public boolean isSelf() {
        return isSelf;
    }

    public void setSelf(boolean self) {
        isSelf = self;
    }
}
