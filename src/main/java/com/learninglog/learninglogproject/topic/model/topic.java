package com.learninglog.learninglogproject.topic.model;

import java.security.Timestamp;

public class topic {
    private int id;

    public topic(int id, String topic, int userid, Timestamp created_at) {
        this.id = id;
        this.topic = topic;
        this.userid = userid;
        this.created_at = created_at;
    }

    private String topic;
    private int userid;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    private Timestamp created_at;
}
