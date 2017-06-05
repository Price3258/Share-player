package domain;

public class Song
{
    private int song_id;
    private String song_link;
    private String song_name;
    private String singer;

    public Song()
    {
    }

    public Song(int song_id, String song_link, String song_name)
    {
        this.song_id = song_id;
        this.song_link = song_link;
        this.song_name = song_name;
    }

    public int getSong_id() {
        return this.song_id;
    }

    public void setSong_id(int song_id) {
        this.song_id = song_id;
    }

    public String getSong_link() {
        return this.song_link;
    }

    public void setSong_link(String song_link) {
        this.song_link = song_link;
    }

    public String getSong_name() {
        return this.song_name;
    }

    public void setSong_name(String song_name) {
        this.song_name = song_name;
    }

    public String getSinger() {
        return this.singer;
    }

    public void setSinger(String singer) {
        this.singer = singer;
    }
}