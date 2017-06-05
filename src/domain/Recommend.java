package domain;

/**
 * Created by wontae on 2016. 10. 11..
 */
public class Recommend {

    private int recom_id;
    private int recom;
    private int nonrecom;
    private int ch_id;
    private int user_id;

    public int getRecom_id() {
        return recom_id;
    }

    public void setRecom_id(int recom_id) {
        this.recom_id = recom_id;
    }

    public int getRecom() {
        return recom;
    }

    public void setRecom(int recom) {
        this.recom = recom;
    }

    public int getNonrecom() {
        return nonrecom;
    }

    public void setNonrecom(int nonrecom) {
        this.nonrecom = nonrecom;
    }

    public int getCh_id() {
        return ch_id;
    }

    public void setCh_id(int ch_id) {
        this.ch_id = ch_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
}
