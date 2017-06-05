package domain;

public class Message {

	private int m_id;
	private String title;
	private String content;
	private String since;
	private int send_user;
	private int receive_user;
	private boolean is_read;
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSince() {
		return since;
	}
	public void setSince(String since) {
		this.since = since;
	}
	public int getSend_user() {
		return send_user;
	}
	public void setSend_user(int send_user) {
		this.send_user = send_user;
	}
	public int getReceive_user() {
		return receive_user;
	}
	public void setReceive_user(int receive_user) {
		this.receive_user = receive_user;
	}
	public boolean isIs_read() {
		return is_read;
	}
	public void setIs_read(boolean is_read) {
		this.is_read = is_read;
	}
}
