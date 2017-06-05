package domain;

public class Channel
{
    private int ch_id;
    private String ch_name;
    private String nickname;
    private int user_id;
    private String email;

    public int getRecommend() {
        return recommend;
    }

    public void setRecommend(int recommend) {
        this.recommend = recommend;
    }

    public int getNonrecommended() {
        return nonrecommended;
    }

    public void setNonrecommended(int nonrecommended) {
        this.nonrecommended = nonrecommended;
    }

    private int recommend;
    private int nonrecommended;


    public Channel()
    {
    }

    public Channel(int ch_id, String ch_name, String nickname)
    {
        this.ch_id = ch_id;
        this.ch_name = ch_name;
        this.nickname = nickname;
    }
    public int getUser_id() {
        return this.user_id;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getNickname() {
        return this.nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getCh_id() {
        return this.ch_id;
    }

    public void setCh_id(int ch_id)
    {
        this.ch_id = ch_id;
    }

    public String getCh_name() {
        return this.ch_name;
    }

    public void setCh_name(String ch_name) {
        this.ch_name = ch_name;
    }
}